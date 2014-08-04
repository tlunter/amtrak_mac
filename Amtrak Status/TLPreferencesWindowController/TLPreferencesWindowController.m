//
//  TLPreferencesWindowController.m
//  Amtrak Status
//
//  Created by Todd Lunter on 8/1/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLPreferencesWindowController.h"

@implementation TLPreferencesWindowController

@synthesize fromField, toField;

+ (CGFloat)width {
    return 300;
}

+ (CGFloat)height {
    return 200;
}

- (id)init
{
    
    int x = ([[NSScreen mainScreen] frame].size.width - [TLPreferencesWindowController width]) / 2;
    int y = ([[NSScreen mainScreen] frame].size.height - [TLPreferencesWindowController height]) / 2;
    
    NSRect frame = NSMakeRect(x,y,[TLPreferencesWindowController width],[TLPreferencesWindowController height]);
    
    NSWindow *window = [[NSWindow alloc] initWithContentRect:frame
                                                   styleMask:(NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask)
                                                     backing:NSBackingStoreBuffered
                                                       defer:YES];
    
    [window setReleasedWhenClosed:NO];
    self = [super initWithWindow:window];
    if (self) {
        fromField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 30, 120, 30)];
        
        toField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 120, 30)];
        
        [[window contentView] addSubview:fromField];
        
        [[window contentView] addSubview:toField];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

@end
