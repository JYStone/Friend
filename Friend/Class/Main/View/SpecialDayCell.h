//
//  SpecialDayCell.h
//  Friend
//
//  Created by jy on 2018/1/10.
//  Copyright © 2018年 M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialDayModel.h"
@interface SpecialDayCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) SpecialDayModel *model;

@end
