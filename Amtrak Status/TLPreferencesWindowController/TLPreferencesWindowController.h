//
//  TLPreferencesWindowController.h
//  Amtrak Status
//
//  Created by Todd Lunter on 8/1/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TLPreferencesWindowController : NSWindowController

@property IBOutlet NSWindow *window;
@property IBOutlet NSTextField *fromField;
@property IBOutlet NSTextField *toField;
@property IBOutlet NSTextField *preferredTrainField;

@end
