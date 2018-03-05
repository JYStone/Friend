//
//  PhotoCell.h
//  Friend
//
//  Created by jy on 2018/1/31.
//  Copyright © 2018年 M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPhotoModel.h"
@protocol PhotoCellDelegate <NSObject>
- (void)deleteButtonClickWithSender:(UIButton *)sender;
@end
@interface PhotoCell : UICollectionViewCell
@property (nonatomic, weak) id<PhotoCellDelegate> delegate;
@property (nonatomic, strong) HXPhotoModel *photoModel;
@property (nonatomic, weak) UIImage *imageName;
@property (nonatomic, assign) BOOL edit;
@property (nonatomic, assign) NSInteger tag;

@end
