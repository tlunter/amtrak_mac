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

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];

    if (self) {
        [[NSUserDefaults standardUserDefaults]
         addObserver:self forKeyPath:@"preferredTrain"
         options:NSKeyValueObservingOptionNew context:NULL];
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
        [self updateView];
    }
}

- (void)updateView {
    NSLog(@"Redrawing");
    NSInteger height = [TLAmtrakStatusView rowHeight] * ([trains count] + 1);
    [self setFrame:NSMakeRect(0, 0, 240, height)];

    NSView *view = [[NSView alloc] initWithFrame:[self frame]];

    NSInteger max = [trains count];
    NSString *preferredTrain = [[NSUserDefaults standardUserDefaults] objectForKey:@"preferredTrain"];

    for (int i = 0; i < max; i++) {
        TLTrain *train = [trains objectAtIndex:i];
        NSColor *color;
        if ([preferredTrain isEqualToString:train.number]) {
            color = [NSColor selectedTextBackgroundColor];
        } else {
            color = [[NSColor controlAlternatingRowBackgroundColors] objectAtIndex:(i + 1) % 2];
        }
        TLTrainListItemView *tLIV = [[TLTrainListItemView alloc] initWithIndex:(max - i - 1)
                                                                      andTrain:train
                                                                      andColor:color];
        [view addSubview:tLIV];
    }

    TLTrainListItemView *headerView = [[TLTrainListItemView alloc] initWithIndex:max
                                                                        andTrain:header
                                                                        andColor:[NSColor whiteColor]];

    [view addSubview:headerView];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addSubview:view];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"preferredTrain"]) {
        [self updateView];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

@end
