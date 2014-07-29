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

@synthesize scrollView;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setScrollView:[[NSScrollView alloc] initWithFrame:[self frame]]];
        
        [scrollView setBorderType:NSNoBorder];
        
        [self addSubview:[self scrollView]];
    }
    return self;
}

- (void)setTrainData:(NSArray *)trainData {
    [self setFrame:NSMakeRect(0, 0, 235, 30 * [trainData count])];
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
    
    [scrollView setFrame:[self frame]];
    [scrollView setDocumentView:view];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
