//
//  TLTrainListItemView.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/28/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLTrainListItemTrainView.h"
#import "TLTrainListItemScheduledView.h"
#import "TLTrainListItemEstimatedView.h"
#import "TLTrainListItemView.h"

@implementation TLTrainListItemView

@synthesize train, scheduled, estimated;

- (id)initWithIndex:(NSInteger)i andTrain:(NSString*)t andScheduled:(NSString*)s andEstimated:(NSString*)e
{
    NSRect frame = NSMakeRect(0, i * 30, 235, 30);
    self = [super initWithFrame:frame];
    if (self) {
        [self setTrain:[[TLTrainListItemTrainView alloc] initWithIndex:i andText:t]];
        [self setScheduled:[[TLTrainListItemScheduledView alloc] initWithIndex:i andText:s]];
        [self setEstimated:[[TLTrainListItemEstimatedView alloc] initWithIndex:i andText:e]];
        [self addSubview:train];
        [self addSubview:scheduled];
        [self addSubview:estimated];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
