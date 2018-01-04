//
//  UITableView+ISWAdd.m
//  youngcity
//
//  Created by zhitian on 2017/12/20.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import "UITableView+ISWAdd.h"
#import "MJRefresh.h"
@implementation UITableView (ISWAdd)


- (void)isw_addRefreshHeaderWithRefreshingBlock:(void(^)(void))block
{
    MJRefreshNormalHeader  *header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    [self setupRefreshHeaderStyle:header];
    self.mj_header = header;
}

- (void)isw_addRefreshHeaderWithTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshNormalHeader  *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    [self setupRefreshHeaderStyle:header];
    self.mj_header = header;
}

- (void)isw_addRefreshFooterWithTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshAutoNormalFooter  *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    [self setupRefreshFooterStyle:footer];
    self.mj_footer = footer;
}

- (void)isw_hideHeaderStateLabel
{
    MJRefreshNormalHeader  *header  = (MJRefreshNormalHeader*)self.mj_header;
    header.stateLabel.hidden = YES;
}

- (void)isw_endHeaderRefreshing
{
    if (self.mj_header == nil) return;
    [self.mj_header endRefreshing];
}

- (void)isw_endFooterRefreshing
{
    if (self.mj_footer == nil) return;
    [self.mj_footer endRefreshing];
}

- (void)isw_endFooterRefreshingWithNoMoreData
{
    if (self.mj_footer == nil) return;
    [self.mj_footer endRefreshingWithNoMoreData];
}

//统一设置上下拉刷新

- (void)setupRefreshFooterStyle: (MJRefreshAutoNormalFooter *)footer
{
    [footer setTitle:@"没有了" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:15];
    footer.triggerAutomaticallyRefreshPercent = 0.0;
    footer.stateLabel.textColor = [UIColor lightGrayColor];
}

- (void)setupRefreshHeaderStyle: (MJRefreshNormalHeader *)header
{
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:15];
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.hidden = YES;
    //    header.mj_h = 70;
}

-(void)isw_setTableStyleWithFixedHeigth
{
    [self isw_noSeparator];
    
    self.separatorColor  = kColorSeparator;
    self.backgroundColor = kColorPageBg;
    
}

-(void)isw_setTableStyleWithDynamicHeigth
{
    [self isw_noSeparator];
    
    self.separatorColor = kColorSeparator;
    self.backgroundColor = kColorPageBg;
    
    self.estimatedRowHeight = 100.0;
    self.rowHeight = UITableViewAutomaticDimension;
}

- (void)isw_noSeparator
{
    [self isw_separatorInset:kScreenWidth];
}

- (void)isw_separatorInset:(CGFloat)inset
{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,inset,0,0)];
    }
}


@end
