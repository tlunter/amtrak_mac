//
//  TLAppDelegate.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TLAppDelegate : NSObject<TLAmtrakStatusDelegate>

- (void)updateView:(NSArray*)trains;

@property (assign) IBOutlet NSWindow *window;
@property NSStatusItem *statusItem;
@property NSArray *trainData;
@property TLAmtrakStatusMenu *amtrakStatusMenu;
@property TLAmtrakStatusView *amtrakStatusView;
@property TLAmtrakStatusGrabber *amtrakStatusGrabber;
@property TLPreferencesWindowController *preferencesWindowController;

@end
