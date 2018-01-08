//
//  AFHTTPClient.h
//  Friend
//
//  Created by JY on 2017/2/9.
//  Copyright © 2017年 M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Reachability.h"

typedef void (^APIDoneCallback)(id source,id other);
typedef void (^APIErrorCallback)(id error);

typedef void (^ApiDoneCallback)(NSURLSessionDataTask *operation, id responseObject);
typedef void (^ApiErrorCallback)(NSURLSessionDataTask *operation, NSError *error);
typedef void (^ApiConstructingBody)(id<AFMultipartFormData> formData);
typedef void (^ApiUploadProgressCallback)(NSProgress *  uploadProgress);

@interface HQAFHTTPClient : NSObject
/**
 *  发送一个GET请求
 *
 *  @param url           请求参数路径
 *  @param dict          请求参数
 *  @param doneCallback  请求成功后的回调
 *  @param errorCallback 请求失败后的回调
 *
 *  @return 请求操作
 */
+ (NSURLSessionDataTask *)get:(NSString *)url dict:(NSDictionary*)dict done:(ApiDoneCallback)doneCallback error:(ApiErrorCallback)errorCallback;
/**
 *  发送一个POST请求
 *
 *  @param url           请求参数路径
 *  @param dict          请求参数
 *  @param doneCallback  请求成功后的回调
 *  @param errorCallback 请求失败后的回调
 *
 *  @return 请求操作
 */
+ (NSURLSessionDataTask *)post:(NSString *)url dict:(NSDictionary*)dict done:(ApiDoneCallback)doneCallback error:(ApiErrorCallback)errorCallback;
/**
 *  发送一个POST请求
 *
 *  @param url                  请求参数路径
 *  @param dict                 请求参数
 *  @param partUrl              上传文件路径
 *  @param name                 上传文件名
 *  @param progressCallback     上传进度回调
 *  @param doneCallback         请求成功后的回调
 *  @param errorCallback        请求失败后的回调
 *
 *  @return 请求操作
 */
+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary*)dict constructingBodyWithBlock:(ApiConstructingBody)body uploadProgress:(ApiUploadProgressCallback)progressCallback success:(ApiDoneCallback)doneCallback failure:(ApiErrorCallback)errorCallback;
/**
 *  发送一个PUT请求
 *
 *  @param url           请求参数路径
 *  @param dict          请求参数
 *  @param doneCallback  请求成功后的回调
 *  @param errorCallback 请求失败后的回调
 *
 *  @return 请求操作
 */
+ (NSURLSessionDataTask *)put:(NSString *)url dict:(NSDictionary*)dict done:(ApiDoneCallback)doneCallback error:(ApiErrorCallback)errorCallback;

+ (void)autoLogin;

@end
