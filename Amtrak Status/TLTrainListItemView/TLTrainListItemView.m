//
//  TLTrainListItemView.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/28/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLTrain.h"
#import "TLAmtrakStatusView.h"
#import "TLTrainListItemTextView.h"
#import "TLTrainListItemTrainView.h"
#import "TLTrainListItemScheduledView.h"
#import "TLTrainListItemEstimatedView.h"
#import "TLTrainListItemView.h"

@implementation TLTrainListItemView

@synthesize train, scheduled, estimated, backgroundColor;

- (id)initWithIndex:(NSInteger)i andTrain:(TLTrain *)t andColor:(NSColor*)color
{
    CGFloat offset = i * [TLAmtrakStatusView rowHeight];
    NSRect frame = NSMakeRect(0, offset, 240, [TLAmtrakStatusView rowHeight]);
    self = [super initWithFrame:frame];
    if (self) {
        [self setTrain:[[TLTrainListItemTrainView alloc] initWithText:t.number]];
        [self setScheduled:[[TLTrainListItemScheduledView alloc] initWithText:t.scheduled]];
        [self setEstimated:[[TLTrainListItemEstimatedView alloc] initWithText:t.estimated]];
        [self addSubview:train];
        [self addSubview:scheduled];
        [self addSubview:estimated];

        [self setBackgroundColor:color];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

    [self setWantsLayer:YES];
    [self.layer setBackgroundColor:[backgroundColor CGColor]];
}

@end
