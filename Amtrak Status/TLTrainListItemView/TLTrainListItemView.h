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

- (id)initWithIndex:(NSInteger)i andTrain:(NSString*)t andScheduled:(NSString*)s andEstimated:(NSString*)e andColor:(NSColor*)color;

@property TLTrainListItemTrainView *train;
@property TLTrainListItemEstimatedView *estimated;
@property TLTrainListItemScheduledView *scheduled;
@property NSColor *backgroundColor;

@end
