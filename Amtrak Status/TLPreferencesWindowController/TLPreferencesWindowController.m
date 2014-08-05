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
    return 200;
}

+ (CGFloat)height {
    return 100;
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
        int fromLabelX = (([TLPreferencesWindowController width] - 120) / 2) - 45;
        int fromFieldX = (([TLPreferencesWindowController width] - 120) / 2) + 20;
        int fromY = ([TLPreferencesWindowController height] / 2) + 7.5;
        NSTextField *fromLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(fromLabelX, fromY, 60, 20)];
        [fromLabel setBackgroundColor:[NSColor controlColor]];
        [fromLabel setBezeled:NO];
        [fromLabel setEditable:NO];
        [fromLabel setStringValue:@"From:"];
        [fromLabel setAlignment:NSRightTextAlignment];
        fromField = [[NSTextField alloc] initWithFrame:NSMakeRect(fromFieldX, fromY, 120, 22)];
        [[fromField cell] setPlaceholderString:@"From"];
        
        int toLabelX = (([TLPreferencesWindowController width] - 120) / 2) - 45;
        int toFieldX = (([TLPreferencesWindowController width] - 120) / 2) + 20;
        int toY = ([TLPreferencesWindowController height] / 2) - 27.5;
        NSTextField *toLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(toLabelX, toY, 60, 20)];
        [toLabel setBackgroundColor:[NSColor controlColor]];
        [toLabel setBezeled:NO];
        [toLabel setEditable:NO];
        [toLabel setStringValue:@"To:"];
        [toLabel setAlignment:NSRightTextAlignment];
        toField = [[NSTextField alloc] initWithFrame:NSMakeRect(toFieldX, toY, 120, 22)];
        
        [[window contentView] addSubview:fromLabel];
        [[window contentView] addSubview:fromField];
        [[window contentView] addSubview:toLabel];
        [[window contentView] addSubview:toField];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

@end
