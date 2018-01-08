//
//  APIMacro.h
//  Friend
//
//  Created by JY on 2017/2/9.
//  Copyright © 2017年 M. All rights reserved.
//

#ifndef APIMacro_h
#define APIMacro_h

// 正式环境
#define API_HOST                    @"http://api.Friend.cn/"

/**********************************************
 *  单独提出的支付接口
 *  API_TRADE_NORMAL_PAYMENT                          支付获取银行卡信息
 *  API_TRADE_PAYMENT_AGREEMENT                       发送验证码
 *  API_USER_PAYBACK_PAYMENT_TRADE                    轮询支付结果
 *  API_USER_PAYMENT_CALLBACK                         支付结果回调
 *********************************************/

#define API_TRADE_NORMAL_PAYMENT            [API_HOST stringByAppendingString:@"trade/normal/payment"]
#define API_TRADE_PAYMENT_AGREEMENT         [API_HOST stringByAppendingString:@"trade/payment/agreement"]
#define API_USER_PAYBACK_PAYMENT_TRADE     [API_HOST stringByAppendingString:@"/trade/payment/trade"]
#define API_USER_PAYMENT_CALLBACK          [API_HOST stringByAppendingString:@"user/payback/payment/callback"]
#endif

/* QHQAPIMacro_h */
