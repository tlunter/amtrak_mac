//
//  TLAmtrakStatusGrabber.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/24/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLAmtrakStatusGrabber : NSObject

- (id)initWithHome:(NSString*)newHome andWork:(NSString*)newWork;
- (NSArray *)getAmtrakStatus;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSString *home;
@property (nonatomic, strong) NSString *work;

@end
