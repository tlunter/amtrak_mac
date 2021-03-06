//
//  TLAppDelegate.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TLAppDelegate : NSObject<TLAmtrakStatusGrabberDelegate>

- (void)updateData:(NSArray*)trains;

@property (assign) IBOutlet NSWindow *window;
@property NSArray *trainData;
@property NSTimer *updateTimer;
@property TLAmtrakStatusMenu *amtrakStatusMenu;
@property TLAmtrakStatusView *amtrakStatusView;
@property TLAmtrakStatusGrabber *amtrakStatusGrabber;
@property IBOutlet TLPreferencesWindowController *preferencesWindowController;

@end
