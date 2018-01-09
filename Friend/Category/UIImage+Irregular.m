//
//  UIImage+Irregular.m
//  Friend
//
//  Created by jy on 2018/1/8.
//  Copyright © 2018年 M. All rights reserved.
//

#import "UIImage+Irregular.h"

@implementation UIImage (Irregular)
//// 这种是路径遮盖法
+ (UIImage*)maskImage:(UIImage*)originImage toPath:(UIBezierPath*)path
{
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
    [path addClip];
    [originImage drawAtPoint:CGPointZero];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

////为图像创建透明区域
+ (CGImageRef)CopyImageAndAddAlphaChannel:(CGImageRef)sourceImage
{
    CGImageRef retVal = NULL;
    size_t width = CGImageGetWidth(sourceImage);
    size_t height = CGImageGetHeight(sourceImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL, width, height,
                                                          
                                                          8, 0, colorSpace,
                                                          
                                                          kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
    
    
    
    if (offscreenContext != NULL){
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), sourceImage);
        retVal = CGBitmapContextCreateImage(offscreenContext);
        CGContextRelease(offscreenContext);
    }
    CGColorSpaceRelease(colorSpace);
    return retVal;
}

/////利用图像遮盖
+ (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, true);
    CGImageRef sourceImage = [image CGImage];
    CGImageRef imageWithAlpha = sourceImage;
    //add alpha channel for images that don't have one (ie GIF, JPEG, etc...)
    //this however has a computational cost
    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone) {
//        imageWithAlpha = [ImageUtil CopyImageAndAddAlphaChannel:sourceImage];
    }
    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
    CGImageRelease(mask);
    //release imageWithAlpha if it was created by CopyImageAndAddAlphaChannel
    if (sourceImage != imageWithAlpha) {
        CGImageRelease(imageWithAlpha);
    }
    UIImage* retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    return retImage;
}
@end
