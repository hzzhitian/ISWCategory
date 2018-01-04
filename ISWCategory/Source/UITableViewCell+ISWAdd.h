//
//  UITableViewCell+YCAdd.h
//  youngcity
//
//  Created by chen xiaosong on 16/5/3.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ISWAdd)

+(UITableViewCell *)isw_creatTitleCell:(NSString *)title;

+(UITableViewCell *) isw_createGroupBreakWithNoSeparator;

+(UITableViewCell *) isw_createGroupBreak;

+ (UITableViewCell *)isw_creatSmallTitleCell:(NSString *)title;

- (void)isw_noSeparator;

- (void)isw_separatorZeroInset;
- (void)isw_separatorInset08;
- (void)isw_separatorInset10;
- (void)isw_separatorInset12;
- (void)isw_separatorInset44;
- (void)isw_separatorInset62;

- (void)isw_separatorInset:(CGFloat)inset;

@end
