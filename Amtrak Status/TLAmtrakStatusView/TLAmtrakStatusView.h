//
//  TLAmtrakStatusView.h
//  Amtrak Status
//
//  Created by Todd Lunter on 7/25/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TLAmtrakStatusView : NSScrollView

- (void)setDataSource:(id<NSTableViewDataSource>)dataSource;

@property (nonatomic, strong) NSScrollView *scrollView;
@property (nonatomic, strong) NSTableView *tableView;

@end
