//
//  TLAmtrakStatusView.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/25/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLTrain.h"
#import "TLTrainListItemView.h"
#import "TLAmtrakStatusView.h"

@implementation TLAmtrakStatusView

@synthesize header, trains;

- (id)init {
    self = [super init];

    if (self) {
        [self setTrains:@[]];
    }
    return self;
}

+ (NSInteger)rowHeight {
    return 28;
}

- (void)setTrainData:(NSArray *)trainData {
    if (![trainData isEqualToArray:[self trains]]) {
        NSLog(@"Different!");
        [self setTrains:trainData];

        NSInteger height = [TLAmtrakStatusView rowHeight] * ([trainData count] + 1);
        [self setFrame:NSMakeRect(0, 0, 240, height)];

        NSView *view = [[NSView alloc] initWithFrame:[self frame]];

        NSInteger max = [trainData count];

        for (int i = 0; i < max; i++) {
            TLTrain *train = [trainData objectAtIndex:i];
            TLTrainListItemView *tLIV = [[TLTrainListItemView alloc] initWithIndex:(max - i - 1)
                                                                          andTrain:train
                                                                          andColor:[[NSColor controlAlternatingRowBackgroundColors] objectAtIndex:(i + 1) % 2]];
            [view addSubview:tLIV];
        }

        TLTrainListItemView *headerView = [[TLTrainListItemView alloc] initWithIndex:max
                                                                            andTrain:header
                                                                            andColor:[NSColor whiteColor]];

        [view addSubview:headerView];
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self addSubview:view];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

@end
