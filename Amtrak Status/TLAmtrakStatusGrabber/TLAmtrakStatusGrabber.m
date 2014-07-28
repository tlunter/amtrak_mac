//
//  TLAmtrakStatusGrabber.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLAmtrakStatusGrabber.h"

@implementation TLAmtrakStatusGrabber

@synthesize dateFormatter, home, work;

- (id)initWithHome:(NSString*)newHome andWork:(NSString*)newWork {
    self = [super init];
    
    if (self) {
        [self setHome:newHome];
        [self setWork:newWork];
        [self setDateFormatter:[[NSDateFormatter alloc] init]];
        [[self dateFormatter] setDateFormat:@"EEE, MMM d, yyyy"];
    }

    return self;
}

- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        encodedValue = [encodedValue stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        encodedKey = [encodedKey stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    encodedDictionary = [encodedDictionary stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
    encodedDictionary = [encodedDictionary stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSDictionary *)baseParams {
    static NSMutableDictionary *params = nil;
    
    if (params == nil) {
        params = [[NSMutableDictionary alloc] init];
        
        [params setObject:@"/sessionWorkflow/productWorkflow[@product='Rail']/travelSelection/journeySelection[1]/departLocation/search" forKey:@"xwdf_origin"];
        [params setObject:@"/sessionWorkflow/productWorkflow[@product='Rail']/travelSelection/journeySelection[1]/arriveLocation/search" forKey:@"xwdf_destination"];
        [params setObject:@"amtrak.presentation.handler.page.rail.AmtrakRailGetTrainStatusPageHandler" forKey:@"requestor"];
        [params setObject:@"/sessionWorkflow/productWorkflow[@product='Rail']/tripRequirements/journeyRequirements[1]/segmentRequirements[1]/serviceCode" forKey:@"xwdf_trainNumber"];
        [params setObject:@"optional" forKey:@"wdf_trainNumber"];
        [params setObject:@"" forKey:@"_handler=amtrak.presentation.handler.request.rail.AmtrakRailTrainStatusSearchRequestHandler/_xpath=/sessionWorkflow/productWorkflow[@product='Rail']"];
    }
    
    return [NSDictionary dictionaryWithDictionary:params];
}

- (NSData*)loadAmtrakPage {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self baseParams]];
    
    NSString *date = [[self dateFormatter] stringFromDate:[NSDate date]];
    
    [params setObject:[self work] forKey:@"wdf_origin"];
    [params setObject:[self home] forKey:@"wdf_destination"];
    [params setObject:date forKey:@"/sessionWorkflow/productWorkflow[@product='Rail']/tripRequirements/journeyRequirements[1]/departDate.date"];
    
    NSData *requestBody = [self encodeDictionary:params];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://tickets.amtrak.com/itd/amtrak"]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:requestBody];
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] init];
    NSError *error = [[NSError alloc] init];
    
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}

- (NSString *)getStringValueFor:(NSString *)xpath from:(NSXMLNode *)node {
    NSString *string = @"";
    
    NSArray *nodes = [node nodesForXPath:xpath error:nil];
    for (NSXMLNode *s in nodes) {
        string = [s stringValue];
    }
    
    return string;
}

- (NSArray *)parseTrainData:(NSData *)pageData {
    NSError *error = nil;
    NSXMLDocument *xmlDoc = [[NSXMLDocument alloc] initWithData:pageData options:NSXMLDocumentTidyHTML error:&error];
    
    if (error) {
        NSLog(@"%@ %ld", [error domain], (long)[error code]);
        NSLog(@"NSXMLDocument Error: %@", [error localizedDescription]);
    }
    
    NSArray *trains = [xmlDoc nodesForXPath:@"//tr[contains(@class, 'status_result') and contains(@class, 'departs')]"
                                      error:&error];
    if (error) {
        NSLog(@"nodesForXpath Error: %@", [error localizedDescription]);
    }
    
    NSMutableArray *trainData = [NSMutableArray array];
    
    for(NSXMLNode *n in trains) {
        NSMutableDictionary *train = [[NSMutableDictionary alloc] init];
        
        
        [train setObject:[self getStringValueFor:@".//th[@class='service']/div[@class='route_num']/text()" from:n]
                  forKey:@"train"];
        [train setObject:[self getStringValueFor:@".//td[@class='act_est']/div[@class='time']/text()" from:n]
                  forKey:@"estimated"];
        [train setObject:[self getStringValueFor:@".//td[@class='scheduled']/div[@class='time']/text()" from:n]
                  forKey:@"scheduled"];
        
        [trainData addObject:train];
    }
    
    return trainData;
}

- (NSArray *)getAmtrakStatus {
    NSData *amtrakPageData = [self loadAmtrakPage];
    if (amtrakPageData) {
        NSArray *trains = [self parseTrainData:amtrakPageData];
        
        for (NSDictionary *train in trains) {
            NSLog(@"Train: %@", [train objectForKey:@"train"]);
            NSLog(@"Scheduled: %@", [train objectForKey:@"scheduled"]);
            NSLog(@"Estimate: %@", [train objectForKey:@"estimated"]);
        }
        
        return trains;
    }
    
    return [NSArray array];
}

@end
