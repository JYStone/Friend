//
//  PhotoController.m
//  Friend
//
//  Created by jy on 2018/1/15.
//  Copyright © 2018年 M. All rights reserved.
//

#import "PhotoController.h"
#import "PhotoModel.h"
#import "PhotoCell.h"
#import "HXPhotoPicker.h"
#import "UploadPhotosViewController.h"
@interface PhotoController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HXCustomCameraViewControllerDelegate,HXAlbumListViewControllerDelegate,PhotoCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *albumList;
@property (nonatomic, strong) NSMutableArray *photoList;
@property (nonatomic, strong) HXPhotoManager *manager;
@end

@implementation PhotoController

static NSString * const reuseIdentifier = @"reuseIdentifier";

- (NSMutableArray *)albumList {
    if (!_albumList) {
        _albumList = [NSMutableArray array];
    }
    return _albumList;
}

- (NSMutableArray *)photoList {
    if (!_photoList) {
        _photoList = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PhotoList" ofType:@"plist"]];
    }
    return _photoList;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.movableCropBox = YES;
        _manager.configuration.movableCropBoxEditSize = YES;
        _manager.configuration.photoMaxNum = 20;
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_F9F9F9;
    self.title = @"相册";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5*WIDTH_SCALE_6;
    layout.minimumLineSpacing = 10*HEIGHT_SCALE_6;
    layout.headerReferenceSize = CGSizeMake(750*WIDTH_SCALE_6, 100*HEIGHT_SCALE_6);

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    // 注册cell
    [collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // 注册头视图
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    
    [self.view addSubview:collectionView];
    
    [self loadData];
}
- (void)rightClick {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self.view showImageHUDText:@"此设备不支持相机!"];
            return;
        }
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在设置-隐私-相机中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
            return;
        }
        [self hx_presentCustomCameraViewControllerWithManager:self.manager delegate:self];
    }else if (buttonIndex == 1){
        [self hx_presentAlbumListViewControllerWithManager:self.manager delegate:self];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
- (void)customCameraViewController:(HXCustomCameraViewController *)viewController didDone:(HXPhotoModel *)model {
    [self.manager afterListAddCameraTakePicturesModel:model];
    UploadPhotosViewController *vc = [[UploadPhotosViewController alloc] init];
    vc.manager = self.manager;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original {
    UploadPhotosViewController *vc = [[UploadPhotosViewController alloc] init];
    vc.manager = self.manager;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData {
    self.albumList = [PhotoModel mj_objectArrayWithKeyValuesArray:self.photoList];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.albumList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    PhotoModel *model = self.albumList[section];
    return model.photo.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader" forIndexPath:indexPath];
    headView.backgroundColor = COLOR_F9F9F9;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.scaleFrame6 = CGRectMake(30, 20, 500, 80);
    titleLabel.font = QHQFontSizeRegular(30);
    titleLabel.textColor = COLOR_282E39;
    if (self.albumList.count>0) {
        PhotoModel *model = self.albumList[indexPath.section];
        titleLabel.text = nil;
        titleLabel.text = model.date;
    }
    [headView addSubview:titleLabel];
    return headView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((750-50)/4*WIDTH_SCALE_6, (750-50)/4*HEIGHT_SCALE_6);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10*HEIGHT_SCALE_6, 10*HEIGHT_SCALE_6, 10*HEIGHT_SCALE_6, 10*HEIGHT_SCALE_6);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.tag = 1000*indexPath.section + indexPath.row;
    cell.delegate = self;
    cell.edit = YES;
    if (self.albumList.count>0) {
        PhotoModel *model = self.albumList[indexPath.section];
        if ([model.photo[indexPath.row] isKindOfClass:[NSString class]]) {
            cell.imageName = [UIImage imageNamed:model.photo[indexPath.row]];
        } else {
            cell.imageName = model.photo[indexPath.row];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSLog(@"%ld",indexPath.row);
    
//    HXDatePhotoPreviewViewController *vc = [[HXDatePhotoPreviewViewController alloc] init];
//    vc.outside = YES;
//    vc.manager = self.manager;
//    vc.delegate = self;
//    vc.modelArray = [NSMutableArray arrayWithArray:self.manager.afterSelectedArray];
//    vc.currentModelIndex = [self.manager.afterSelectedArray indexOfObject:model];
//    vc.photoView = self;
//
//    //            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    //            nav.transitioningDelegate = vc;
//    //            nav.modalPresentationStyle = UIModalPresentationCustom;
//    [self presentViewController:vc animated:YES completion:nil];
}

- (void)deleteButtonClickWithSender:(UIButton *)sender {
    PhotoModel *model = self.albumList[sender.tag/1000];
    NSString *photoId = model.photo[sender.tag%1000];
    NSLog(@"取出ID\n%ld \n%ld \n%ld \n%@",sender.tag,sender.tag/1000,sender.tag%1000,photoId);
}

@end
