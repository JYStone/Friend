//
//  NotepadCell.m
//  Friend
//
//  Created by jy on 2018/1/12.
//  Copyright © 2018年 M. All rights reserved.
//

#import "NotepadCell.h"
@interface NotepadCell()
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation NotepadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"NotepadCell";
    NotepadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotepadCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = COLOR_F9F9F9;
    self.scaleFrame6 = CGRectMake(0, 0, 750, 200);
    
    self.dateLabel.font = QHQFontSizeRegular(22);
    self.desc.font = QHQFontSizeRegular(24);
    
    self.dateLabel.textColor = COLOR_8C959D;
    self.dateLabel.textColor = COLOR_282E39;
    
    self.markImageView.image = [UIImage imageNamed:@"progress_blue"];
    self.markImageView.layer.shadowColor = COLOR(@"f17cbe").CGColor;
    self.markImageView.layer.shadowOffset = CGSizeMake(0, 2);
    self.markImageView.layer.shadowOpacity = 0.5;
    
    self.bgView.layer.cornerRadius = 10*HEIGHT_SCALE_6;
    self.bgView.layer.shadowColor = COLOR(@"000000").CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 2);
    self.bgView.layer.shadowOpacity = 0.2;
    
    self.dateLabel.text = @"2017年3月15 星期二";
    self.desc.text = @"建议请启用 FileVault ，这个功能可以对 Mac 笔记本电脑上的数据加密。";
    [self.zanBtn setImage:[UIImage imageNamed:@"profile_2"] forState:UIControlStateNormal];
    [self.commentBtn setImage:[UIImage imageNamed:@"profile_1"] forState:UIControlStateNormal];
    self.lineView.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.markImageView.scaleFrame6 = CGRectMake(30, 10, 70, 70);
    self.bgView.scaleFrame6 = CGRectMake(140, 10, 580, 130);
    self.lineView.scaleFrame6 = CGRectMake(65, 85, 1, 115);
    self.dateLabel.scaleFrame6 = CGRectMake(20, 10, 400, 30);
    self.desc.scaleFrame6 = CGRectMake(30, 40, 520, 80);
    
    self.zanBtn.scaleFrame6 = CGRectMake(630, 150, 40, 40);
    self.commentBtn.scaleFrame6 = CGRectMake(680, 150, 40, 40);
}
- (IBAction)zanBtnClick:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(likeActionClick)]) {
//        [self.delegate likeActionClick];
//    }
    
    if (self.likeActionBlock) {
        self.likeActionBlock();
    }
}
- (IBAction)commentBtnClick:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(commentActionClick)]) {
//        [self.delegate commentActionClick];
//    }
    
    if (self.commentActionBlock) {
        self.commentActionBlock();
    }
}
@end
