//
//  ActivityIndicator.m
//  Friend
//
//  Created by jy on 2018/1/9.
//  Copyright © 2018年 M. All rights reserved.
//

#import "ActivityIndicator.h"

@interface ActivityIndicator()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *boyIcon;
@property (nonatomic, copy) NSString *girlIcon;
@end

@implementation ActivityIndicator

+ (void)showAlertMessage:(NSString *)message boyIcon:(NSString *)boyIcon girlIcon:(NSString *)girlIcon;
{
    ActivityIndicator *activityIndicator = [[self alloc] initWithMessage:message boyIcon:boyIcon girlIcon:girlIcon];
    [activityIndicator show];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(remove)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius  = 5.0;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}


- (instancetype)initWithMessage:(NSString *)message boyIcon:(NSString *)boyIcon girlIcon:(NSString *)girlIcon
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.message = message;
        self.boyIcon = boyIcon;
        self.girlIcon = girlIcon;
    }
    [self setupAlertView];
    return self;
}

- (void)setupAlertView {
//    self.backgroundColor =
    // 这个view的作用只是，点击黑色区域 弹框是否会消失的问题
    [self addSubview:self.bgView];
    [self addSubview: self.alertView];
    self.alertView.scaleFrame6 = CGRectMake(110, -530, 530, 500);
}


- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.alertView.scaleFrame6 = CGRectMake(110, (1334-500)/2-30, 530, 500);
    } completion:nil];
}

- (void)remove {
    //弹性动画
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.alertView.scaleFrame6 = CGRectMake(110, -530, 530, 500);
        [self.bgView removeFromSuperview];
    } completion:^(BOOL finished) {
        [self.alertView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
    
}
@end
