//
//  TLTrainListItemScheduledView.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/28/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLTrainListItemScheduledView.h"

@implementation TLTrainListItemScheduledView

@synthesize string;

- (id)initWithIndex:(NSInteger)i andText:(NSString*)text
{
    NSRect frame = NSMakeRect(60, 0, 80, 25);
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
