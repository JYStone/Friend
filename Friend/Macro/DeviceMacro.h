//
//  DeviceMacro.h
//  Friend
//
//  Created by JY on 2017/2/8.
//  Copyright © 2017年 M. All rights reserved.
//

#ifndef DeviceMacro_h
#define DeviceMacro_h

//屏幕高度
#define DEVICE_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

//屏幕宽度
#define DEVICE_SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width

//高度比例(iPhone6)
#define HEIGHT_SCALE_6  [BaseService heightScale]

//宽度比例(iPhone6)
#define WIDTH_SCALE_6  [BaseService widthScale]

//顶部状态栏高度
#define StatusBarHeight  (DEVICE_SCREEN_HEIGHT == 812.0 ? 44 : 20)

//底部HomeBar高度
#define HomeBarHeight (DEVICE_SCREEN_HEIGHT == 812.0 ? 34 : 0)

//顶部导航栏高度
#define NavigationBarHeight  44

//底部TabBar高度
#define TabBarHeight 49

//顶部安全间距
#define SafeAreaTopHeight  (StatusBarHeight + NavigationBarHeight)

//底部安全间距
#define SafeAreaBottomHeight (HomeBarHeight + TabBarHeight)

/**
 *  @brief  判断当前设备是否为iPhone4 / 5 / 6 / 6P
 */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

//字体
#define QHQFontSizeLight(fontSize)      [BaseService fontWithLightSize:fontSize]
#define QHQFontSizeRegular(fontSize)    [BaseService fontWithRegularSize:fontSize]
#define QHQFontSizeMedium(fontSize)     [BaseService fontWithMediumSize:fontSize]
#define QHQFontSizeSemibold(fontSize)   [BaseService fontWithSemiboldSize:fontSize]

// 字符串处理
#define StringTwo(s) [BaseService formatTwoDecimal:[NSString stringWithFormat:@"%lf", [s doubleValue]]]
#define StringOne(s) [BaseService formatOneDecimal:[NSString stringWithFormat:@"%lf", [s doubleValue]]]
#define String(s) [NSString stringWithFormat:@"%@", s]
#define StringInt(s) [NSString stringWithFormat:@"%.f", [s doubleValue]]

// 通知
#define AddBillSuccessNotification       @"AddBillSuccessNotification"

#endif /* QHQDeviceMacro_h */
