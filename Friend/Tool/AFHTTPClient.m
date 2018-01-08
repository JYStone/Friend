//
//  AFHTTPClient.m
//  Friend
//
//  Created by JY on 2017/2/9.
//  Copyright © 2017年 M. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import <AdSupport/AdSupport.h>



@implementation HQAFHTTPClient

+ (void)initialize
{
    AFNetworkReachabilityManager *rechability = [AFNetworkReachabilityManager sharedManager];
    [rechability startMonitoring];
}

+ (NSURLSessionDataTask *)execute:(NSString*)url method:(NSString*)method dict:(NSDictionary*)dict mutiPart:(NSURL *)partUrl andPartName:(NSString *)name constructingBodyWithBlock:(ApiConstructingBody)body uploadProgress:(ApiUploadProgressCallback)progressCallback done:(ApiDoneCallback)doneCallback error:(ApiErrorCallback)errorCallback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *operationTask = nil;
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    //设置token
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user"] objectForKey:@"sso_token"]) {
        NSString *tokenStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"user"] objectForKey:@"sso_token"];
        if ([BaseService isBlankString:tokenStr] == NO) {
            [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"sso_token"];
        }
    }
    
    //设置设备deviceToken
    NSData *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    if (deviceToken) {
        NSString *tokenStr = [NSString stringWithFormat:@"%@", deviceToken];
        [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"device_token"];
    }
    //设置version
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    [manager.requestSerializer setValue:currentVersion forHTTPHeaderField:@"version"];
    
    //设置platform
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"platform"];
    
    //设置User-Agent
    NSString *usetAgent = [[NSUserDefaults standardUserDefaults] objectForKey:@"User-Agent"];
    if (usetAgent) {
        [manager.requestSerializer setValue:usetAgent forHTTPHeaderField:@"User-Agent"];
    }
    
    //设置IDFA
    NSString *IDFA = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if (IDFA) {
        [manager.requestSerializer setValue:IDFA forHTTPHeaderField:@"IDFA"];
    }
    
    //设置访问时间
    NSDate *mobileTime = [NSDate date];
    NSString *timeStr = [NSString stringWithFormat:@"%.f", mobileTime.timeIntervalSince1970*1000];
    [manager.requestSerializer setValue:timeStr forHTTPHeaderField:@"mobile-time"];
    
    // 加密验证
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSTimeInterval current_time = [[NSDate date] timeIntervalSince1970];
    NSString *csrf_time = [[NSString alloc]initWithFormat:@"%.f",current_time * 1000];
    NSString *hq_phone = [[NSString alloc]initWithFormat:@"true"];
    [manager.requestSerializer setValue:csrf_time forHTTPHeaderField:@"csrf_time"];
    [manager.requestSerializer setValue:hq_phone forHTTPHeaderField:@"hq_phone"];

    
    if ([method isEqualToString:@"GET"]) {
        operationTask = [manager GET:url parameters:param progress:^(NSProgress *  downloadProgress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject[@"success"] boolValue] == NO) {
                if ([responseObject[@"retcode"] integerValue] == 100) {
                    NSLog(@"重新登录");
                    [self autoLogin];
                }else{
                    if ([BaseService isBlankString:responseObject[@"message"]] == NO) {
                        [BaseService showErrorWithMsg:responseObject[@"message"]];
                    }
                }
                
            }
            if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSMutableDictionary class]]) {
                doneCallback(task,responseObject);
            }else{
                errorCallback(task, nil);
                [BaseService showLoadDataErrorAlert];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [BaseService showLoadDataErrorAlert];
            errorCallback(task, error);
        }];
    }else if ([method isEqualToString:@"POST"]){
        if (!body) {
            operationTask =  [manager POST:url parameters:param progress:^(NSProgress *downloadProgress) {
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                if ([responseObject[@"success"] boolValue] == NO) {
                    if ([responseObject[@"retcode"] integerValue] == 100) {
                        [self autoLogin];
                    }else{
                        if ([BaseService isBlankString:responseObject[@"message"]] == NO) {
                            [BaseService showErrorWithMsg:responseObject[@"message"]];
                        }
                    }
                    
                }
                if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSMutableDictionary class]]) {
                    doneCallback(task,responseObject);
                }else{
                    errorCallback(task, nil);
                    [BaseService showLoadDataErrorAlert];
                }
                if([responseObject[@"retcode"] integerValue] == 500 && responseObject[@"serious"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"show" object:responseObject];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [BaseService showLoadDataErrorAlert];
                errorCallback(task, error);
            }];
        }else{
            operationTask =  [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                body(formData);
            } progress:^(NSProgress *uploadProgress) {
                progressCallback(uploadProgress);
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                if ([responseObject[@"success"] boolValue] == NO) {
                    if ([responseObject[@"retcode"] integerValue] == 100) {
                        [self autoLogin];
                    }else{
                        if ([BaseService isBlankString:responseObject[@"message"]] == NO) {
                            [BaseService showErrorWithMsg:responseObject[@"message"]];
                        }
                    }
                }
                if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSMutableDictionary class]]) {
                    doneCallback(task,responseObject);
                }else{
                    errorCallback(task, nil);
                    [BaseService showLoadDataErrorAlert];
                }
                if([responseObject[@"retcode"] integerValue] == 500 && responseObject[@"serious"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"show" object:responseObject];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [BaseService showLoadDataErrorAlert];
                errorCallback(task, error);
            }];
        }
    }else if ([method isEqualToString:@"PUT"]){
        operationTask = [manager PUT:url parameters:param success:^(NSURLSessionDataTask * task, id responseObject) {
            if ([responseObject[@"success"] boolValue] == NO) {
                if ([responseObject[@"retcode"] integerValue] == 100) {
                    [self autoLogin];
                }else{
                    if ([BaseService isBlankString:responseObject[@"message"]] == NO) {
                        [BaseService showErrorWithMsg:responseObject[@"message"]];
                    }
                }
            }
            if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSMutableDictionary class]]) {
                doneCallback(task,responseObject);
            }else{
                errorCallback(task, nil);
                [BaseService showLoadDataErrorAlert];
            }
            if([responseObject[@"retcode"] integerValue] == 500 && responseObject[@"serious"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"show" object:responseObject];
            }
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            [BaseService showLoadDataErrorAlert];
            errorCallback(task, error);
        }];
    }
    return operationTask;
}

+ (NSURLSessionDataTask *)get:(NSString *)url dict:(NSDictionary *)dict done:(ApiDoneCallback)doneCallback error:(ApiErrorCallback)errorCallback
{
    
    if ([BaseService isConnectionAvailable] == NO) {
        [BaseService showNetworkIsNotConnectedAlertView];
        return nil;
    }
    
    return [self execute:url method:@"GET" dict:dict mutiPart:nil andPartName:nil constructingBodyWithBlock:nil uploadProgress:nil done:doneCallback error:errorCallback];
}

+ (NSURLSessionDataTask *)post:(NSString *)url dict:(NSDictionary *)dict done:(ApiDoneCallback)doneCallback error:(ApiErrorCallback)errorCallback
{
    if ([BaseService isConnectionAvailable] == NO) {
        [BaseService showNetworkIsNotConnectedAlertView];
        return nil;
    }
    
    return [self execute:url method:@"POST" dict:dict mutiPart:nil andPartName:nil constructingBodyWithBlock:nil uploadProgress:nil done:doneCallback error:errorCallback];
}

+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary*)dict constructingBodyWithBlock:(ApiConstructingBody)body uploadProgress:(ApiUploadProgressCallback)progressCallback success:(ApiDoneCallback)doneCallback failure:(ApiErrorCallback)errorCallback
{
    if ([BaseService isConnectionAvailable] == NO) {
        [BaseService showNetworkIsNotConnectedAlertView];
        return nil;
    }
    
    return [self execute:url method:@"POST" dict:dict mutiPart:nil andPartName:nil constructingBodyWithBlock:body uploadProgress:progressCallback done:doneCallback error:errorCallback];
}

+ (NSURLSessionDataTask *)put:(NSString *)url dict:(NSDictionary *)dict done:(ApiDoneCallback)doneCallback error:(ApiErrorCallback)errorCallback
{
    if ([BaseService isConnectionAvailable] == NO) {
        [BaseService showNetworkIsNotConnectedAlertView];
        return nil;
    }
    
    return [self execute:url method:@"PUT" dict:dict mutiPart:nil andPartName:nil constructingBodyWithBlock:nil uploadProgress:nil done:doneCallback error:errorCallback];
}

// 自动登录
+ (void)autoLogin
{
    if ([[[[NSUserDefaults standardUserDefaults] objectForKey:@"user"]objectForKey:@"isLogin"] boolValue] == YES) {
        
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        
//        [[HQUser sharedUser] loginWithCell:[dic objectForKey:@"cell"] andLoginPwd:[dic objectForKey:@"loginPwd"] andSuccess:^(id source, id other) {
//            if ([source[@"success"] boolValue] == YES) {
//                NSLog(@"[INFO]auto login success!");
//            }else{
//                NSLog(@"auto login false, logOut");
//                [self logOut];
//            }
//        } andError:^(id error) {
//            NSLog(@"[ERROR]login:%@",error);
//            [self logOut];
//        }];
    }
}

+ (void)logout
{
    // 退出登录
//    [BaseService logout];
//    AppDelegate *delegate = (AppDelegate *)([[UIApplication sharedApplication] delegate]);
//    Hom *loginVc = [[QHQCellLoginController alloc] init];
//    CustomNavigationController *navVc = [[CustomNavigationController alloc] initWithRootViewController:loginVc];
//    [delegate.window setRootViewController:navVc];
}

@end
