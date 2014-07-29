//
//  TLTrainListItemEstimatedView.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/28/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLTrainListItemEstimatedView.h"

@implementation TLTrainListItemEstimatedView

@synthesize string;

- (id)initWithIndex:(NSInteger)i andText:(NSString*)text
{
    NSRect frame = NSMakeRect(145, 0, 95, 25);
    self = [super initWithFrame:frame];
    if (self) {
        [self setString:text];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    [[self string] drawInRect:dirtyRect withAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                        [NSFont systemFontOfSize:16.0], NSFontAttributeName,
                                                        nil]];
}

@end
