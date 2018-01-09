//
//  GradientButton.h
//  Friend
//
//  Created by jy on 2018/1/9.
//  Copyright © 2018年 M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeButtonModel.h"
@interface GradientButton : UIButton
@property (nonatomic, strong) HomeButtonModel *model;
- (id)initWithFrame:(CGRect)frame Model:(HomeButtonModel *)model;
@end
