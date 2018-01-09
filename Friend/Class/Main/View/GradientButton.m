//
//  GradientButton.m
//  Friend
//
//  Created by jy on 2018/1/9.
//  Copyright © 2018年 M. All rights reserved.
//

#import "GradientButton.h"

@implementation GradientButton

- (id)initWithFrame:(CGRect)frame Model:(HomeButtonModel *)model{
    if (self = [super initWithFrame:frame]) {
        self.model = model;
        [self initButtonWithModel:model];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initButtonWithModel:self.model];
}

- (void)initButtonWithModel:(HomeButtonModel *)model;
{
    [self setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
    [self setTitleColor:COLOR_FFFFFF forState:UIControlStateDisabled];
    self.titleLabel.font = QHQFontSizeRegular(28);
    self.scaleFrame6 = CGRectMake(110, 0, 300, 170);
    UIImage *image = [UIImage rectangleGradientImageFromColor:COLOR(model.leftColor) toColor:COLOR(model.rightColor) gradientDirectionType:GradientDirectionTypeLeftToRight imageSize:self.bounds.size];

    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage createImageWithColor:COLOR_DFE3E3] forState:UIControlStateDisabled];
    
    UIImage *img = [UIImage imageNamed:@"alpha.png"];
    UIImageView *aImage = [[UIImageView alloc] init];
    aImage.image = img;
    aImage.scaleFrame6 = CGRectMake(300-164, 170-104, 164, 104);
    [self addSubview:aImage];
    
    UILabel *title = [[UILabel alloc] init];
    title.scaleFrame6 = CGRectMake(40, 30, 150, 40);
    title.textColor = COLOR_FFFFFF;
    title.font = QHQFontSizeRegular(30);
    title.text = model.title;
    [self addSubview:title];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.scaleFrame6 = CGRectMake(300-64-30, 30, 64, 64);
    icon.backgroundColor = COLOR_FFFFFF;
    [self addSubview:icon];
    
    
    UILabel *desc = [[UILabel alloc] init];
    desc.scaleFrame6 = CGRectMake(40, 80, 150, 60);
    desc.font = QHQFontSizeRegular(38);
    desc.textColor = COLOR_FFFFFF;
    desc.text = model.desc;
    [self addSubview:desc];
    
    
    NSMutableAttributedString *descString = [[NSMutableAttributedString alloc] initWithString:model.desc];
    [descString addAttribute:NSFontAttributeName value:QHQFontSizeRegular(70) range:NSMakeRange(0, model.desc.length-1)];
    [descString addAttribute:NSFontAttributeName value:QHQFontSizeRegular(38) range:NSMakeRange(model.desc.length-1, 1)];
    desc.attributedText = descString;

    
    // 设置圆角
    self.layer.cornerRadius = 12 * WIDTH_SCALE_6;
    self.layer.masksToBounds = YES;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (enabled) {
        self.clipsToBounds = NO;
    } else {
        self.clipsToBounds = YES;
    }
}

@end
