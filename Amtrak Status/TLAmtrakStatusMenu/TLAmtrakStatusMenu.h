//
//  TLAmtrakStatusMenu.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SVGKImage;

@interface TLAmtrakStatusMenu : NSObject

- (id)initWithStatusItem:(NSStatusItem*)newStatusItem;
- (void)setView:(NSView *)view;
- (void)setTrainData:(NSArray*)trains withPreferredTrain:(NSString *)preferredTrain;
- (void)openPreferences:(id)sender;
- (void)checkForUpdate:(id)sender;
- (void)quitApp:(id)sender;

@property NSStatusItem *statusItem;
@property NSMenu *menu;
@property NSMenuItem *preferencesButton;
@property NSMenuItem *updatesButton;
@property NSMenuItem *quitButton;
@property SVGKImage *svgIcon;
@property NSImage *blackIcon;
@property NSImage *yellowIcon;
@property NSImage *orangeIcon;
@property NSImage *redIcon;
@property NSImage *highlightIcon;
@property TLPreferencesWindowController *preferencesWindowController;

@end
