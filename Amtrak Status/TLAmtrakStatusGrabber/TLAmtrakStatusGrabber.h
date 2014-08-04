//
//  TLAmtrakStatusGrabber.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TLAmtrakStatusGrabberDelegate

- (void)updateView:(NSArray*)trains;

@end

@interface TLAmtrakStatusGrabber : NSObject

- (id)initWithTarget:(NSObject<TLAmtrakStatusGrabberDelegate>*)target;
- (void)getAmtrakStatus;

@property NSDateFormatter *dateFormatter;
@property NSString *from;
@property NSString *to;
@property NSObject<TLAmtrakStatusGrabberDelegate>* target;

@end
