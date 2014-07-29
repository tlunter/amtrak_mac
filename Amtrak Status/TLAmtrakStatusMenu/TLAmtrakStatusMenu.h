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
- (void)quitApp:(id)sender;

@property (strong) NSMenu *menu;
@property (strong) NSMenuItem *quitButton;

@end
