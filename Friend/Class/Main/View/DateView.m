//
//  DateView.m
//  Friend
//
//  Created by jy on 2018/1/11.
//  Copyright © 2018年 M. All rights reserved.
//

#import "DateView.h"
@interface DateView ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *floatView;
@property (nonatomic, copy) NSString *dateStr;
@end
@implementation DateView

+ (instancetype)setDatePicker {
    return [[[NSBundle mainBundle] loadNibNamed:@"DateView" owner:nil options:nil] lastObject];
}
- (IBAction)dateChange:(UIDatePicker *)sender {
    if (self.confirmBlock) {
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *choseDateString = [dateformatter stringFromDate:self.datePicker.date];
        self.confirmBlock(choseDateString);
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.scaleFrame6 = CGRectMake(0, 0, 750, 350);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scaleFrame6 = CGRectMake(0, 0, 750, 350);
}

@end
