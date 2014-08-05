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

@synthesize header;

+ (NSInteger)rowHeight {
    return 28;
}

- (void)setTrainData:(NSArray *)trainData {
    NSInteger height = [TLAmtrakStatusView rowHeight] * ([trainData count] + 1);
    [self setFrame:NSMakeRect(0, 0, 240, height)];
    
    NSView *view = [[NSView alloc] initWithFrame:[self frame]];
    
    NSInteger max = [trainData count];
    
    for (int i = 0; i < max; i++) {
        NSDictionary *train = [trainData objectAtIndex:i];
        TLTrainListItemView *tLIV = [[TLTrainListItemView alloc] initWithIndex:(max - i - 1)
                                                                      andTrain:[train objectForKey:@"train"]
                                                                  andScheduled:[train objectForKey:@"scheduled"]
                                                                  andEstimated:[train objectForKey:@"estimated"]
                                                                      andColor:[[NSColor controlAlternatingRowBackgroundColors] objectAtIndex:(i + 1) % 2]];
        [view addSubview:tLIV];
    }
    
    TLTrainListItemView *headerView = [[TLTrainListItemView alloc] initWithIndex:max
                                                                        andTrain:[header objectForKey:@"train"]
                                                                    andScheduled:[header objectForKey:@"scheduled"]
                                                                    andEstimated:[header objectForKey:@"estimated"]
                                                                        andColor:[NSColor whiteColor]];
    
    [view addSubview:headerView];
    
    [self addSubview:view];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
