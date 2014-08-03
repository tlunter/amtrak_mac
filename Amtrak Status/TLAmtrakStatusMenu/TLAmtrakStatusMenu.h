//
//  TLAmtrakStatusMenu.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLAmtrakStatusMenu : NSObject

- (void)setView:(NSView *)view;
- (void)openPreferences:(id)sender;
- (void)quitApp:(id)sender;

@property NSMenu *menu;
@property NSMenuItem *preferencesButton;
@property NSMenuItem *quitButton;
@property TLPreferencesWindowController *preferencesWindowController;

@end
