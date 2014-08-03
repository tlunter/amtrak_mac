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
    
    preferencesWindowController = [[TLPreferencesWindowController alloc] init];
    
    amtrakStatusMenu = [[TLAmtrakStatusMenu alloc] init];
    [amtrakStatusMenu setView:amtrakStatusView];
    [amtrakStatusMenu setPreferencesWindowController:preferencesWindowController];
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:[amtrakStatusMenu menu]];
    [statusItem setImage:[NSImage imageNamed:@"Amtrak"]];
    [statusItem setAlternateImage:[NSImage imageNamed:@"AmtrakHighlighted"]];
    [statusItem setHighlightMode:YES];
    
    amtrakStatusGrabber = [[TLAmtrakStatusGrabber alloc] initWithHome:@"bby" andWork:@"pvd" andTarget:self];

    [NSThread detachNewThreadSelector:@selector(runGrabber) toTarget:self withObject:nil];
}

- (void)updateView:(NSArray*)trains {
    NSMutableArray *array = [NSMutableArray arrayWithArray:trains];
    NSDictionary *header = @{@"train": @"Train", @"scheduled": @"Scheduled", @"estimated": @"Estimated"};
    
    [array insertObject:header atIndex:0];
    
    @autoreleasepool {
        [amtrakStatusView setTrainData:array];
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