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
    amtrakStatusView = [[TLAmtrakStatusView alloc] initWithFrame:NSMakeRect(0, 0, 200, 200)];
    [amtrakStatusView setDataSource:self];
    
    amtrakStatusMenu = [[TLAmtrakStatusMenu alloc] init];
    [amtrakStatusMenu setView:amtrakStatusView];
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:[amtrakStatusMenu menu]];
    [statusItem setTitle:@"Amtrak"];
    [statusItem setHighlightMode:YES];
    
    amtrakStatusGrabber = [[TLAmtrakStatusGrabber alloc] initWithHome:@"bby" andWork:@"pvd"];

    [NSThread detachNewThreadSelector:@selector(runGrabber) toTarget:self withObject:nil];
}

- (void)updateView:(NSArray*)trains {
    [self setTrainData:trains];
}

- (void)runGrabber {
    while (true) {
        NSArray *trains = [amtrakStatusGrabber getAmtrakStatus];
        [self performSelectorOnMainThread:@selector(updateView:) withObject:trains waitUntilDone:NO];
        [NSThread sleepForTimeInterval:10.0f];
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[self trainData] count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return [[[self trainData] objectAtIndex:row] objectForKey:[tableColumn identifier]];
}

@end
