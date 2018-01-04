//
//  UIImageView+YCAdd.m
//  youngcity
//
//  Created by zhitian on 2017/11/9.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import "UIImageView+ISWAdd.h"
#import "UIImage+ISWAdd.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (ISWAdd)


- (void)isw_sd_setImageWithUrlStirng: (NSString*)url  placeHolderWithImageViewSize : (CGSize) size
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage isw_placeholderImageWithSize:size]];
}

- (void)isw_sd_setImageWithUrlStirng: (NSString*)url  placeHolderWithPerferredSize : (CGSize) size
{
    url = nil;
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage isw_placeholderImageWithSize:size]];
    
}

@end
