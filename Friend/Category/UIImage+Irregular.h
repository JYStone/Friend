//
//  UIImage+Irregular.h
//  Friend
//
//  Created by jy on 2018/1/8.
//  Copyright © 2018年 M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Irregular)
//// 这种是路径遮盖法
+ (UIImage*)maskImage:(UIImage*)originImage toPath:(UIBezierPath*)path;
////为图像创建透明区域
+ (CGImageRef)CopyImageAndAddAlphaChannel:(CGImageRef)sourceImage;
/////利用图像遮盖
+ (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
@end
