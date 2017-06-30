//
//  TLAmtrakStatusView.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/25/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TLAmtrakStatusView : NSView

+ (NSInteger)rowHeight;
- (void)setTrainData:(NSArray *)trainData;
- (void)updateView;
- (NSArray*)remainingTrains;

@property TLTrain *header;
@property NSArray *trains;

@end
