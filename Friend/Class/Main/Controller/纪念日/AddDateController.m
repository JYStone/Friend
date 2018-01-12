//
//  AddDateController.m
//  Friend
//
//  Created by jy on 2018/1/10.
//  Copyright © 2018年 M. All rights reserved.
//
//  添加纪念日
#import "AddDateController.h"
#import "SpecialDayBgController.h"
#import "SetReminderController.h"
#import "DateView.h"
@interface AddDateController ()
@property (nonatomic, assign) NSInteger isSelected;
@property (nonatomic, strong) UITextField *textTF;
@property (nonatomic, strong) NSArray *rateArr;
@property (nonatomic, copy) NSString *dateStr;

@end

@implementation AddDateController
- (NSArray *)rateArr
{
    if (!_rateArr) {
        _rateArr = [NSArray arrayWithObjects:@"无",@"每周",@"每月",@"每年", nil];
    }
    return _rateArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加纪念日";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.tableView.backgroundColor = COLOR_F9F9F9;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.isSelected = 1;
}

- (void)rightClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        if ([BaseService isBlankString:self.text]) {
            return 3;
        }else {
            return 2;
        }
    }else if (section == 2) {
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1) {
        return 350*HEIGHT_SCALE_6;
    }
    return 90*HEIGHT_SCALE_6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = COLOR_F9F9F9;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = COLOR_F9F9F9;
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"addDate";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        NSArray *normalArr = [NSArray arrayWithObjects:@"FD907C",@"F4AC50",@"FFEBA7",@"CBF26E",@"61D8CD",@"3BB5F3",@"A395FF", nil];
        if (indexPath.row == 0) {
            UIImageView *markImage = [[UIImageView alloc] init];
            markImage.scaleFrame6 = CGRectMake(50, 25, 40, 40);
            markImage.layer.masksToBounds = YES;
            markImage.layer.cornerRadius = 20*HEIGHT_SCALE_6;
            markImage.image = [UIImage createImageWithColor:COLOR(normalArr[self.isSelected])];
            [cell.contentView addSubview:markImage];
            
            UITextField *tf = [[UITextField alloc] init];
            tf.scaleFrame6 = CGRectMake(120, 0, 500, 90);
            self.textTF = tf;
            tf.font = QHQFontSizeRegular(28);
            tf.textColor = COLOR_282E39;
            tf.placeholder = @"点击这里输入纪念日内容";
            if (![BaseService isBlankString:self.text]) {
                tf.text = self.text;
                tf.userInteractionEnabled = NO;
            }
            [cell.contentView addSubview:tf];
        }else {
            for (int i = 0; i<7; i++) {
                UIButton *button = [[UIButton alloc] init];
                button.tag = 100+i;
                button.scaleFrame6 = CGRectMake(50+100*i, 20, 50, 50);
                button.backgroundColor = COLOR(normalArr[i]);
                [button setImage:[UIImage imageNamed:@"setting-22.png"] forState:UIControlStateSelected];
                button.layer.masksToBounds = YES;
                button.layer.cornerRadius = 25*HEIGHT_SCALE_6;
                button.selected = NO;
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];
                
                if (i == 1) {
                    button.selected = YES;
                }
            }
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"chat.png"];
            NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy年MM月dd日"];
            NSString *dateTime = [formatter stringFromDate:[NSDate date]];
            cell.textLabel.text = dateTime;
        }else if (indexPath.row == 1){
            DateView *dateView = [DateView setDatePicker];
            dateView.confirmBlock = ^(NSString *choseDate) {
                NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:0 inSection:1];
                UITableViewCell *cell= [tableView cellForRowAtIndexPath:indexPathA];
                cell.textLabel.text = choseDate;
            };
            [cell.contentView addSubview:dateView];
        } else {
            cell.imageView.image = [UIImage imageNamed:@"chat.png"];
            cell.textLabel.text = @"提醒";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            // 这里还需要根据情况判断
            cell.detailTextLabel.text = @"无";
        }
    } else {
        cell.imageView.image = [UIImage imageNamed:@"chat.png"];
        cell.textLabel.text = @"背景";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([BaseService isBlankString:self.text] && indexPath.section == 1 && indexPath.row == 2) {
        // 添加提醒
        SetReminderController *reminderVC = [[SetReminderController alloc] init];
        UITableViewCell *cell= [tableView cellForRowAtIndexPath:indexPath];
        
        reminderVC.block = ^(NSInteger index) {
            cell.detailTextLabel.text = self.rateArr[index];
        };
        reminderVC.index = [self.rateArr indexOfObject:cell.detailTextLabel.text];
        [self.navigationController pushViewController:reminderVC animated:YES];
    }
    if (indexPath.section == 2) {
        // 选择背景图片
        SpecialDayBgController *dayBgVC = [[SpecialDayBgController alloc] init];
        [self.navigationController pushViewController:dayBgVC animated:YES];
    }
}

- (void)buttonClick:(UIButton *)sender
{
    for (int i = 100; i<107; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        button.selected = NO;
    }
    UIButton *button = (UIButton *)[self.view viewWithTag:sender.tag];
    button.selected = YES;
    self.isSelected = sender.tag-100;
    NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathA,nil] withRowAnimation:UITableViewRowAnimationNone];
}
@end
