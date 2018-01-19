//
//  SpecialDayHeadView.m
//  Friend
//
//  Created by jy on 2018/1/10.
//  Copyright © 2018年 M. All rights reserved.
//

#import "SpecialDayHeadView.h"
@interface SpecialDayHeadView()
@property (weak, nonatomic) IBOutlet UIImageView *bgHeadView;
@property (weak, nonatomic) IBOutlet UIImageView *maleHead;
@property (weak, nonatomic) IBOutlet UIImageView *femaleHead;
@property (weak, nonatomic) IBOutlet UIImageView *boardImage;
@property (weak, nonatomic) IBOutlet UILabel *message;
@end

@implementation SpecialDayHeadView
+ (instancetype)setSpecialDayHeadView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SpecialDayHeadView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.scaleFrame6 = CGRectMake(0, 0, 750, 300);
    self.scaleFrame6 = CGRectMake(0, 0, 750, 200);
    self.backgroundColor = COLOR_RANDOM;
    self.message.textColor = COLOR_FFFFFF;
    self.message.font = QHQFontSizeRegular(30);
    self.message.numberOfLines = 2;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scaleFrame6 = CGRectMake(0, 0, 750, 200);
    self.bgHeadView.scaleFrame6 = CGRectMake(0, 0, 750, 200);
//    self
//    self.bgHeadView.image = [UIImage resizedImage:@"nav_bar_bg.png"];
//    CGSize size = self.bgHeadView.bounds.size;
//    CGFloat startHeight = 0;
//    CGFloat endHeight = size.height * 0.7;
//    UIBezierPath *aPath = [UIBezierPath bezierPath];
//    [aPath moveToPoint:CGPointMake(0, endHeight)];
//    [aPath addLineToPoint:CGPointMake(0, startHeight)];
//    [aPath addLineToPoint:CGPointMake(size.width, startHeight)];
//    [aPath addLineToPoint:CGPointMake(size.width, endHeight)];
//    [aPath addQuadCurveToPoint:CGPointMake(0, endHeight) controlPoint:CGPointMake(size.width/2, size.height)];
//    
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.strokeColor = [UIColor purpleColor].CGColor;
//    layer.fillColor = [UIColor whiteColor].CGColor;
//    layer.path = aPath.CGPath;
//    //最后添加——bgCv （setMask 面具）
//    [self.bgHeadView.layer setMask:layer];
}

@end
