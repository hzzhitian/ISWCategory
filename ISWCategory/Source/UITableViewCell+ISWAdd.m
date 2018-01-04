//
//  UITableViewCell+YCAdd.m
//  youngcity
//
//  Created by chen xiaosong on 16/5/3.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import "UITableViewCell+ISWAdd.h"
@implementation UITableViewCell (ISWAdd)

+ (UITableViewCell*) isw_loadCellFromNib:(NSString*)nibName withOwner:(id)owner
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil] lastObject];
}

+(UITableViewCell *) isw_createGroupBreakWithNoSeparator
{

    UITableViewCell* separatorCell = [self isw_groupBreakWithSeparatorInset:[UIApplication sharedApplication].keyWindow.bounds.size.width];

    return separatorCell;
}

+(UITableViewCell *) isw_createGroupBreak
{
    UITableViewCell* separatorCell = [self isw_groupBreakWithSeparatorInset:0.0];

    return separatorCell;
}

+ (UITableViewCell *)isw_creatTitleCell:(NSString *)title
{
    UITableViewCell *titleSection = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    [titleSection setSelectionStyle:UITableViewCellSelectionStyleNone];

    if ([titleSection respondsToSelector:@selector(setLayoutMargins:)]) {
        [titleSection setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([titleSection respondsToSelector:@selector(setSeparatorInset:)]) {
        [titleSection setSeparatorInset:UIEdgeInsetsMake(0,12.0,0,0)];
    }

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 14,[UIApplication sharedApplication].keyWindow.bounds.size.width - 24, 15)];
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    titleLabel.textColor = [UIColor                                                    \
                            colorWithRed:((float)((0x989898 & 0xFF0000) >> 16))/255.0   \
                            green:((float)((0x989898 & 0xFF00) >> 8))/255.0             \
                            blue:((float)(0x989898 & 0xFF))/255.0                       \
                            alpha:1.0];
    
    titleLabel.text = title;

    [titleSection.contentView addSubview:titleLabel];
    
    return titleSection;
}

+ (UITableViewCell *)isw_creatSmallTitleCell:(NSString *)title
{
    UITableViewCell *titleSection = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    [titleSection setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if ([titleSection respondsToSelector:@selector(setLayoutMargins:)]) {
        [titleSection setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([titleSection respondsToSelector:@selector(setSeparatorInset:)]) {
        [titleSection setSeparatorInset:UIEdgeInsetsMake(0,12.0,0,0)];
    }
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, kScreenWidth - 24, 15)];
    titleLabel.font = [UIFont systemFontOfSize:13.0];
    titleLabel.textColor = kColorLightDark;
    
    titleLabel.text = title;
    
    [titleSection.contentView addSubview:titleLabel];
    
    return titleSection;
}

- (void)isw_noSeparator
{
    [self isw_separatorInset:kScreenWidth];
}

- (void)isw_separatorZeroInset
{
    [self isw_separatorInset:0.0];
}

- (void)isw_separatorInset08
{
    [self isw_separatorInset:8.0];
}

- (void)isw_separatorInset10
{
    [self isw_separatorInset:10.0];
}

- (void)isw_separatorInset12
{
    [self isw_separatorInset:12.0];
}

//只会出现在我的菜单
- (void)isw_separatorInset44
{
    [self isw_separatorInset:44.0];
}

//只会出现在评论列表
- (void)isw_separatorInset62
{
    [self isw_separatorInset:62.0];
}


#pragma mark - utility

- (void)isw_separatorInset:(CGFloat)inset
{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,inset,0,0)];
    }
}

+(UITableViewCell *) isw_groupBreakWithSeparatorInset:(CGFloat)inset
{
    UITableViewCell* separatorCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    separatorCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [separatorCell isw_separatorInset:inset];
    
    separatorCell.frame = CGRectMake(0, 0, kScreenWidth, 10.0);
    
    [separatorCell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];

    separatorCell.backgroundColor             = kColorPageBg;
    separatorCell.contentView.backgroundColor = kColorPageBg;
    
    return separatorCell;
}

@end
