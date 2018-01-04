//
//  UIImageView+YCAdd.h
//  youngcity
//
//  Created by zhitian on 2017/11/9.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ISWAdd)

- (void)isw_sd_setImageWithUrlStirng: (NSString*)url  placeHolderWithImageViewSize : (CGSize) size;

- (void)isw_sd_setImageWithUrlStirng: (NSString*)url  placeHolderWithPerferredSize : (CGSize) size;

@end


