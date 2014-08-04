//
//  TLAppDelegate.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "TLPreferencesWindowController.h"
#import "TLAmtrakStatusMenu.h"
#import "TLAmtrakStatusGrabber.h"
#import "TLAmtrakStatusView.h"
#import "TLAppDelegate.h"

@implementation TLAppDelegate

@synthesize statusItem, trainData, amtrakStatusMenu, amtrakStatusView, amtrakStatusGrabber, preferencesWindowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    amtrakStatusView = [[TLAmtrakStatusView alloc] initWithFrame:NSMakeRect(0, 0, 195, 20)];
    [amtrakStatusView setHeader:@{@"train": @"Train", @"scheduled": @"Scheduled", @"estimated": @"Estimated"}];
    [amtrakStatusView setTrainData:@[]];
    
    preferencesWindowController = [[TLPreferencesWindowController alloc] init];
    amtrakStatusGrabber = [[TLAmtrakStatusGrabber alloc] initWithTarget:self];
    
    [[preferencesWindowController fromField] bind:@"value" toObject:amtrakStatusGrabber withKeyPath:@"from" options:nil];
    [[preferencesWindowController toField]   bind:@"value" toObject:amtrakStatusGrabber withKeyPath:@"to"   options:nil];
    [amtrakStatusGrabber setTo:@"pvd"];
    [amtrakStatusGrabber setFrom:@"bby"];
    
    amtrakStatusMenu = [[TLAmtrakStatusMenu alloc] init];
    [amtrakStatusMenu setView:amtrakStatusView];
    [amtrakStatusMenu setPreferencesWindowController:preferencesWindowController];
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:[amtrakStatusMenu menu]];
    [statusItem setImage:[NSImage imageNamed:@"Amtrak"]];
    [statusItem setAlternateImage:[NSImage imageNamed:@"AmtrakHighlighted"]];
    [statusItem setHighlightMode:YES];

    [NSThread detachNewThreadSelector:@selector(runGrabber) toTarget:self withObject:nil];
}

- (void)updateView:(NSArray*)trains {
    @autoreleasepool {
        [amtrakStatusView setTrainData:trains];
    }
}

- (void)runGrabber {
    while (true) {
        @autoreleasepool {
            [amtrakStatusGrabber getAmtrakStatus];
            [NSThread sleepForTimeInterval:30.0f];
        }
    }
}

@end