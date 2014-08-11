//
//  TLAppDelegate.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "TLTrain.h"
#import "TLPreferencesWindowController.h"
#import "TLAmtrakStatusMenu.h"
#import "TLAmtrakStatusGrabber.h"
#import "TLAmtrakStatusView.h"
#import "TLAppDelegate.h"

@implementation TLAppDelegate

@synthesize statusItem, trainData, updateTimer, amtrakStatusMenu, amtrakStatusView, amtrakStatusGrabber, preferencesWindowController;

- (void)setUpDefaultSettings {
    NSString *userDefaultsValuesPath;
    NSDictionary *userDefaultsValuesDict;
    
    // load the default values for the user defaults
    userDefaultsValuesPath=[[NSBundle mainBundle] pathForResource:@"UserDefaults"
                                                           ofType:@"plist"];
    userDefaultsValuesDict=[NSDictionary dictionaryWithContentsOfFile:userDefaultsValuesPath];
    
    // set them in the standard user defaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsValuesDict];
}

- (void)buildMenuItemView {
    amtrakStatusView = [[TLAmtrakStatusView alloc] initWithFrame:NSMakeRect(0, 0, 195, 20)];
    
    TLTrain *header = [[TLTrain alloc] init];
    [header setNumber:@"Train"];
    [header setScheduled:@"Scheduled"];
    [header setEstimated:@"Estimated"];
    
    [amtrakStatusView setHeader:header];
    [amtrakStatusView setTrainData:@[]];
}

- (void)buildPreferences {
    preferencesWindowController = [[TLPreferencesWindowController alloc] init];
    [[preferencesWindowController fromField] bind:@"value"
                                         toObject:[NSUserDefaultsController sharedUserDefaultsController]
                                      withKeyPath:@"values.from"
                                          options:@{@"NSContinuouslyUpdatesValue": @YES}];
    [[preferencesWindowController toField]   bind:@"value"
                                         toObject:[NSUserDefaultsController sharedUserDefaultsController]
                                      withKeyPath:@"values.to"
                                          options:@{@"NSContinuouslyUpdatesValue": @YES}];
    [[NSUserDefaults standardUserDefaults] addObserver:self
                                            forKeyPath:@"from"
                                               options:NSKeyValueObservingOptionNew
                                               context:NULL];
    [[NSUserDefaults standardUserDefaults] addObserver:self
                                            forKeyPath:@"to"
                                               options:NSKeyValueObservingOptionNew
                                               context:NULL];
}

- (void)buildMenu {
    amtrakStatusMenu = [[TLAmtrakStatusMenu alloc] init];
    [amtrakStatusMenu setView:amtrakStatusView];
    [amtrakStatusMenu setPreferencesWindowController:preferencesWindowController];
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:[amtrakStatusMenu menu]];
    [statusItem setImage:[NSImage imageNamed:@"Amtrak"]];
    [statusItem setAlternateImage:[NSImage imageNamed:@"AmtrakHighlighted"]];
    [statusItem setHighlightMode:YES];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self setUpDefaultSettings];
    [self buildMenuItemView];

    amtrakStatusGrabber = [[TLAmtrakStatusGrabber alloc] initWithTarget:self];
    
    [self buildPreferences];

    [amtrakStatusGrabber setTo:[[NSUserDefaults standardUserDefaults] stringForKey:@"to"]];
    [amtrakStatusGrabber setFrom:[[NSUserDefaults standardUserDefaults] stringForKey:@"from"]];
    
    [self buildMenu];

    [self startGrabber];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"from"]) {
        [amtrakStatusGrabber setFrom:[change objectForKey:NSKeyValueChangeNewKey]];
    }
    
    if ([keyPath isEqualToString:@"to"]) {
        [amtrakStatusGrabber setTo:[change objectForKey:NSKeyValueChangeNewKey]];
    }
    
    if ([keyPath isEqualToString:@"from"] || [keyPath isEqualToString:@"to"]) {
        if ([[amtrakStatusGrabber from] length] >= 3 && [[amtrakStatusGrabber to] length] >= 3) {
            [updateTimer fire];
        }
    }
}

- (void)updateView:(NSArray*)trains {
    @autoreleasepool {
        [amtrakStatusView setTrainData:trains];
    }
}

- (void)startGrabber {
    NSMethodSignature *methodSig = [self methodSignatureForSelector:@selector(runGrabber)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setTarget:self];
    [invocation setSelector:@selector(runGrabber)];
    updateTimer = [NSTimer timerWithTimeInterval:30.0f invocation:invocation repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:updateTimer forMode:NSDefaultRunLoopMode];
    [updateTimer fire];
}

- (void)runGrabber {
    [NSThread detachNewThreadSelector:@selector(getAmtrakStatus) toTarget:amtrakStatusGrabber withObject:nil];
}

@end