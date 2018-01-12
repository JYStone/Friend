//
//  SetReminderController.m
//  Friend
//
//  Created by jy on 2018/1/11.
//  Copyright © 2018年 M. All rights reserved.
//
//  设置提醒
#import "SetReminderController.h"
#import "SelectedModel.h"
@interface SetReminderController ()
@property (nonatomic, strong) NSMutableArray *reminderArr;
@end

@implementation SetReminderController

- (NSMutableArray *)reminderArr
{
    if (!_reminderArr) {
        _reminderArr = [NSMutableArray array];
    }
    return _reminderArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置提醒";
    self.tableView.backgroundColor = COLOR_F9F9F9;
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"无",@"每周",@"每月",@"每年", nil];
    [titleArr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectedModel *model = [[SelectedModel alloc] init];
        model.title = title;
        if (idx == self.index) {
            model.select = YES;
        }else {
            model.select = NO;
        }
        [self.reminderArr addObject:model];
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*HEIGHT_SCALE_6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SetReminderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.reminderArr.count>0) {
        SelectedModel *model = self.reminderArr[indexPath.row];
        cell.textLabel.text = model.title;
        if (model.select == YES) {
            UIImageView *accessoryView= [[UIImageView alloc] init];
            accessoryView.scaleFrame6 = CGRectMake(0, 0, 43, 28);
            accessoryView.image = [UIImage imageNamed:@"icon_record_local.png"];
            cell.accessoryView = accessoryView;
        } else {
            cell.accessoryView.hidden = YES;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 设置
    [self.reminderArr enumerateObjectsUsingBlock:^(SelectedModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.select = NO;
    }];
    SelectedModel *model = self.reminderArr[indexPath.row];
    model.select = YES;
    [tableView reloadData];
    if (self.block) {
        self.block(indexPath.row);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
