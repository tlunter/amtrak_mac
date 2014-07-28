//
//  TLAppDelegate.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TLAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource>

- (void)updateView:(NSArray*)trains;

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSArray *trainData;
@property (nonatomic, strong) TLAmtrakStatusMenu *amtrakStatusMenu;
@property (nonatomic, strong) TLAmtrakStatusView *amtrakStatusView;
@property (nonatomic, strong) TLAmtrakStatusGrabber *amtrakStatusGrabber;

@end
