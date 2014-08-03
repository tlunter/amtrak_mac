//
//  TLTrainListItemScheduledView.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/28/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TLTrainListItemScheduledView : NSView

- (id)initWithIndex:(NSInteger)i andText:(NSString*)text;

@property NSString *string;

@end
