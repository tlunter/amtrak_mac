//
//  TLAmtrakStatusGrabber.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TLAmtrakStatusDelegate

- (void)updateView:(NSArray*)trains;

@end

@interface TLAmtrakStatusGrabber : NSObject

- (id)initWithHome:(NSString*)newHome andWork:(NSString*)newWork andTarget:(NSObject<TLAmtrakStatusDelegate>*)target;
- (void)getAmtrakStatus;

@property NSDateFormatter *dateFormatter;
@property NSString *home;
@property NSString *work;
@property NSObject<TLAmtrakStatusDelegate>* target;

@end
