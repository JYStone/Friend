//
//  CustomNavigationController.m
//  TestProject
//
//  Created by jy on 2017/12/7.
//  Copyright © 2017年 W. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 修改导航栏按钮颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    // 修改导航栏背景颜色
    self.navigationBar.barTintColor = [UIColor whiteColor];
    // 添加背景底部阴影
//    self.navigationBar.layer.shadowColor = COLOR(@"f17cbe").CGColor;
//    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 4);
//    self.navigationBar.layer.shadowOpacity = 1;
    // 去掉底部线条添加阴影
    self.navigationBar.shadowImage = [UIImage new];
    // 背景样式
    [self.navigationBar setBackgroundImage:[UIImage resizedImage:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    // 文字样式
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:COLOR_FFFFFF,NSForegroundColorAttributeName,QHQFontSizeRegular(50),NSFontAttributeName, nil];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 如果现在push的不是栈底控制器（最先push进来的那个控制器）
    if (self.viewControllers.count > 0) {
        // 就隐藏下面的TabBar
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"ln_common_back" highImageName:@"ln_common_back" target:self action:@selector(leftItemClick)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)leftItemClick
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
