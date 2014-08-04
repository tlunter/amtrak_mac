//
//  TLTrainListItemTrainView.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/28/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TLTrainListItemTextView : NSView

- (id)initWithText:(NSString*)text;
- (CGFloat)width;
- (CGFloat)leftOffset;
- (NSPoint)origin;
- (NSSize)size;

@property NSString *string;

@end
