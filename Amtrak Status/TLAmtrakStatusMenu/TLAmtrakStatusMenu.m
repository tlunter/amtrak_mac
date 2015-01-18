//
//  TLAmtrakStatusMenu.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Sparkle/Sparkle.h>
#import "TLTrain.h"
#import "TLPreferencesWindowController.h"
#import "TLOperatingSystemVersion.h"
#import "TLAmtrakStatusMenu.h"

@implementation TLAmtrakStatusMenu

@synthesize statusItem, menu, preferencesButton, updatesButton, quitButton, preferencesWindowController;

+ (NSDateFormatter *)lateTimeFormatter {
    NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
    }
    return formatter;
}

- (id)initWithStatusItem:(NSStatusItem *)newStatusItem {
    self = [super init];
    if (self) {
        NSMenu *newMenu = [[NSMenu alloc] init];
        [self setMenu:newMenu];

        [self setQuitButton:[[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(quitApp:) keyEquivalent:@""]];
        [quitButton setTarget:self];
        [self setPreferencesButton:[[NSMenuItem alloc] initWithTitle:@"Preferences" action:@selector(openPreferences:) keyEquivalent:@""]];
        [preferencesButton setTarget:self];
        [self setUpdatesButton:[[NSMenuItem alloc] initWithTitle:@"Check for Updates" action:@selector(checkForUpdate:) keyEquivalent:@""]];
        [updatesButton setTarget:self];

        [self setStatusItem:newStatusItem];

        [statusItem setMenu:menu];
        NSImage *amtrakTemplate = [NSImage imageNamed:@"AmtrakTemplate"];
        [amtrakTemplate setTemplate:YES];
        [self setImage:amtrakTemplate];
        [self setTitle:nil];
        if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:[TLOperatingSystemVersion yosemite]]) {
            [statusItem.button setImagePosition:NSImageLeft];
        } else {
            [statusItem setHighlightMode:YES];
        }
    }
    return self;
}

- (void)setView:(NSView *)view {
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    [menuItem setView:view];
    [menu removeAllItems];
    [menu addItem:menuItem];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:preferencesButton];
    [menu addItem:updatesButton];
    [menu addItem:quitButton];
}

- (void)setTrainData:(NSArray*)trains {
    NSString *preferredTrain = [[NSUserDefaults standardUserDefaults] objectForKey:@"preferredTrain"];
    if ([preferredTrain length] > 0) {
        TLTrain *train = nil;
        for (TLTrain *t in trains) {
            if([[t number] isEqualToString:preferredTrain]) {
                train = t;
                break;
            }
        }
        if (train) {
            NSDate *scheduled = [[TLAmtrakStatusMenu lateTimeFormatter] dateFromString:[train scheduled]];
            NSDate *estimated = [[TLAmtrakStatusMenu lateTimeFormatter] dateFromString:[train estimated]];
            NSTimeInterval timeDiff = [estimated timeIntervalSinceDate:scheduled];

            NSInteger showTimeInMenu = [[NSUserDefaults standardUserDefaults] integerForKey:@"showTimeInMenu"];
            // Always
            if (showTimeInMenu == 2) {
                [self setTitle:[train estimated]];
                return;
            // When later than 5 minutes
            } else if (showTimeInMenu == 1 && timeDiff > 300) {
                [self setTitle:[train estimated]];
                return;
            }
        }
    }

    // Otherwise clear
    [self setTitle:nil];
}

- (void)setTitle:(NSString *)title {
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:[TLOperatingSystemVersion yosemite]]) {
        [statusItem.button setTitle:title];
        [statusItem.button setAlternateTitle:title];
    } else {
        [statusItem setTitle:title];
    }
}

- (void)setImage:(NSImage *)image {
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:[TLOperatingSystemVersion yosemite]]) {
        [statusItem.button setImage:image];
    } else {
        [statusItem setImage:image];
    }
}

- (void)openPreferences:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [[preferencesWindowController window] makeKeyAndOrderFront:self];
}

- (void)checkForUpdate:(id)sender {
    [[SUUpdater sharedUpdater] checkForUpdates:sender];
}

- (void)quitApp:(id)sender {
    [NSApp performSelector:@selector(terminate:) withObject:nil afterDelay:0.0];
}

@end
