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
    [self setupTableHeadView];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav-bar-album" highImageName:@"nav-bar-album" target:self action:@selector(rightItemClick)];
    
    self.tableView.backgroundColor = COLOR_F9F9F9;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
//    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshArticleDataFormHeader)];
//    self.tableView.mj_header = mj_header;
    [self refreshArticleDataFormHeader];
}

- (void)setupTableHeadView
{
    SpecialDayHeadView *headView = [SpecialDayHeadView setSpecialDayHeadView];
    headView.scaleFrame6 = CGRectMake(0, 0, 750, 300);
    self.tableView.tableHeaderView = headView;
}

- (void)refreshArticleDataFormHeader
{
    /** 获取文件路径 */
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"SpecialDayList.plist"];

#warning 这个数据 一个账户只能写入一次
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
                             @{@"icon":@"weathericon1.png",@"text":@"XX的生日",@"type":@"local"},
                             @{@"icon":@"weathericon2.png",@"text":@"XX的生日",@"type":@"local"},
                             @{@"icon":@"weathericon3.png",@"text":@"XX的生日",@"type":@"local"},
                             @{@"icon":@"weathericon4.png",@"text":@"XX的生日",@"type":@"local"},
                             @{@"icon":@"weathericon5.png",@"text":@"XX的生日",@"type":@"local"},
                             @{@"icon":@"weathericon6.png",@"text":@"XX的生日",@"type":@"local"},nil];
    [array writeToFile:filePatch atomically:YES];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePatch];

    self.specialDayArr = [SpecialDayModel mj_objectArrayWithKeyValuesArray:dataArray];
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
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
//        addDataVC.text = model.text;
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    editingStyle = UITableViewCellEditingStyleDelete;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    设置删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deleteData:indexPath.row];
        [self.specialDayArr removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }];
    return @[deleteRowAction];
}

- (void)deleteData:(NSInteger)indexPath
{
    /** 获取文件路径 */
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"SpecialDayList.plist"];
    
    //根据之前保存的容器类型读取数据
    //是数组就用数组来获取数据，是字典就用字典来获取数据
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePatch];
    [dataArray removeObjectAtIndex:indexPath];
    [dataArray writeToFile:filePatch atomically:YES];
}
- (void)rightItemClick
{
    
}
@end
