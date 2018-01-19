//
//  PrivacyPermission.m
//  Friend
//
//  Created by jy on 2018/1/16.
//  Copyright © 2018年 M. All rights reserved.
//

#import "PrivacyPermission.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <EventKit/EventKit.h>
#import <Contacts/Contacts.h>
#import <Speech/Speech.h>
#import <HealthKit/HealthKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

static PrivacyPermission *_instance = nil;

//`Positioning accuracy` -> 定位精度
static NSInteger const PrivacyPermissionTypeLocationDistanceFilter = 10;
@implementation PrivacyPermission

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+(instancetype)copyWithZone:(nullable NSZone *)zone{
    return _instance;
}

-(void)accessPrivacyPermissionWithType:(PrivacyPermissionType)type completion:(void(^)(BOOL response,PrivacyPermissionAuthorizationStatus status))completion
{
    switch (type) {
            /** 相册 */
        case PrivacyPermissionTypePhoto:{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    completion(YES, PrivacyPermissionAuthorizationStatusAuthorized);
                } else if (status == PHAuthorizationStatusDenied) {
                    completion(NO, PrivacyPermissionAuthorizationStatusDenied);
                } else if (status == PHAuthorizationStatusNotDetermined) {
                    completion(NO, PrivacyPermissionAuthorizationStatusNotDetermined);
                } else if (status == PHAuthorizationStatusRestricted){
                    completion(NO, PrivacyPermissionAuthorizationStatusRestricted);
                }
            }];
        }break;
            /** 相机 */
        case PrivacyPermissionTypeCamera:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (granted) {
                    completion(YES, PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == PHAuthorizationStatusDenied) {
                        completion(NO, PrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == PHAuthorizationStatusNotDetermined) {
                        completion(NO, PrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == PHAuthorizationStatusRestricted){
                        completion(NO, PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
        case PrivacyPermissionTypeMedia:{
            [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    completion(YES, PrivacyPermissionAuthorizationStatusAuthorized);
                } else if (status == PHAuthorizationStatusDenied) {
                    completion(NO, PrivacyPermissionAuthorizationStatusDenied);
                } else if (status == PHAuthorizationStatusNotDetermined) {
                    completion(NO, PrivacyPermissionAuthorizationStatusNotDetermined);
                } else if (status == PHAuthorizationStatusRestricted){
                    completion(NO, PrivacyPermissionAuthorizationStatusRestricted);
                }
            }];
        }break;
        case PrivacyPermissionTypeMicrophone:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                if (granted) {
                    completion(YES, PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == PHAuthorizationStatusDenied) {
                        completion(NO, PrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == PHAuthorizationStatusNotDetermined) {
                        completion(NO, PrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == PHAuthorizationStatusRestricted){
                        completion(NO, PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
            /** 地理位置 */
        case PrivacyPermissionTypeLocation:{
            if ([CLLocationManager locationServicesEnabled]) {
                CLLocationManager *locationManager = [[CLLocationManager alloc] init];
                [locationManager requestAlwaysAuthorization];
                [locationManager requestWhenInUseAuthorization];
                locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
                locationManager.distanceFilter = PrivacyPermissionTypeLocationDistanceFilter;
                [locationManager startUpdatingLocation];
            }
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusAuthorizedAlways) {
                completion (YES, PrivacyPermissionAuthorizationStatusLocationAlways);
            } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
                completion (YES, PrivacyPermissionAuthorizationStatusLocationWhenInUse);
            } else if (status == kCLAuthorizationStatusDenied) {
                completion (NO, PrivacyPermissionAuthorizationStatusDenied);
            } else if (status == kCLAuthorizationStatusNotDetermined) {
                completion (NO, PrivacyPermissionAuthorizationStatusNotDetermined);
            } else if (status == kCLAuthorizationStatusRestricted) {
                completion (NO, PrivacyPermissionAuthorizationStatusRestricted);
            }
        }break;
            /** 蓝牙 */
        case PrivacyPermissionTypeBluetooth:{
            CBCentralManager *centerManger = [[CBCentralManager alloc] init];
            CBManagerState state = [centerManger state];
            if (state == CBManagerStateUnsupported || state == CBManagerStateUnauthorized || state == CBManagerStateUnknown) {
                completion (NO, PrivacyPermissionAuthorizationStatusDenied);
            } else {
                completion (YES, PrivacyPermissionAuthorizationStatusAuthorized);
            }
        }break;
        case PrivacyPermissionTypePushNotification:{
            if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                UNAuthorizationOptions types = UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound;
                [center requestAuthorizationWithOptions:types completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                        }];
                        completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                    } else {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) {
                        }];
                    }
                }];
            } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
#pragma clang diagnostic pop
            }
        }break;
        case PrivacyPermissionTypeSpeech:{
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                    completion (YES, PrivacyPermissionAuthorizationStatusAuthorized);
                }else if (status == SFSpeechRecognizerAuthorizationStatusDenied) {
                    completion (NO, PrivacyPermissionAuthorizationStatusDenied);
                } else if (status == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
                    completion (NO, PrivacyPermissionAuthorizationStatusNotDetermined);
                } else if (status == SFSpeechRecognizerAuthorizationStatusRestricted) {
                    completion (NO, PrivacyPermissionAuthorizationStatusRestricted);
                }
            }];
        }break;
        case PrivacyPermissionTypeEvent:{
            EKEventStore *store = [[EKEventStore alloc] init];
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
                if (granted) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == EKAuthorizationStatusDenied) {
                        completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == EKAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == EKAuthorizationStatusRestricted) {
                        completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
        case PrivacyPermissionTypeContact:{
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                if (granted) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == EKAuthorizationStatusDenied) {
                        completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == EKAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == EKAuthorizationStatusRestricted) {
                        completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
        case PrivacyPermissionTypeReminder:{
            EKEventStore *store = [[EKEventStore alloc] init];
            [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
                if (granted) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == EKAuthorizationStatusDenied) {
                        completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == EKAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == EKAuthorizationStatusRestricted) {
                        completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
            /** 健康数据 iOS 8.0之后才有 现在最低一般适配到iOS8.0 不需要做区分 */
        case PrivacyPermissionTypeHealth:{
            if (![HKHealthStore isHealthDataAvailable]) {
                NSAssert([HKHealthStore isHealthDataAvailable],@"Device not support HealthKit");
            }else{
                HKHealthStore *store = [[HKHealthStore alloc] init];
                NSSet *readObjectTypes = [self readObjectTypes];
                NSSet *writeObjectTypes = [self writeObjectTypes];
                [store requestAuthorizationToShareTypes:writeObjectTypes readTypes:readObjectTypes completion:^(BOOL success, NSError * _Nullable error) {
                    if (success == YES) {
                        completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                    }else{
                        completion(NO,PrivacyPermissionAuthorizationStatusUnkonwn);
                    }
                }];
            }
        }break;
        default:
            break;
    }
}

#pragma mark - Private
- (NSSet *)readObjectTypes{
    HKQuantityType *StepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *DistanceWalkingRunning= [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKObjectType *FlightsClimbed = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    
    return [NSSet setWithObjects:StepCount,DistanceWalkingRunning,FlightsClimbed, nil];
}
- (NSSet *)writeObjectTypes{
    HKQuantityType *StepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *DistanceWalkingRunning= [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKObjectType *FlightsClimbed = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    
    return [NSSet setWithObjects:StepCount,DistanceWalkingRunning,FlightsClimbed, nil];
}
@end
