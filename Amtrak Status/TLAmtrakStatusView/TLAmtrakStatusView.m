//
//  TLAmtrakStatusView.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/25/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLTrainListItemView.h"
#import "TLAmtrakStatusView.h"

@implementation TLAmtrakStatusView

- (void)setTrainData:(NSArray *)trainData {
    [self setFrame:NSMakeRect(0, 0, 240, 30 * [trainData count])];
    NSView *view = [[NSView alloc] initWithFrame:[self frame]];
    
    NSInteger max = [trainData count];
    
    for (int i = 0; i < max; i++) {
        NSDictionary *train = [trainData objectAtIndex:i];
        TLTrainListItemView *tLIV = [[TLTrainListItemView alloc] initWithIndex:(max - i - 1)
                                                                      andTrain:[train objectForKey:@"train"]
                                                                  andScheduled:[train objectForKey:@"scheduled"]
                                                                  andEstimated:[train objectForKey:@"estimated"]];
        [view addSubview:tLIV];
    }
    
    [self addSubview:view];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
