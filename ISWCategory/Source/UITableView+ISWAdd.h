//
//  UITableView+ISWAdd.h
//  youngcity
//
//  Created by zhitian on 2017/12/20.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ISWAdd)

- (void)isw_addRefreshHeaderWithTarget:(id)target refreshingAction:(SEL)action;
- (void)isw_addRefreshFooterWithTarget:(id)target refreshingAction:(SEL)action;
- (void)isw_addRefreshHeaderWithRefreshingBlock:(void(^)(void))block;

- (void)isw_endHeaderRefreshing;
- (void)isw_endFooterRefreshing;
- (void)isw_hideHeaderStateLabel;
- (void)isw_endFooterRefreshingWithNoMoreData;

-(void)isw_setTableStyleWithFixedHeigth;
-(void)isw_setTableStyleWithDynamicHeigth;

- (void)isw_noSeparator;
- (void)isw_separatorInset:(CGFloat)inset;

@end
