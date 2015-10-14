//
//  TLTrainListItemTrainView.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/28/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLTrain.h"
#import "TLAmtrakStatusView.h"
#import "TLTrainListItemTextView.h"

@implementation TLTrainListItemTextView

@synthesize string;

- (CGFloat)width {
    return 0.0;
}

- (CGFloat)leftOffset {
    return 0.0;
}

- (NSPoint)origin {
    return NSMakePoint([self leftOffset], 0);
}

- (NSSize)size {
    return NSMakeSize([self width], [TLAmtrakStatusView rowHeight] - 4);
}

- (id)initWithText:(NSString*)text
{
    NSRect frame = NSMakeRect([self origin].x, [self origin].y, [self size].width, [self size].height);

    self = [super initWithFrame:frame];
    if (self) {
        NSTextField *label = [[NSTextField alloc] initWithFrame:[self bounds]];
        
        if (text != (id)[NSNull null]) {
            [label setStringValue:text];
        }
        [label setEditable:false];
        [label setBordered:false];
        [label setFont:[NSFont systemFontOfSize:14.0]];
        [label setDrawsBackground:false];
        [self addSubview:label];
    }
    return self;
}

@end
