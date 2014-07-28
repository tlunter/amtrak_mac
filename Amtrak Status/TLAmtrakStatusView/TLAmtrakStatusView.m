//
//  TLAmtrakStatusView.m
//  Amtrak Status
//
//  Created by Todd Lunter on 7/25/14.
//  Copyright (c) 2014 Todd Lunter. All rights reserved.
//

#import "TLAmtrakStatusView.h"

@implementation TLAmtrakStatusView

@synthesize tableView, scrollView;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setScrollView:[[NSScrollView alloc] initWithFrame:[self bounds]]];
        [self setTableView:[[NSTableView alloc] initWithFrame:[self bounds]]];
        
        [[self scrollView] setBorderType:NSNoBorder];
        
        [self buildColumns];
        
        [[self scrollView] setDocumentView:tableView];
        [self addSubview:[self scrollView]];
    }
    return self;
}   

- (void)buildColumns {
    [[self tableView] setAllowsColumnResizing:NO];
    [[self tableView] setAllowsMultipleSelection:NO];
    [[self tableView] setAllowsColumnSelection:NO];
    
    NSTableColumn *trainHeader = [[NSTableColumn alloc] initWithIdentifier:@"train"];
    [[trainHeader headerCell] setStringValue:@"Train"];
    [trainHeader setWidth:42];
    [[self tableView] addTableColumn:trainHeader];
    
    NSTableColumn *scheduledHeader = [[NSTableColumn alloc] initWithIdentifier:@"scheduled"];
    [[scheduledHeader headerCell] setStringValue:@"Scheduled"];
    [scheduledHeader setWidth:75];
    [[self tableView] addTableColumn:scheduledHeader];
    
    NSTableColumn *estimatedHeader = [[NSTableColumn alloc] initWithIdentifier:@"estimated"];
    [[estimatedHeader headerCell] setStringValue:@"Estimated"];
    [estimatedHeader setWidth:75];
    [[self tableView] addTableColumn:estimatedHeader];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

- (void)setDataSource:(id<NSTableViewDataSource>)dataSource {
    [tableView setDataSource:dataSource];
}

@end
