//
//  PrivacyPermission.h
//  Friend
//
//  Created by jy on 2018/1/16.
//  Copyright © 2018年 M. All rights reserved.
//
//  统一处理隐私权限
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PrivacyPermissionType) {
    PrivacyPermissionTypePhoto = 0,
    PrivacyPermissionTypeCamera,
    PrivacyPermissionTypeMedia,
    PrivacyPermissionTypeMicrophone,
    PrivacyPermissionTypeLocation,
    PrivacyPermissionTypeBluetooth,
    PrivacyPermissionTypePushNotification,
    PrivacyPermissionTypeSpeech,
    PrivacyPermissionTypeEvent,
    PrivacyPermissionTypeContact,
    PrivacyPermissionTypeReminder,
    PrivacyPermissionTypeHealth
};

/*
 PrivacyPermissionTypeHealth只有步数,步行+跑步距离和以爬楼层三种读写权限，如果想要访问更多关于`HealthStore`权限请参考链接
 https://github.com/GREENBANYAN/skoal
 */

typedef NS_ENUM(NSUInteger,PrivacyPermissionAuthorizationStatus) {
    PrivacyPermissionAuthorizationStatusAuthorized = 0,
    PrivacyPermissionAuthorizationStatusDenied,
    PrivacyPermissionAuthorizationStatusNotDetermined,
    PrivacyPermissionAuthorizationStatusRestricted,
    PrivacyPermissionAuthorizationStatusLocationAlways,
    PrivacyPermissionAuthorizationStatusLocationWhenInUse,
    PrivacyPermissionAuthorizationStatusUnkonwn,
};

@interface PrivacyPermission : NSObject

+ (instancetype)sharedInstance;

- (void)accessPrivacyPermissionWithType:(PrivacyPermissionType)type completion:(void(^)(BOOL response,PrivacyPermissionAuthorizationStatus status))completion;

@end
