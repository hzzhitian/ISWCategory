//
//  UIView+YCAdd.h
//  youngcity
//
//  Created by stony on 16/7/29.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ISWAdd)

- (void)isw_outlineStyle:(CGFloat)borderWidth borderColor:(UIColor*)color;
- (void)isw_roundCorner:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor*)color;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@end
