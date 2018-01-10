//
//  SpecialDayCell.m
//  Friend
//
//  Created by jy on 2018/1/10.
//  Copyright © 2018年 M. All rights reserved.
//

#import "SpecialDayCell.h"
@interface SpecialDayCell ()
@property (weak, nonatomic) IBOutlet UIImageView *defaultIcon;
@property (weak, nonatomic) IBOutlet UIImageView *defaultPlus;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *daysCount;
@property (weak, nonatomic) IBOutlet UIView *timeBg;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *year;

@end
@implementation SpecialDayCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"SpecialDayCell";
    SpecialDayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SpecialDayCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.day.textColor = COLOR_FFFFFF;
    self.day.font = QHQFontSizeRegular(32);
    
    self.year.textColor = COLOR_FFFFFF;
    self.year.font = QHQFontSizeRegular(16);
    
    self.title.textColor = COLOR_282E39;
    self.title.font = QHQFontSizeRegular(30);
    
    self.daysCount.textColor = COLOR_282E39;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.timeBg.scaleFrame6 = CGRectMake(0, 0, 99, 99);
    self.day.scaleFrame6 = CGRectMake(0, 0, 100, 60);
    self.year.scaleFrame6 = CGRectMake(0, 60, 100, 40);
    
    self.title.scaleFrame6 = CGRectMake(130, 0, 300, 100);
    self.daysCount.scaleFrame6 = CGRectMake(750-180, 0, 150, 100);
    self.defaultPlus.scaleFrame6 = CGRectMake(750-80, 25, 50, 50);
    self.defaultIcon.scaleFrame6 = CGRectMake(38, 20, 60, 60);
}

- (void)setModel:(SpecialDayModel *)model
{
    _model = model;
    NSArray *normalArr = [NSArray arrayWithObjects:@"FD907C",@"F4AC50",@"FFEBA7",@"CBF26E",@"61D8CD",@"3BB5F3",@"A395FF", nil];
    self.title.text = String(model.text);
    if ([model.type isEqualToString:@"local"]) {
        self.timeBg.hidden = YES;
        self.daysCount.hidden = YES;
        self.defaultIcon.image  = [UIImage imageNamed:model.icon];
    }else {
        self.defaultPlus.hidden = YES;
        self.defaultIcon.hidden = YES;
        // 这里需要判断颜色
        self.timeBg.backgroundColor = COLOR([normalArr objectAtIndex:[model.color_style intValue]]);
        self.day.text = model.day;
        self.year.text = [NSString stringWithFormat:@"%@ %@",model.year,model.month];
        NSString *daysCount = [NSString stringWithFormat:@"%@天",model.days_count];
        NSMutableAttributedString *descString = [[NSMutableAttributedString alloc] initWithString:daysCount];
        [descString addAttribute:NSFontAttributeName value:QHQFontSizeRegular(40) range:NSMakeRange(0, daysCount.length-1)];
        [descString addAttribute:NSFontAttributeName value:QHQFontSizeRegular(28) range:NSMakeRange(daysCount.length-1, 1)];
        self.daysCount.attributedText = descString;
    }
}

@end
