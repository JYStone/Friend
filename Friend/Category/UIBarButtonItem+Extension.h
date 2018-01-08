//
//  UIBarButtonItem+Extension.h
//  SinaTest
//
//  Created by 金靖媛 on 15/8/4.
//  Copyright (c) 2015年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
