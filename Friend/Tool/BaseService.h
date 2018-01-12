//
//  BaseService.h
//  Friend
//
//  Created by JY on 2017/2/8.
//  Copyright © 2017年 M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseService : NSObject
/** 宽度比例 */
+ (CGFloat)widthScale;

/** 高度比例 */
+ (CGFloat)heightScale;

/** 判断字符串是否为空 */
+(BOOL)isBlankString:(NSString *_Nullable)string;

/** 判断手势密码连接点数是否正确 */
+(BOOL)isRightLengthGesturePassword:(NSString *_Nullable)gesturePassword;

/** 判断网络连接状态 */
+(BOOL) isConnectionAvailable;

/**  MD5-32位加密 */
+ (NSString *_Nullable)getMd5_32Bit_String:(NSString *_Nullable)srcString;

/** 是否登录 */
+ (BOOL)isLogin;

/** 清除用户session记录 */
+(void)logout;

/** 展示错误提示 */
+ (void)showErrorWithMsg:(NSString *_Nullable)msg;

/** 展示正确提示 */
+ (void)showSuccessWithMsg:(NSString *_Nullable)msg;

/** 网络异常提示 */
+ (void)showNetworkIsNotConnectedAlertView;

/** 数据加载失败提示 */
+ (void)showLoadDataErrorAlert;

/** 空值处理 */
+ (id _Nullable ) processDictionaryIsNSNull:(id _Nullable )obj;

/** 日期戳转换成日期 */
+(NSString *_Nullable)formatDateStamp:(NSString *_Nullable)dateStamp;

/** 日期 MM月dd日 */
+(NSString *_Nullable)formatDate_MD:(NSString *_Nullable)dateStamp;

/** 获取当前时间 */
+ (NSString *_Nullable)getCurrentTime;

/** 判断当前时间是否处于某个时间段内 */
+ (BOOL)validateWithStartTime:(NSString *_Nullable)startTime withExpireTime:(NSString *_Nullable)expireTime currentDate:(NSString *_Nullable)currentTime;

/** 判断是否是url */
+ (BOOL)isVerifyURL:(nullable NSString *)url;

/** 设置字体 */
+ (UIFont *_Nullable)fontWithLightSize:(CGFloat)fontSize;
+ (UIFont *_Nullable)fontWithRegularSize:(CGFloat)fontSize;
+ (UIFont *_Nullable)fontWithMediumSize:(CGFloat)fontSize;
+ (UIFont *_Nullable)fontWithSemiboldSize:(CGFloat)fontSize;

/** 开启相机权限 */
+ (void)openPrivacyCameraPermissions;

/** 开启相册权限 */
+ (void)openPrivacyPhotoLibraryPermissions;

/** 开启位置权限 */
+ (void)openPrivacyLocationPermissions;

/** 是否开启相机相册权限 如果没有开启 需要提示开启*/

@end
