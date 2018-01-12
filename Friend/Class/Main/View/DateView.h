//
//  DateView.h
//  Friend
//
//  Created by jy on 2018/1/11.
//  Copyright © 2018年 M. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ConfirmBlock)(NSString *choseDate);
typedef void(^CannelBlock)(void);
@interface DateView : UIView
+ (instancetype)setDatePicker;
@property (nonatomic,copy) ConfirmBlock confirmBlock;

@property (nonatomic,copy) CannelBlock cannelBlock;
@end
