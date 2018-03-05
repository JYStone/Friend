//
//  NotepadController.m
//  Friend
//
//  Created by jy on 2018/1/12.
//  Copyright © 2018年 M. All rights reserved.
//

#import "NotepadController.h"
#import "WeaveTimeController.h"
#import "NotepadCell.h"
@interface NotepadController ()<NotepadCellDelegate>

@end

@implementation NotepadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时光";
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.scaleFrame6 = CGRectMake(0, 0, 750, 250);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"WechatIMG94"];
    imageView.clipsToBounds = YES;
    self.tableView.tableHeaderView = imageView;
}

- (void)rightClick {
    NSLog(@"添加记录");
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5*HEIGHT_SCALE_6;
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
    footerView.backgroundColor = COLOR_DFE3E3;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200*HEIGHT_SCALE_6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotepadCell *cell = [NotepadCell cellWithTableView:tableView];
//    cell.delegate = self;
    cell.likeActionBlock = ^{
        NSLog(@"1点赞");
    };
    
    cell.commentActionBlock = ^{
        NSLog(@"1评论");
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeaveTimeController *weaveTimeVC = [[WeaveTimeController alloc] init];
    [self.navigationController pushViewController:weaveTimeVC animated:YES];
}

- (void)likeActionClick
{
    NSLog(@"点赞");
}

- (void)commentActionClick
{
    NSLog(@"评论");
    // 弹出键盘
    
}
@end
