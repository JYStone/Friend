//
//  ActivityIndicator.h
//  Friend
//
//  Created by jy on 2018/1/9.
//  Copyright © 2018年 M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityIndicator : UIView
+ (void)showAlertMessage:(NSString *)message boyIcon:(NSString *)boyIcon girlIcon:(NSString *)girlIcon;

- (void)show;
- (void)remove;
@end
