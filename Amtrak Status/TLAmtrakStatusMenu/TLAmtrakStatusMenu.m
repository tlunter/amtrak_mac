//
//  TLAmtrakStatusMenu.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLAmtrakStatusMenu.h"

@implementation TLAmtrakStatusMenu

@synthesize menu;

- (id)init {
    self = [super init];
    if (self) {
        NSMenu *newMenu = [[NSMenu alloc] init];
        [self setMenu:newMenu];
    }
    return self;
}

- (void)setView:(NSView *)view {
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    [menuItem setView:view];
    [[self menu] removeAllItems];
    [[self menu] addItem:menuItem];
}

@end
