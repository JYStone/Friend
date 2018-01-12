//
//  SpecialDayBgController.m
//  Friend
//
//  Created by jy on 2018/1/11.
//  Copyright © 2018年 M. All rights reserved.
//

#import "SpecialDayBgController.h"

@interface SpecialDayBgController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageList;
@end

@implementation SpecialDayBgController

- (NSMutableArray *)imageList
{
    if (!_imageList) {
        _imageList = [NSMutableArray array];
    }
    return _imageList;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageViewColor:[UIColor clearColor] Size:CGSizeMake(DEVICE_SCREEN_WIDTH, SafeAreaTopHeight)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage resizedImage:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_F9F9F9;
    self.title = @"纪念日背景";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    [self setupImageBankgroundView];
    [self setCollectionView];
}

- (void)setupImageBankgroundView
{
    UIImageView *blurImageView = [[UIImageView alloc] init];
    blurImageView.frame = self.view.bounds;
    blurImageView.image = [[UIImage imageNamed:@"WechatIMG97.png"] blurImage];
    blurImageView.clipsToBounds = YES;
    blurImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:blurImageView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    imageView.frame = CGRectMake(width*0.15, height*0.10, width*0.7, height*0.7);
    imageView.layer.borderColor = COLOR_FFFFFF.CGColor;
    imageView.layer.borderWidth = 3.0*HEIGHT_SCALE_6;
    imageView.image = [UIImage imageNamed:@"WechatIMG97.png"];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [blurImageView addSubview:imageView];
}

- (void)setCollectionView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, DEVICE_SCREEN_HEIGHT-100, DEVICE_SCREEN_WIDTH, 100);
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:view];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumInteritemSpacing = 5*WIDTH_SCALE_6;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 , 0, DEVICE_SCREEN_WIDTH,100)collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"labelCell"];
    [view addSubview:collectionView];
    
//    [_labelDataArr addObjectsFromArray:[HQHomeLoginTagModel objectArrayWithKeyValuesArray:productModel.tagList]];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageList.count+10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20*HEIGHT_SCALE_6, 0, 20*HEIGHT_SCALE_6);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60,80);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"labelCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSLog(@"%ld",indexPath.row);
}
- (void)rightClick {
    NSLog(@"张辉是个大傻子");
}

@end
