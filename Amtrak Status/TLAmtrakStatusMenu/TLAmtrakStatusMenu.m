//
//  TLAmtrakStatusMenu.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLPreferencesWindowController.h"
#import "TLAmtrakStatusMenu.h"

@implementation TLAmtrakStatusMenu

@synthesize menu, preferencesButton, preferencesWindowController, quitButton;

- (id)init {
    self = [super init];
    if (self) {
        NSMenu *newMenu = [[NSMenu alloc] init];
        [self setMenu:newMenu];
        
        [self setQuitButton:[[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(quitApp:) keyEquivalent:@""]];
        [quitButton setTarget:self];
        [self setPreferencesButton:[[NSMenuItem alloc] initWithTitle:@"Preferences" action:@selector(openPreferences:) keyEquivalent:@""]];
        [preferencesButton setTarget:self];
    }
    return self;
}

- (void)openPreferences:(id)sender {
    [preferencesWindowController showWindow:self];
}

- (void)quitApp:(id)sender {
    [NSApp performSelector:@selector(terminate:) withObject:nil afterDelay:0.0];
}

- (void)setView:(NSView *)view {
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    [menuItem setView:view];
    [menu removeAllItems];
    [menu addItem:menuItem];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:preferencesButton];
    [menu addItem:quitButton];
}

@end
