//
//  TLTrainListItemView.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/28/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TLTrainListItemTrainView, TLTrainListItemScheduledView, TLTrainListItemEstimatedView;

@interface TLTrainListItemView : NSView

- (id)initWithIndex:(NSInteger)i andTrain:(NSString*)t andScheduled:(NSString*)s andEstimated:(NSString*)e;

@property (strong, nonatomic) TLTrainListItemTrainView *train;
@property (strong, nonatomic) TLTrainListItemEstimatedView *estimated;
@property (strong, nonatomic) TLTrainListItemScheduledView *scheduled;

@end
