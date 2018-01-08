//
//  NSString+Extension.h
//  Friend
//
//  Created by JY on 2017/4/17.
//  Copyright © 2017年 M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
// 计算lable文字长度
+ (CGFloat)widthForLable:(NSString *)content with:(UIFont *)font;
@end
