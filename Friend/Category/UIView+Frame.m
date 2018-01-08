//
//  UIView+Frame.m
//  Friend
//
//  Created by JY on 2017/2/8.
//  Copyright © 2017年 M. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
@dynamic scaleFrame6;

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
    
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setScaleFrame6:(CGRect)scaleFrame6
{
    self.frame = CGRectMake(scaleFrame6.origin.x * WIDTH_SCALE_6, scaleFrame6.origin.y * HEIGHT_SCALE_6 , scaleFrame6.size.width * WIDTH_SCALE_6, scaleFrame6.size.height * HEIGHT_SCALE_6);
}

-(CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}
@end
