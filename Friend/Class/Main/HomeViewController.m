//
//  HomeViewController.m
//  Friend
//
//  Created by jy on 2018/1/8.
//  Copyright © 2018年 M. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageViewColor:[UIColor clearColor] Size:CGSizeMake(DEVICE_SCREEN_WIDTH, SafeAreaTopHeight)] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"ln_common_settings" highImageName:@"ln_common_settings" target:self action:@selector(leftItemClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav-bar-album" highImageName:@"nav-bar-album" target:self action:@selector(rightItemClick)];
}

- (void)leftItemClick {
    NSLog(@"设置");
}

- (void)rightItemClick {
    NSLog(@"图片");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
