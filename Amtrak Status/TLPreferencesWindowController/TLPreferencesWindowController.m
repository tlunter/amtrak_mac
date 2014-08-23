//
//  TLPreferencesWindowController.m
//  Amtrak Status
//
//  Created by Todd Lunter on 8/1/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <ServiceManagement/ServiceManagement.h>
#import "TLPreferencesWindowController.h"

@implementation TLPreferencesWindowController

@synthesize window, fromField, toField, preferredTrainField;

- (id)init {
    self = [super init];
    if (self) {
        [[NSUserDefaults standardUserDefaults] addObserver:self
                                                forKeyPath:@"autoStartup"
                                                   options:NSKeyValueObservingOptionNew
                                                   context:NULL];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"autoStartup"]) {
        NSNumber *value = [change objectForKey:NSKeyValueChangeNewKey];
        if ([value boolValue] == YES) {
            // Turn on launch at login
            if (!SMLoginItemSetEnabled ((__bridge CFStringRef)@"com.tlunter.AmtrakStatusHelper", YES)) {
                NSAlert *alert = [NSAlert alertWithMessageText:@"An error ocurred"
                                                 defaultButton:@"OK"
                                               alternateButton:nil
                                                   otherButton:nil
                                     informativeTextWithFormat:@"Couldn't add Helper App to launch at login item list."];
                [alert runModal];
            }
        } else {
            // Turn off launch at login
            if (!SMLoginItemSetEnabled ((__bridge CFStringRef)@"com.tlunter.AmtrakStatusHelper", NO)) {
                NSAlert *alert = [NSAlert alertWithMessageText:@"An error ocurred"
                                                 defaultButton:@"OK"
                                               alternateButton:nil
                                                   otherButton:nil
                                     informativeTextWithFormat:@"Couldn't remove Helper App from launch at login item list."];
                [alert runModal];
            }
        }
    }
}

@end
