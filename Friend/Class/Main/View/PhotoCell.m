//
//  PhotoCell.m
//  Friend
//
//  Created by jy on 2018/1/31.
//  Copyright © 2018年 M. All rights reserved.
//

#import "PhotoCell.h"
@interface PhotoCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteButton;
@end
@implementation PhotoCell
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = self.contentView.bounds;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        _deleteButton.frame = CGRectMake(self.imageView.width-40, 0, 40, 40);
        _deleteButton.backgroundColor = [UIColor blackColor];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView addSubview:self.imageView];
}
- (void)setTag:(NSInteger)tag {
    self.deleteButton.tag = tag;
}
- (void)setImageName:(UIImage *)imageName{
    self.imageView.image = imageName;
}

- (void)setEdit:(BOOL)edit {
    self.deleteButton.hidden = !edit;
}

- (void)deleteButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteButtonClickWithSender:)]) {
        [self.delegate deleteButtonClickWithSender:sender];
    }
}
@end
