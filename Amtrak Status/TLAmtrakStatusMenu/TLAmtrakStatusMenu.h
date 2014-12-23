//
//  TLAmtrakStatusMenu.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLAmtrakStatusMenu : NSObject

- (id)initWithStatusItem:(NSStatusItem*)newStatusItem;
- (void)setView:(NSView *)view;
- (void)setTrainData:(NSArray*)trains;
- (void)openPreferences:(id)sender;
- (void)checkForUpdate:(id)sender;
- (void)quitApp:(id)sender;

@property NSStatusItem *statusItem;
@property NSMenu *menu;
@property NSMenuItem *preferencesButton;
@property NSMenuItem *updatesButton;
@property NSMenuItem *quitButton;
@property TLPreferencesWindowController *preferencesWindowController;

@end
