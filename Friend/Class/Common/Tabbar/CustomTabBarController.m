//
//  CustomTabBarController.m
//  TestProject
//
//  Created by jy on 2017/12/7.
//  Copyright © 2017年 W. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomNavigationController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置样式
    [self settingTabBarStyle];
    
    HomeViewController *HomeVC = [[HomeViewController alloc] init];
    [self addOneChlildVc:HomeVC title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    MineViewController *MineVC = [[MineViewController alloc] init];
    [self addOneChlildVc:MineVC title:@"个人中心" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
}

- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:13];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor brownColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    childVc.title = title;
    childVc.view.backgroundColor = COLOR_RANDOM;
    UITabBarItem *moreTabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
    childVc.tabBarItem = moreTabBarItem;
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

- (void)settingTabBarStyle {
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    //去掉底部线条
    self.tabBar.layer.shadowColor = COLOR(@"d7dada").CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -4);
    self.tabBar.layer.shadowOpacity = 0.2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
