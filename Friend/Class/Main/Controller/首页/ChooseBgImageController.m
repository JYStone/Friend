//
//  ChooseBgImageController.m
//  Friend
//
//  Created by jy on 2018/1/18.
//  Copyright © 2018年 M. All rights reserved.
//

#import "ChooseBgImageController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ChooseBgImageController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation ChooseBgImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_F9F9F9;
    self.title = @"选择图片";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    [self createCollectionView];
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.imagePickerController.allowsEditing = YES;
}

- (void)rightClick {
    
}

// 绘制直线
- (void)drawLineWithBgView:(UIView *)bgView {
//    UIView *bgView = [[UIView alloc] init];
//    bgView.frame = imageView.frame;
//    [self.view addSubview:bgView];
//
    for (int i = 0; i<2; i++) {
        UIView *horizontalLine = [[UIView alloc] init];
        horizontalLine.scaleFrame6 = CGRectMake(0, 250+250*i, 750, 1.0);
        horizontalLine.backgroundColor = COLOR_FFFFFF;
        [bgView addSubview:horizontalLine];
        
        UIView *verticalLine = [[UIView alloc] init];
        verticalLine.scaleFrame6 = CGRectMake(250+250*i, 0, 1.0, 750);
        verticalLine.backgroundColor = COLOR_FFFFFF;
        [bgView addSubview:verticalLine];
    }
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 1*WIDTH_SCALE_6;
    layout.minimumLineSpacing = 1*HEIGHT_SCALE_6;
    layout.headerReferenceSize = CGSizeMake(750*WIDTH_SCALE_6, 750*HEIGHT_SCALE_6);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT-SafeAreaTopHeight) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    // Register cell classes
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ChooseBgImageController"];
    //注册头视图
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    
    [self.view addSubview:collectionView];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader" forIndexPath:indexPath];
    headView.backgroundColor = COLOR_F9F9F9;
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] init];
    self.bgImageView = bgImageView;
    bgImageView.scaleFrame6 = CGRectMake(0, 0, 750, 750);
    bgImageView.backgroundColor = [UIColor lightGrayColor];
    bgImageView.image = [UIImage imageNamed:@"WechatIMG94"];
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    bgImageView.userInteractionEnabled = YES;
    [headView addSubview:bgImageView];
    // 画线
    [self drawLineWithBgView:headView];
    return headView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((750-5)/4*WIDTH_SCALE_6, (750-5)/4*HEIGHT_SCALE_6);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1*HEIGHT_SCALE_6, 1*HEIGHT_SCALE_6, 1*HEIGHT_SCALE_6, 1*HEIGHT_SCALE_6);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseBgImageController" forIndexPath:indexPath];
    cell.backgroundColor = COLOR_RANDOM;
    if (indexPath.row == 0) {
        
    } else {
        
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    [collectionView setContentOffset:CGPointMake(0,0)animated:NO];
    if (indexPath.row == 0) {
        [[PrivacyPermission sharedInstance] accessPrivacyPermissionWithType:PrivacyPermissionTypeCamera completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (response) {
                    NSLog(@"相机权限开启");
                    [self selectImageFromCamera];
                } else {
                    NSLog(@"相机权限没有开启");
                }
            });
        }];
    } else {
        [self selectImageFromAlbum];
    }
}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    //设置摄像头模式（拍照，录制视频）为录像模式
    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
}

//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片
        self.bgImageView.image = info[UIImagePickerControllerEditedImage];
        //压缩图片
//        NSData *fileData = UIImageJPEGRepresentation(self.bgImageView.image, 1.0);
        //保存图片至相册
        UIImageWriteToSavedPhotosAlbum(self.bgImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//        上传图片
//        [self uploadImageWithData:fileData];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    
}

#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}

@end
