//
//  AddDateController.m
//  Friend
//
//  Created by jy on 2018/1/10.
//  Copyright © 2018年 M. All rights reserved.
//

#import "AddDateController.h"

@interface AddDateController ()
@property (nonatomic, assign) NSInteger isSelected;
@end

@implementation AddDateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加纪念日";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.tableView.backgroundColor = COLOR_F9F9F9;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.isSelected = 1;
}

- (void)rightClick {
    NSLog(@"张辉是个大傻子");
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 1;
    }else {
        return 2;
    }
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        NSArray *normalArr = [NSArray arrayWithObjects:@"FD907C",@"F4AC50",@"FFEBA7",@"CBF26E",@"61D8CD",@"3BB5F3",@"A395FF", nil];
        if (indexPath.row == 0) {
            UIImageView *markImage = [[UIImageView alloc] init];
            markImage.scaleFrame6 = CGRectMake(50, 20, 50, 50);
            markImage.layer.masksToBounds = YES;
            markImage.layer.cornerRadius = 25*HEIGHT_SCALE_6;
            markImage.image = [UIImage createImageWithColor:COLOR(normalArr[self.isSelected])];
            [cell.contentView addSubview:markImage];
        }else {
            for (int i = 0; i<7; i++) {
                UIButton *button = [[UIButton alloc] init];
                button.tag = 100+i;
                button.scaleFrame6 = CGRectMake(50+100*i, 20, 50, 50);
                [button setBackgroundImage:[UIImage createImageWithColor:COLOR(normalArr[i])] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"background_skin_download.png"] forState:UIControlStateSelected];
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
            cell.textLabel.text = @"2017年1月10日";
        }else {
            
        }
    } else {
        cell.imageView.image = [UIImage imageNamed:@"chat.png"];
        cell.textLabel.text = @"背景";
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat.png"]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        // 选择背景图片
        
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
