//
//  TLAmtrakStatusView.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/25/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TLAmtrakStatusView : NSScrollView

+ (NSInteger)rowHeight;
- (void)setTrainData:(NSArray *)trainData;

@property NSDictionary *header;

@end
