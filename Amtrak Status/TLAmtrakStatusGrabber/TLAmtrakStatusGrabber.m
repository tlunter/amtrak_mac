//
//  TLAmtrakStatusGrabber.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "UNIRest.h"
#import "TLTrain.h"
#import "TLAmtrakStatusGrabber.h"

@implementation TLAmtrakStatusGrabber

@synthesize dateFormatter, from, to, target;

- (id)initWithTarget:(NSObject<TLAmtrakStatusGrabberDelegate>*)t {
    self = [super init];
    
    if (self) {
        [self setDateFormatter:[[NSDateFormatter alloc] init]];
        [dateFormatter setDateFormat:@"EEE, MMM d, yyyy"];
        [self setTarget:t];
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
    static NSDictionary *params = nil;
    
    if (params == nil) {
        params = @{
            @"xwdf_origin": @"/sessionWorkflow/productWorkflow[@product='Rail']/travelSelection/journeySelection[1]/departLocation/search",
            @"xwdf_destination": @"/sessionWorkflow/productWorkflow[@product='Rail']/travelSelection/journeySelection[1]/arriveLocation/search",
            @"requestor": @"amtrak.presentation.handler.page.rail.AmtrakRailGetTrainStatusPageHandler",
            @"xwdf_trainNumber": @"/sessionWorkflow/productWorkflow[@product='Rail']/tripRequirements/journeyRequirements[1]/segmentRequirements[1]/serviceCode",
            @"wdf_trainNumber": @"optional",
            @"_handler=amtrak.presentation.handler.request.rail.AmtrakRailTrainStatusSearchRequestHandler/_xpath=/sessionWorkflow/productWorkflow[@product='Rail']": @"",
            @"wdf_SortBy": @"arrivalTime",
            @"xwdf_SortBy": @"/sessionWorkflow/productWorkflow[@product='Rail']/tripRequirements/journeyRequirements[1]/departDate/@radioSelect"
         };
    }
    
    return params;
}

- (NSRegularExpression*)estimatedRegularExpression {
    static NSRegularExpression *expression = nil;
    if (expression == nil) {
        expression = [NSRegularExpression regularExpressionWithPattern:@"^\\(?([^)]*?)\\)?$"
                                                               options:NSRegularExpressionCaseInsensitive
                                                                 error:nil];
    }
    return expression;
}

- (void)loadAmtrakPage {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self baseParams]];
    
    NSString *date = [[self dateFormatter] stringFromDate:[NSDate date]];
    
    [params setObject:[self from] forKey:@"wdf_origin"];
    [params setObject:[self to] forKey:@"wdf_destination"];
    [params setObject:date forKey:@"/sessionWorkflow/productWorkflow[@product='Rail']/tripRequirements/journeyRequirements[1]/departDate.date"];
    
    NSData *requestBody = [self encodeDictionary:params];
    
    UNIHTTPBinaryResponse *response = [[UNIRest postEntity:^(UNIBodyRequest *request) {
        [request setUrl:@"http://tickets.amtrak.com/itd/amtrak"];
        [request setHeaders:@{@"Content-Type": @"application/x-www-form-urlencoded"}];
        [request setBody:requestBody];
    }] asBinary];
    
    [self parseTrainData:[response rawBody]];
}

- (NSString *)getStringValueFor:(NSString *)xpath from:(NSXMLNode *)node {
    NSString *string = @"";
    
    NSArray *nodes = [node nodesForXPath:xpath error:nil];
    for (NSXMLNode *s in nodes) {
        string = [s stringValue];
    }
    
    return string;
}

- (void)parseTrainData:(NSData *)pageData {
    if (pageData == nil || [pageData length] == 0) {
        return;
    }
    
    NSError *error = nil;
    NSXMLDocument *xmlDoc = [[NSXMLDocument alloc] initWithData:pageData options:NSXMLDocumentTidyHTML error:&error];
    
    if ([error code] > 1) {
        NSLog(@"%@ %ld", [error domain], (long)[error code]);
        NSLog(@"NSXMLDocument Error: %@", [error localizedDescription]);
        return;
    }
    
    NSArray *trains = [xmlDoc nodesForXPath:@"//tr[contains(@class, 'status_result') and contains(@class, 'departs')]"
                                      error:&error];
    if (error) {
        NSLog(@"nodesForXpath Error: %@", [error localizedDescription]);
        return;
    }
    
    NSMutableArray *trainData = [NSMutableArray array];
    
    for(NSXMLNode *n in trains) {
        TLTrain *train = [[TLTrain alloc] init];
        
        [train setNumber:[self getStringValueFor:@".//th[@class='service']/div[@class='route_num']/text()" from:n]];
        [train setScheduled:[self getStringValueFor:@".//td[@class='scheduled']/div[@class='time']/text()" from:n]];
        NSString *estimated = [self getStringValueFor:@".//td[@class='act_est']/div[@class='time']/text()" from:n];
        NSTextCheckingResult *match = [[self estimatedRegularExpression] firstMatchInString:estimated options:0 range:NSMakeRange(0, [estimated length])];
        
        if (match) {
            estimated = [estimated substringWithRange:[match rangeAtIndex:1]];
        }
        
        [train setEstimated:estimated];
        
        [trainData addObject:train];
    }
    
    [target performSelectorOnMainThread:@selector(updateView:) withObject:trainData waitUntilDone:YES];
}

- (void)getAmtrakStatus {
    [self loadAmtrakPage];
}

@end
