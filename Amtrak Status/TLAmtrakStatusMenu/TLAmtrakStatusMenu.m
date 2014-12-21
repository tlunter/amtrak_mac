//
//  TLAmtrakStatusMenu.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Sparkle/Sparkle.h>
#import <SVGKit/SVGKit.h>
#import "TLTrain.h"
#import "TLPreferencesWindowController.h"
#import "TLAmtrakStatusMenu.h"

@implementation TLAmtrakStatusMenu

@synthesize statusItem, menu, preferencesButton, updatesButton, quitButton, preferencesWindowController;
@synthesize svgIcon, blackIcon, yellowIcon, orangeIcon, redIcon, highlightIcon;

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
        
        svgIcon = [SVGKImage imageNamed:@"amtrak-24.svg"];
        
        SVGKNode *fill = [[[svgIcon.DOMTree.childNodes objectAtIndexedSubscript:7].childNodes objectAtIndexedSubscript:1].attributes getNamedItem:@"fill"];
        
        [fill setValue:@"#ffffff"];
        
        [[[svgIcon.DOMTree.childNodes objectAtIndexedSubscript:7].childNodes objectAtIndexedSubscript:1].attributes setNamedItemNS:fill inNodeNamespace:@"http://www.w3.org/2000/svg"];
        
        NSLog(@"%@", [[svgIcon.DOMTree.childNodes objectAtIndexedSubscript:7].childNodes objectAtIndexedSubscript:1].attributes);
        
        blackIcon = svgIcon.NSImage;
        
        yellowIcon = [NSImage imageNamed:@"AmtrakYellow"];
        orangeIcon = [NSImage imageNamed:@"AmtrakOrange"];
        redIcon = [NSImage imageNamed:@"AmtrakRed"];
        
        highlightIcon = [NSImage imageNamed:@"AmtrakHighlighted"];
        
        [statusItem setMenu:menu];
        
        [statusItem setImage:blackIcon];
        [statusItem setAlternateImage:highlightIcon];
        [statusItem setHighlightMode:YES];
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

- (void)setTrainData:(NSArray*)trains withPreferredTrain:(NSString *)preferredTrain {
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
            
            if (timeDiff > 5400) {
                [statusItem setImage:redIcon];
            } else if (timeDiff > 2700) {
                [statusItem setImage:orangeIcon];
            } else if (timeDiff > 900) {
                [statusItem setImage:yellowIcon];
            } else {
                [statusItem setImage:blackIcon];
            }
        } else {
            [statusItem setImage:blackIcon];
        }
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
