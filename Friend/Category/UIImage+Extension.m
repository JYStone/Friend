//
//  UIImage+Extension.m
//  Friend
//
//  Created by jinjingyuan on 2017/2/8.
//  Copyright © 2017年 M. All rights reserved.
//

#import "UIImage+Extension.h"
//#import "UIImage+SubImage.h"

@implementation UIImage (Extension)
// 生成纯色图片
+ (UIImage *)imageViewColor:(UIColor *)color Size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}
// 将UIColor变换为UIImage
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

// 图片拉伸
+ (UIImage *)resizedStretchImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.15, image.size.height * 0.5, image.size.width * 0.15) resizingMode:UIImageResizingModeStretch];
}
+ (UIImage *)resizedImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5)];
}

+ (UIImage *)resizedImage:(NSString *)name leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio
{
    UIImage *image = [self imageNamed:name];
    CGFloat left = image.size.width * leftRatio;
    CGFloat top = image.size.height * topRatio;
    return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
}
// 圆形头像
+ (UIImage *)getEllipseImageWithImage:(UIImage *)originImage
{
    CGFloat padding = 5;//圆形图像距离图像的边距
    UIColor *epsBackColor = [UIColor clearColor];//图像的背景色
    CGSize originsize = originImage.size;
    CGRect originRect = CGRectMake(0, 0, originsize.width, originsize.height);
    
    UIGraphicsBeginImageContext(originsize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //目标区域。
    CGRect desRect =  CGRectMake(padding, padding, originsize.width - (padding * 2), originsize.height - (padding * 2));
    //设置填充背景色。
    CGContextSetFillColorWithColor(ctx, epsBackColor.CGColor);
    //可以替换为 [epsBackColor setFill];
    UIRectFill(originRect);//真正的填充
    //设置椭圆变形区域。
    CGContextAddEllipseInRect(ctx, desRect);
    CGContextClip(ctx);//截取椭圆区域。
    [originImage drawInRect:originRect];//将图像画在目标区域。
    // 边框 //
    CGFloat borderWidth = 9 * WIDTH_SCALE_6;
    CGContextSetStrokeColorWithColor(ctx, COLOR_FFFFFF.CGColor);//设置边框颜色
    //可以替换为 [[UIColor whiteColor] setFill];
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextSetLineWidth(ctx, borderWidth);//设置边框宽度。
    CGContextAddEllipseInRect(ctx, desRect);//在这个框中画圆
    CGContextStrokePath(ctx); // 描边框。
    // 边框 //
    UIImage* desImage = UIGraphicsGetImageFromCurrentImageContext();// 获取当前图形上下文中的图像。
    UIGraphicsEndImageContext();
    return desImage;
}
// 生成一个纯色圆角图片
+ (UIImage *)imageWithColor:(UIColor *)color bounds:(CGRect)bounds
{
    UIView *orinialView = [[UIView alloc] init];
    orinialView.frame = bounds;
    orinialView.backgroundColor = COLOR_FFFFFF;
    orinialView.layer.cornerRadius = bounds.size.height * 0.5;
    orinialView.clipsToBounds = YES;
    return [self imageFromView:orinialView];
}
// 生成一个虚线图片
+ (UIImage *)dottLineImageWithBounds:(CGRect)bounds
{
    UIGraphicsBeginImageContext(bounds.size); //开始画线
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapSquare); //设置线条终点形状
    CGFloat lengths[] = {14, 16};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, COLOR_FFC43A.CGColor);
    CGContextSetLineWidth(line, 4);
    CGContextSetLineDash(line, 0, lengths, 2); //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0); //开始画线
    CGContextAddLineToPoint(line, bounds.size.width, 2.0);
    CGContextStrokePath(line);
    return UIGraphicsGetImageFromCurrentImageContext();
}
// 生成一个渐变色图片
+ (UIImage *)rectangleGradientImageFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor gradientDirectionType:(GradientDirectionType)gradientDirectionType imageSize:(CGSize)imageSize {
    if (!fromColor || !toColor) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect frame = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    [[self class] drawLinearGradientFromColor:fromColor toColor:toColor gradientType:gradientDirectionType frame:frame context:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)rectangleGradientImageWithColors:(NSArray*)colors ranges:(NSArray *)ranges gradientDirectionType:(GradientDirectionType)gradientDirectionType imageSize:(CGSize)imageSize {
    if (colors.count < 2) {
        return nil;
    }
    if (GradientDirectionTypeTopLeftToDownRight == gradientDirectionType || GradientDirectionTypeTopRightToDownLeft == gradientDirectionType) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //draw step by step with two colors
    for (NSInteger i = 0; i+1 < colors.count; i++) {
        UIColor *fromColor = colors[i];
        UIColor *toColor = colors[i + 1];
        CGFloat startPoint = [ranges[i] floatValue];
        CGFloat endPoint = [ranges[i+1] floatValue];
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        CGRect frame = CGRectZero;
        switch (gradientDirectionType) {
            case GradientDirectionTypeTopToBottom:
                frame = CGRectMake(0.0f, height*startPoint, width, height*(endPoint - startPoint));
                break;
            case GradientDirectionTypeLeftToRight:
                frame = CGRectMake(width * startPoint, 0.0f, width*(endPoint - startPoint), height);
                break;
            default:
                break;
        }
        [[self class] drawLinearGradientFromColor:fromColor toColor:toColor gradientType:gradientDirectionType frame:frame context:context];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return image;
}

+ (void)drawLinearGradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor gradientType:(GradientDirectionType)gradientType frame:(CGRect)frame context:(CGContextRef)context {
    if (!fromColor || !toColor) {
        return;
    }
    NSArray *colors = @[(id)fromColor.CGColor,(id)toColor.CGColor];
    CGColorSpaceRef colorSpace = CGColorGetColorSpace(toColor.CGColor);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, NULL);
    CGPoint start = CGPointZero;
    CGPoint end = CGPointZero;
    switch (gradientType) {
        case GradientDirectionTypeTopToBottom:
            //top left
            start = frame.origin;
            //down left
            end = CGPointMake(frame.origin.x,CGRectGetMaxY(frame));
            break;
        case GradientDirectionTypeLeftToRight:
            //top left
            start = frame.origin;
            //top right
            end = CGPointMake(CGRectGetMaxX(frame), frame.origin.y);
            break;
        case GradientDirectionTypeTopLeftToDownRight:
            //top left
            start = frame.origin;
            //down right
            end = CGPointMake(CGRectGetMaxX(frame),CGRectGetMaxY(frame));
            break;
        case GradientDirectionTypeTopRightToDownLeft:
            //top right
            start = CGPointMake(CGRectGetMaxX(frame), frame.origin.y);
            //down left
            end = CGPointMake(frame.origin.x,CGRectGetMaxY(frame));
            break;
        default:
            break;
    }
    //pay attention to this parameter when you painting step by step(CGGradientDrawingOptions options) kCGGradientDrawsBeforeStartLocation| kCGGradientDrawsAfterEndLocation
    CGContextDrawLinearGradient(context, gradient, start, end, 0);
    CGGradientRelease(gradient);
    //    CGColorSpaceRelease(colorSpace);
}

// 设置圆角图片
- (UIImage *)circleImage
{
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将原照片画到图形上下文
    [self drawInRect:rect];
    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UIView转化为UIImage
+ (UIImage *)imageFromView:(UIView *)view
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 将两个图片生成一张图片
+ (UIImage*)mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage
{
    CGImageRef firstImageRef = firstImage.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [firstImage drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [secondImage drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 切割图片 */
+ (UIImage *)imageWithCornerRadius:(CGFloat)radius withImageView:(UIImageView *)imageView{
    CGRect rect = (CGRect){0.f, 0.f, imageView.frame.size};
    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [imageView.image drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}
@end
