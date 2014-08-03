//
//  TLPreferencesWindowController.m
//  Amtrak Status
//
//  Created by Todd Lunter on 8/1/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLPreferencesWindowController.h"

@interface TLPreferencesWindowController ()

@end

@implementation TLPreferencesWindowController

- (id)init
{
    
    int x = ([[NSScreen mainScreen] frame].size.width - 600) / 2;
    int y = ([[NSScreen mainScreen] frame].size.height - 400) / 2;
    
    NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(x,y,600,400) styleMask:(NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask) backing:NSBackingStoreBuffered defer:YES];
    
    [window setReleasedWhenClosed:NO];
    self = [super initWithWindow:window];
    if (self) {
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

@end
