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

@synthesize from, to, target;

- (id)initWithTarget:(NSObject<TLAmtrakStatusGrabberDelegate>*)t {
    self = [super init];

    if (self) {
        [self setTarget:t];
    }

    return self;
}

- (void)loadAmtrakPage {
    UNIHTTPBinaryResponse *response = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"http://amtrak_endpoint.tlunter.com/pvd/bby.json"];
    }] asBinary];
    [self parseTrainData:[response rawBody]];
}

- (void)parseTrainData:(NSData *)pageData {
    if (pageData == nil || [pageData length] == 0) {
        return;
    }
    
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:pageData options:0 error:&error];
    
    if (![object isKindOfClass:[NSArray class]]) {
        return;
    }
    
    NSArray *trains = object;
    NSMutableArray *trainData = [NSMutableArray array];
    
    for (NSDictionary *rawTrain in trains) {
        TLTrain *train = [[TLTrain alloc] init];
        [train setNumber:[[rawTrain valueForKeyPath:@"number"] stringValue]];
        [train setScheduled:[rawTrain valueForKeyPath:@"departure.scheduled_time"]];
        [train setEstimated:[rawTrain valueForKeyPath:@"departure.estimated_time"]];
        [trainData addObject:train];
    }

    [target performSelectorOnMainThread:@selector(updateData:) withObject:trainData waitUntilDone:YES];
}

- (void)getAmtrakStatus {
    [self loadAmtrakPage];
}

@end
