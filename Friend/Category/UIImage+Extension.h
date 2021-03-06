//
//  UIImage+Extension.h
//  Friend
//
//  Created by jinjingyuan on 2017/2/8.
//  Copyright © 2017年 M. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  渐变方向枚举
 */
typedef NS_ENUM(NSInteger,GradientDirectionType) {
    GradientDirectionTypeTopToBottom = 0,// 从上到下
    GradientDirectionTypeLeftToRight = 1,// 从左到右
    GradientDirectionTypeTopLeftToDownRight = 2,//左上到右下
    GradientDirectionTypeTopRightToDownLeft = 3,//右上到左下
};
@interface UIImage (Extension)
// 生成纯色图片
+ (UIImage *)imageViewColor:(UIColor *)color Size:(CGSize)size;
// 将UIColor变换为UIImage
+ (UIImage *)createImageWithColor:(UIColor *)color;
// 图片拉伸
+ (UIImage *)resizedImage:(NSString *)imageName;
// 图片拉伸模式
+ (UIImage *)resizedStretchImage:(NSString *)imageName;
+ (UIImage *)resizedImage:(NSString *)name leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio;
// 圆形头像
+ (UIImage *)getEllipseImageWithImage:(UIImage *)originImage;
// 生成一个纯色圆角图片
+ (UIImage *)imageWithColor:(UIColor *)color bounds:(CGRect)bounds;
// 生成一个虚线图片
+ (UIImage *)dottLineImageWithBounds:(CGRect)bounds;
// 生成一个渐变色图片
// 只有两个色值
+ (UIImage *)rectangleGradientImageFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor gradientDirectionType:(GradientDirectionType)gradientDirectionType imageSize:(CGSize)imageSize;
// 颜色数组
+ (UIImage *)rectangleGradientImageWithColors:(NSArray*)colors ranges:(NSArray *)ranges gradientDirectionType:(GradientDirectionType)gradientDirectionType imageSize:(CGSize)imageSize;
// 设置圆角图片
- (UIImage *)circleImage;

/** UIView转化为UIImage */
+ (UIImage *)imageFromView:(UIView *)view;
/** 将两个图片生成一张图片 */
+ (UIImage *)mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;
/** 切割图片 */
+ (UIImage *)imageWithCornerRadius:(CGFloat)radius withImageView:(UIImageView *)imageView;
/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
@end
