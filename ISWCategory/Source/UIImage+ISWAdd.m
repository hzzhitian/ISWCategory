//
//  UIImage+Screen.m
//  youngcity
//
//  Created by stony on 15/12/28.
//  Copyright © 2015年 Zhitian Network Tech. All rights reserved.
//

#import "UIImage+ISWAdd.h"

#import "SDImageCache.h"
#import "SDWebImageManager.h"

//#import <ImageIO/ImageIO.h>
#define kImageHeight      65.0
#define kImageViewHeight  150.0

#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#define fromCF (__bridge id)
#else
#define toCF (CFTypeRef)
#define fromCF (id)
#endif


@implementation UIImage (ISWAdd)

+ (void)isw_cacheUrlImage:(NSString*)url
{
    if(url==nil)
        return;
    
    if(url.length==0)
        return;

    [SDWebImageManager.sharedManager downloadImageWithURL:[NSURL URLWithString:url]
                                                  options:0
                                                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                     
                                                 } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                     
                                                 }];
}

+ (UIImage *)isw_imageWithBase64Str:(NSString *)str
{
    NSRange  range   = [str rangeOfString:@"base64,"];
    
    if(range.location == NSNotFound)
        return nil;

    NSString *imgStr = [str substringFromIndex:range.location+range.length];
    NSData  *imgData =  [[NSData alloc] initWithBase64EncodedString:imgStr options:NSDataBase64DecodingIgnoreUnknownCharacters];

    return [UIImage imageWithData:imgData];
}

+ (UIImage *)isw_imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//按宽高比选择图片
+ (UIImage *)isw_imageNamedWithWHRatio:(NSString *)name
{
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat screenHeight = screen.bounds.size.height * screen.scale;

    NSString *imageName;
    if (screenHeight == 960. || screenHeight == 480.) {
        imageName = [name stringByAppendingString:@"_fat"];
    } else if (screenHeight == 1136. || screenHeight == 1334. || screenHeight == 2208.) {
        imageName = [name stringByAppendingString:@"_slim"];
    }

    NSString *url = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    
    UIImage *img = [UIImage imageWithContentsOfFile:url];
    
    return img;
    
}

- (NSData *)isw_imageByScalingToWithSize:(CGFloat)len
{
    if (self.size.width <= len && self.size.height <= len)
        return UIImageJPEGRepresentation(self, (CGFloat)0.9);
    
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (self.size.width < self.size.height) {
        btHeight = len;
        btWidth = self.size.width * (len / self.size.height);
    } else {
        btWidth = len;
        btHeight = self.size.height * (len / self.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return UIImageJPEGRepresentation(
                                     [self isw_imageByScalingAndCroppingWithSize:targetSize],
                                     (CGFloat)0.9);
}

- (UIImage*)isw_imageInScale:(CGFloat)scale
{
    return [UIImage imageWithData:UIImagePNGRepresentation(self) scale:3];
}

- (UIImage *)isw_imageByScalingAndCroppingWithSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)isw_roundImageWithRadius:(CGFloat)radius
                        fillColor:(UIColor *)color
{
    return [UIImage isw_roundImageWithRadius:radius fillColor:color borderWidth:0 borderColor:[UIColor clearColor]];
}

+ (UIImage *)isw_roundImageWithRadius:(CGFloat)radius
                        fillColor:(UIColor *)color
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
{
    CGSize size = CGSizeMake(radius*2+2, radius*2+2);
    
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image imageByRoundCornerRadius:radius borderWidth:borderWidth borderColor:borderColor];
    
    image = [image resizeByLeftCap:0.5f andTopCap:0.5f];
    
    return image;
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor {
    return [self imageByRoundCornerRadius:radius
                                  corners:UIRectCornerAllCorners
                              borderWidth:borderWidth
                              borderColor:borderColor
                           borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIImage *)resizeByLeftCap:(CGFloat)leftCap andTopCap:(CGFloat)topCap{
    
    return [self stretchableImageWithLeftCapWidth:self.size.width * leftCap topCapHeight:self.size.height * topCap];
}

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage*) isw_getImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

/**
 传入需要的占位图尺寸 获取占位图
 
 @param size 需要的站位图尺寸
 @return 占位图
 */

+ (UIImage *)isw_placeholderImageWithSize:(CGSize)size {
    
    // 占位图的背景色
    UIColor *backgroundColor = [UIColor                                                    \
                                colorWithRed:((float)((0xf4f4f4 & 0xFF0000) >> 16))/255.0   \
                                green:((float)((0xf4f4f4 & 0xFF00) >> 8))/255.0             \
                                blue:((float)(0xf4f4f4 & 0xFF))/255.0                       \
                                alpha:1.0];
    // 中间LOGO图片
    UIImage *image = [UIImage imageNamed:@"placeholder_gray_square"];
    // 原uiimage 宽高比
    CGFloat scale = (kImageHeight / kImageViewHeight) * 2 *0.43 /0.36;
    
    CGFloat logoWH = 0;
    
    //外面ImageView的高宽比
    NSString * aspectRatio =[NSString stringWithFormat:@"%.2f", ((size.height *1.0)/ (size.width *1.0))];
    
    
    NSInteger imageType;
    
    //高度大于宽度
    if (aspectRatio.floatValue > 1.0) {
        imageType = YCImageEndways;
        logoWH = size.width *scale;
        
    }else if (aspectRatio.floatValue == 1.0)
    {
        imageType = YCImageOriginal;
        return image;
        
    }else if ( 0.5 <= aspectRatio.floatValue <= 0.8)
    {
        imageType = YCImageMiddleType;
        logoWH = size.height * scale ;
        
    }else {
        
        imageType = YCImageExtremesType;
        logoWH = size.height *scale;
    }
    
    //做缓存
    
    UIImage *lastPreviousCachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%long",(long)imageType]];
    
    if (lastPreviousCachedImage ) {
        return lastPreviousCachedImage;
    }
    //
    
    CGSize logoSize = CGSizeMake(logoWH, logoWH);
    // 打开上下文
    UIGraphicsBeginImageContextWithOptions(size,0, [UIScreen mainScreen].scale);
    // 绘图
    [backgroundColor set];
    UIRectFill(CGRectMake(0,0, size.width, size.height));
    CGFloat imageX = (size.width / 2) - (logoSize.width / 2);
    CGFloat imageY = (size.height / 2) - (logoSize.height / 2);
    [image drawInRect:CGRectMake(imageX, imageY, logoSize.width, logoSize.height)];
    UIImage *resImage =UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    [[SDImageCache sharedImageCache] storeImage:resImage forKey:[NSString stringWithFormat:@"%long",(long)imageType]];
    
    
    return resImage;
}

static int delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i) {
    int delayCentiseconds = 1;
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties) {
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties) {
            NSNumber *number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (number == NULL || [number doubleValue] == 0) {
                number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            if ([number doubleValue] > 0) {
                // Even though the GIF stores the delay as an integer number of centiseconds, ImageIO “helpfully” converts that to seconds for us.
                delayCentiseconds = (int)lrint([number doubleValue] * 100);
            }
        }
        CFRelease(properties);
    }
    return delayCentiseconds;
}

static void createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecondsOut[count]) {
    for (size_t i = 0; i < count; ++i) {
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecondsOut[i] = delayCentisecondsForImageAtIndex(source, i);
    }
}

static int sum(size_t const count, int const *const values) {
    int theSum = 0;
    for (size_t i = 0; i < count; ++i) {
        theSum += values[i];
    }
    return theSum;
}

static int pairGCD(int a, int b) {
    if (a < b)
        return pairGCD(b, a);
    while (true) {
        int const r = a % b;
        if (r == 0)
            return b;
        a = b;
        b = r;
    }
}

static int vectorGCD(size_t const count, int const *const values) {
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i) {
        // Note that after I process the first few elements of the vector, `gcd` will probably be smaller than any remaining element.  By passing the smaller value as the second argument to `pairGCD`, I avoid making it swap the arguments.
        gcd = pairGCD(values[i], gcd);
    }
    return gcd;
}

static NSArray *frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds) {
    int const gcd = vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i) {
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j) {
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}

static void releaseImages(size_t const count, CGImageRef const images[count]) {
    for (size_t i = 0; i < count; ++i) {
        CGImageRelease(images[i]);
    }
}

static UIImage *animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source) {
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count]; // in centiseconds
    createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = sum(count, delayCentiseconds);
    NSArray *const frames = frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    releaseImages(count, images);
    return animation;
}

static UIImage *animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef CF_RELEASES_ARGUMENT source) {
    if (source) {
        UIImage *const image = animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    } else {
        return nil;
    }
}


+ (UIImage *)isw_animatedImageWithAnimatedGIFURL:(NSURL *)url {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(toCF url, NULL));
}







@end
