//
//  TLTrainListItemTrainView.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/28/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLTrainListItemTrainView.h"

@implementation TLTrainListItemTrainView

@synthesize string;

- (id)initWithIndex:(NSInteger)i andText:(NSString*)text
{
    NSRect frame = NSMakeRect(5, 0, 50, 25);
    
    NSLog(@"Init 1: %@", NSStringFromRect(frame));
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"Init 2: %@", NSStringFromRect([self frame]));
        [self setString:text];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [string drawInRect:[self frame] withAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                           [NSFont systemFontOfSize:16.0], NSFontAttributeName,
                                                    nil]];
    NSLog(@"Draw: %@", NSStringFromRect([self frame]));
}

@end
