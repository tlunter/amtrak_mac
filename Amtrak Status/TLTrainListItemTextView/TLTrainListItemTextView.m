//
//  TLTrainListItemTrainView.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/28/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

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
        [self setString:text];
    }
    return self;
}
- (void)drawRect:(NSRect)dirtyRect
{
    [string drawInRect:[self frame] withAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    [NSFont systemFontOfSize:14.0], NSFontAttributeName,
                                                    nil]];
}

@end
