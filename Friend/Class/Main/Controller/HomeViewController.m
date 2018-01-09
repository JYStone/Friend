//
//  HomeViewController.m
//  Friend
//
//  Created by jy on 2018/1/8.
//  Copyright © 2018年 M. All rights reserved.
//

#import "HomeViewController.h"
#import "PasswordViewController.h"
#import "HomeButtonModel.h"
#import "GradientButton.h"
@interface HomeViewController ()
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CALayer *contentLayer;
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
    self.view.backgroundColor = COLOR_FFFFFF;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"ln_common_settings" highImageName:@"ln_common_settings" target:self action:@selector(leftItemClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav-bar-album" highImageName:@"nav-bar-album" target:self action:@selector(rightItemClick)];
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.scaleFrame6 = CGRectMake(0, 0, 750, 800);
    bgImageView.backgroundColor = [UIColor lightGrayColor];
    bgImageView.image = [UIImage imageNamed:@"55555.jpg"];
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bgImageView];
    
    // 渐变区域
    UIView *gradientView = [[UIView alloc] init];
    gradientView.scaleFrame6 = CGRectMake(0, 700, 750, 100);
    [self.view addSubview:gradientView];
    
    // 添加渐变
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, [UIColor lightGrayColor].CGColor, nil];;
    headerLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:1.0], nil];
    headerLayer.frame = gradientView.bounds;
    [gradientView.layer insertSublayer:headerLayer atIndex:0];
    
    // 我们在一起X天
//    UILabel *
    
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = bgImageView.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale;                 //非常关键设置自动拉伸的效果且不变形
    _maskLayer.contents = (id)[UIImage imageNamed:@"gray_bubble_right@2x.png"].CGImage;
    
    _contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    _contentLayer.frame = bgImageView.bounds;
    [bgImageView.layer addSublayer:_contentLayer];
    
    NSArray *list = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeButtonList" ofType:@"plist"]];
    NSArray *colorArray = [HomeButtonModel mj_objectArrayWithKeyValuesArray:list];
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            HomeButtonModel *model = colorArray[2*j+i];
            GradientButton *button = [[GradientButton alloc] initWithFrame:CGRectMake(0, 0, 300, 170) Model:model];
            button.tag = 100+2*j+i;
            button.scaleFrame6 = CGRectMake(40+370*i, 880+230*j, 300, 170);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
}

- (void)buttonClick:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
}

- (void)leftItemClick {
    NSLog(@"设置");
    PasswordViewController *passwVC = [[PasswordViewController alloc] init];
    [self.navigationController pushViewController:passwVC animated:YES];
}

// 设置背景大图
- (void)rightItemClick {
    NSLog(@"背景图片");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
