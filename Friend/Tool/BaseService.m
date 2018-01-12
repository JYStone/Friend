//
//  BaseService.m
//  Friend
//
//  Created by JY on 2017/2/8.
//  Copyright © 2017年 M. All rights reserved.
//

#import "BaseService.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD+Add.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@implementation BaseService
/** 宽度比例 */
+ (CGFloat)widthScale
{
    return DEVICE_SCREEN_WIDTH / 750.0;
}
/** 高度比例 */
+ (CGFloat)heightScale
{
    CGFloat height = (DEVICE_SCREEN_HEIGHT == 812) ? 667 : DEVICE_SCREEN_HEIGHT;
    height = (height == 480) ? 568 : height;
    return height / 1334.0;
}

/** 判断字符串是否为空 */
+(BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

/** 判断手势密码连接点数是否正确 */
+(BOOL)isRightLengthGesturePassword:(NSString *)gesturePassword
{
    if ([self isBlankString:gesturePassword] == YES) {
        return NO;
    }
    
    NSArray *gesturePasswordArray = [gesturePassword componentsSeparatedByString:@","];
    if ([gesturePasswordArray count] >= 4) {
        return YES;
    }
    return NO;
}

/** 判断网络连接状态 */
+(BOOL) isConnectionAvailable
{
    BOOL isExistenceNetwork = [[NSUserDefaults standardUserDefaults]boolForKey:@"networkStatus"];
    return isExistenceNetwork;
}

/**  MD5-32位加密 */
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString
{
    
    if ([self isBlankString:srcString] == YES) {
        return @"nothing";
    }
    
    const char *cStr = [srcString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/** 是否登录 */
+ (BOOL)isLogin
{
    return [[[[NSUserDefaults standardUserDefaults] objectForKey:@"user"] objectForKey:@"isLogin"] boolValue];
}

/** 清除用户session记录 */
+(void)logout
{
    
}

/** 展示错误提示 */
+ (void)showErrorWithMsg:(NSString *)msg
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD showError:msg toView:window];
}

/** 展示正确提示 */
+ (void)showSuccessWithMsg:(NSString *)msg
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD showSuccess:msg toView:window];
}

/** 网络异常提示 */
+ (void)showNetworkIsNotConnectedAlertView
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD showError:@"网络异常，请检查网络环境" toView:window];
}

/** 数据加载失败提示 */
+ (void)showLoadDataErrorAlert
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD showError:@"网络请求超时，请稍后重试" toView:window];
}

/** 空值处理 */
+ (id) processDictionaryIsNSNull:(id)obj
{
    const NSString *blank = @"";
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:blank
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"]) {
                    [dt setObject:blank
                           forKey:key];
                }
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self processDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}

/** 日期戳转换成日期 */
+(NSString *)formatDateStamp:(NSString *)dateStamp
{
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[dateStamp doubleValue] /1000];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *regStr = [df stringFromDate:dt];
    return regStr;
}

/** 日期 MM月dd日 */
+(NSString *)formatDate_MD:(NSString *)dateStamp
{
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[dateStamp doubleValue] /1000];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM月dd日"];
    NSString *regStr = [df stringFromDate:dt];
    return regStr;
}

/** 获取当前时间 */
+ (NSString *)getCurrentTime
{
    NSTimeInterval current_time = [[NSDate date] timeIntervalSince1970];
    return [[NSString alloc]initWithFormat:@"%.f",current_time * 1000];
}

/** 判断当前时间是否处于某个时间段内 */
+ (BOOL)validateWithStartTime:(NSString *)startTime withExpireTime:(NSString *)expireTime currentDate:(NSString *)currentTime
{
    NSDate *today;
    if (currentTime != nil) {
        today = [NSDate dateWithTimeIntervalSince1970:currentTime.doubleValue / 1000.0];
    } else {
        today = [NSDate date];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
    [dateFormat setDateFormat:@"yyyyMMdd"];
    
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

/** 判断是否是url */
+ (BOOL)isVerifyURL:(NSString *)url{
    if ([self isBlankString:url] == YES) {
        return NO;
    }
    NSString *identify = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", identify];
    if ([predicate evaluateWithObject:url] == YES) {
        return YES;
    }
    return NO;
}

/** 设置字体 */
+ (UIFont *)fontWithLightSize:(CGFloat)fontSize
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Light" size:fontSize * WIDTH_SCALE_6];
    } else {
        return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize * WIDTH_SCALE_6];
    }
}

+ (UIFont *)fontWithRegularSize:(CGFloat)fontSize
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize * WIDTH_SCALE_6];
    } else {
        return [UIFont fontWithName:@"Helvetica Neue" size:fontSize * WIDTH_SCALE_6];
    }
}

+ (UIFont *)fontWithMediumSize:(CGFloat)fontSize
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize * WIDTH_SCALE_6];
    } else {
        return [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize * WIDTH_SCALE_6];
    }
}

+ (UIFont *)fontWithSemiboldSize:(CGFloat)fontSize
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize * WIDTH_SCALE_6];
    } else {
        return [UIFont fontWithName:@"HelveticaNeue-Semibold" size:fontSize * WIDTH_SCALE_6];
    }
}

/** 开启相机权限 */
+ (void)openPrivacyCameraPermissions
{
    
}

/** 开启相册权限 */
+ (void)openPrivacyPhotoLibraryPermissions
{
    
}

/** 开启位置权限 */
+ (void)openPrivacyLocationPermissions
{
    
}

@end
