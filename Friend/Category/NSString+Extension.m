//
//  NSString+Extension.m
//  Friend
//
//  Created by JY on 2017/4/17.
//  Copyright © 2017年 M. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

// 计算lable文字长度
+ (CGFloat)widthForLable:(NSString *)content with:(UIFont *)font
{
    CGSize size = [[NSString stringWithFormat:@"%@", content] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
    return size.width;
}

@end
