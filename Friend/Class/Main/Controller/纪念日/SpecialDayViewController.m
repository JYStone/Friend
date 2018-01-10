//
//  SpecialDayViewController.m
//  Friend
//
//  Created by jy on 2018/1/9.
//  Copyright © 2018年 M. All rights reserved.
//

#import "SpecialDayViewController.h"
#import "AddDateController.h"
#import "SpecialDayHeadView.h"
#import "RefreshHeader.h"
#import "SpecialDayCell.h"
@interface SpecialDayViewController ()
@property (nonatomic, strong) NSMutableArray *specialDayArr;
@end

@implementation SpecialDayViewController

- (NSMutableArray *)specialDayArr
{
    if (!_specialDayArr) {
        _specialDayArr = [NSMutableArray array];
    }
    return _specialDayArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"纪念日";
    self.view.backgroundColor = COLOR_FFFFFF;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav-bar-album" highImageName:@"nav-bar-album" target:self action:@selector(rightItemClick)];
    
    self.tableView.backgroundColor = COLOR_F9F9F9;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self setupTableHeadView];
    
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshArticleDataFormHeader:)];
    self.tableView.mj_header = mj_header;
    
    NSArray *list = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SpecialDayList" ofType:@"plist"]];
    self.specialDayArr = [SpecialDayModel mj_objectArrayWithKeyValuesArray:list];
}

- (void)setupTableHeadView
{
    SpecialDayHeadView *headView = [SpecialDayHeadView setSpecialDayHeadView];
    headView.scaleFrame6 = CGRectMake(0, 0, 750, 300);
//    self.tableView.tableHeaderView = headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.specialDayArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*HEIGHT_SCALE_6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialDayCell *cell  = [SpecialDayCell cellWithTableView:tableView];
    if (self.specialDayArr.count>0) {
        cell.model = self.specialDayArr[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SpecialDayModel *model = self.specialDayArr[indexPath.row];
    if ([model.type isEqualToString:@"local"]) {
        // 选择时间
        AddDateController *addDataVC = [[AddDateController alloc] init];
        [self.navigationController pushViewController:addDataVC animated:YES];
    }else {
        // 查看
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
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

- (void)rightItemClick
{
    
}
@end
