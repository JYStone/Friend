//
//  HomeViewController.m
//  Friend
//
//  Created by jy on 2018/1/8.
//  Copyright © 2018年 M. All rights reserved.
//

#import "HomeViewController.h"
#import "PasswordViewController.h"
#import "SpecialDayViewController.h"
#import "NotepadController.h"
#import "PhotoController.h"
#import "UIImageView+WebCache.h"
#import "HomeButtonModel.h"
#import "GradientButton.h"
#import "ActivityIndicator.h"
#import <AVKit/AVKit.h>
#import "ChooseBgImageController.h"
#import "CustomNavigationController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import "HXPhotoPicker.h"

@interface HomeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CALayer *contentLayer;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) HXPhotoManager *manager;

@end

@implementation HomeViewController

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.singleSelected = YES;
        _manager.configuration.albumListTableView = ^(UITableView *tableView) {
        };
        _manager.configuration.movableCropBox = YES;
        _manager.configuration.movableCropBoxEditSize = YES;
        _manager.configuration.movableCropBoxCustomRatio = CGPointMake(1, 1);
    }
    return _manager;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageViewColor:[UIColor clearColor] Size:CGSizeMake(DEVICE_SCREEN_WIDTH, SafeAreaTopHeight)] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage resizedImage:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage resizedImage:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_FFFFFF;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"ln_common_settings" highImageName:@"ln_common_settings" target:self action:@selector(leftItemClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav-bar-album" highImageName:@"nav-bar-album" target:self action:@selector(rightItemClick)];
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.scaleFrame6 = CGRectMake(0, 0, 750, 750);
    self.bgImageView = bgImageView;
    bgImageView.backgroundColor = [UIColor lightGrayColor];
    bgImageView.image = [UIImage imageNamed:@"WechatIMG94"];
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    
    //创建手势对象
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapAction:)];
    [bgImageView addGestureRecognizer:tap];
    
    // 渐变区域
    UIImageView *gradientView = [[UIImageView alloc] init];
    gradientView.scaleFrame6 = CGRectMake(0, 700, 750, 100);
    [self.view addSubview:gradientView];
    
    // 添加渐变
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, [UIColor lightGrayColor].CGColor, nil];;
    headerLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:1.0], nil];
    headerLayer.frame = gradientView.bounds;
//    [gradientView.layer addSublayer:headerLayer];
//    [gradientView.layer insertSublayer:headerLayer atIndex:0];
    
    //创建BezierPath 绘制_bgVC层
    CGSize size = bgImageView.bounds.size;
    CGFloat startHeight = 0;
    CGFloat endHeight = size.height * 0.91;
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(size.width/3, endHeight)];
    [aPath addLineToPoint:CGPointMake(0, endHeight)];
    [aPath addLineToPoint:CGPointMake(0, startHeight)];
    [aPath addLineToPoint:CGPointMake(size.width, startHeight)];
    [aPath addLineToPoint:CGPointMake(size.width, size.height)];
    [aPath addLineToPoint:CGPointMake(size.width*2/3, size.height)];

    [aPath addCurveToPoint:CGPointMake(size.width/3, endHeight) controlPoint1:CGPointMake(size.width*2/3-70, size.height) controlPoint2:CGPointMake(size.width/3+70, endHeight)];

    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.strokeColor = [UIColor purpleColor].CGColor;
//    layer.fillColor = [UIColor brownColor].CGColor;
    layer.path = aPath.CGPath;
    [bgImageView.layer setMask:layer];
    
    NSArray *list = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeButtonList" ofType:@"plist"]];
    NSArray *headImageList = [NSArray arrayWithObjects:@"head_default_male",@"head_default_female", nil];
    NSArray *colorArray = [HomeButtonModel mj_objectArrayWithKeyValuesArray:list];
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            HomeButtonModel *model = colorArray[2*j+i];
            GradientButton *button = [[GradientButton alloc] initWithFrame:CGRectMake(0, 0, 300, 170) Model:model];
            button.tag = 100+2*j+i;
            button.scaleFrame6 = CGRectMake(40+370*i, 830+230*j, 300, 170);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
        //
        UIImageView *headImage = [[UIImageView alloc] init];
        headImage.scaleFrame6 = CGRectMake(50+120*i, 628, 100, 100);
        [headImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:headImageList[i]]];
        headImage.userInteractionEnabled = YES;
        headImage.tag = 200+i;
        headImage.layer.masksToBounds = YES;
        headImage.layer.cornerRadius = 100/2*HEIGHT_SCALE_6;
        headImage.layer.borderColor = COLOR_FFFFFF.CGColor;
        headImage.layer.borderWidth = 2;
        [self.view addSubview:headImage];
        
        //创建手势对象
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapAction2:)];
        [headImage addGestureRecognizer:tap];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"tapAction");
//    [ActivityIndicator showAlertMessage:@"啦啦" boyIcon:@"" girlIcon:@""];
}

- (void)tapAction2:(UITapGestureRecognizer *)tap
{
    NSLog(@"tapAction2");
    //    [ActivityIndicator showAlertMessage:@"啦啦" boyIcon:@"" girlIcon:@""];
}


- (void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        SpecialDayViewController *specialVC = [[SpecialDayViewController alloc] init];
        [self.navigationController pushViewController:specialVC animated:YES];
    } else if (sender.tag == 101) {
        NotepadController *notepadVC = [[NotepadController alloc] init];
        [self.navigationController pushViewController:notepadVC animated:YES];
    } else if (sender.tag == 102) {
        PhotoController *photoVC = [[PhotoController alloc] init];
        [self.navigationController pushViewController:photoVC animated:YES];
    } else {
        
    }
}

- (void)leftItemClick {
    NSLog(@"设置");
    PasswordViewController *passwVC = [[PasswordViewController alloc] init];
    [self.navigationController pushViewController:passwVC animated:YES];
}

// 设置背景大图
- (void)rightItemClick {
    self.manager.configuration.saveSystemAblum = YES;
    [self hx_presentAlbumListViewControllerWithManager:self.manager delegate:self];
}

- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original {
    if (photoList.count > 0) {
        HXPhotoModel *model = photoList.firstObject;
        self.bgImageView.image = model.previewPhoto;
    } else {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
