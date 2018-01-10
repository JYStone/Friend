//
//  SpecialDayModel.h
//  Friend
//
//  Created by jy on 2018/1/10.
//  Copyright © 2018年 M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialDayModel : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *type;// 本地和远程
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *days_count;
@property (nonatomic, copy) NSString *color_style;
@end
