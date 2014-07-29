//
//  TLAppDelegate.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "TLAmtrakStatusMenu.h"
#import "TLAmtrakStatusGrabber.h"
#import "TLAmtrakStatusView.h"
#import "TLAppDelegate.h"

@implementation TLAppDelegate

@synthesize statusItem, trainData, amtrakStatusMenu, amtrakStatusView, amtrakStatusGrabber;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    amtrakStatusView = [[TLAmtrakStatusView alloc] initWithFrame:NSMakeRect(0, 0, 195, 20)];
    
    amtrakStatusMenu = [[TLAmtrakStatusMenu alloc] init];
    [amtrakStatusMenu setView:amtrakStatusView];
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:[amtrakStatusMenu menu]];
    [statusItem setImage:[NSImage imageNamed:@"Amtrak"]];
    [statusItem setAlternateImage:[NSImage imageNamed:@"AmtrakHighlighted"]];
    [statusItem setHighlightMode:YES];
    
    amtrakStatusGrabber = [[TLAmtrakStatusGrabber alloc] initWithHome:@"bby" andWork:@"pvd"];

    [NSThread detachNewThreadSelector:@selector(runGrabber) toTarget:self withObject:nil];
}

- (void)updateView:(NSArray*)trains {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:trains];
    NSDictionary *header = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Train", @"Scheduled", @"Estimated", nil]
                                                       forKeys:[NSArray arrayWithObjects:@"train", @"scheduled", @"estimated", nil]];
    
    [array insertObject:header atIndex:0];
    
    [amtrakStatusView setTrainData:array];
}

- (void)runGrabber {
    while (true) {
        NSArray *trains = [amtrakStatusGrabber getAmtrakStatus];
        [self performSelectorOnMainThread:@selector(updateView:) withObject:trains waitUntilDone:NO];
        [NSThread sleepForTimeInterval:10.0f];
    }
}

@end