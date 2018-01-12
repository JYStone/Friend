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
    [self refreshArticleDataFormHeader];
}

- (void)setupTableHeadView
{
    SpecialDayHeadView *headView = [SpecialDayHeadView setSpecialDayHeadView];
    headView.scaleFrame6 = CGRectMake(0, 0, 750, 300);
//    self.tableView.tableHeaderView = headView;
}

- (void)refreshArticleDataFormHeader
{
    /** 获取文件路径 */
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"SpecialDayList.plist"];

#warning 这个数据 一个账户只能写入一次
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
                             @{@"icon":@"weathericon1.png",@"text":@"1",@"type":@"local"},
                             @{@"icon":@"weathericon2.png",@"text":@"3",@"type":@"local"},
                             @{@"icon":@"weathericon3.png",@"text":@"2",@"type":@"local"},
                             @{@"icon":@"weathericon4.png",@"text":@"4",@"type":@"local"},
                             @{@"icon":@"weathericon5.png",@"text":@"5",@"type":@"local"},
                             @{@"icon":@"weathericon6.png",@"text":@"6",@"type":@"local"},nil];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{//编辑的方法，如果其它的编辑都不设，只设了这一个，那么就会有cell右滑出现删除的按钮，也是比较常用的
    if (editingStyle == UITableViewCellEditingStyleDelete){
        //删除
        [self.specialDayArr removeObjectAtIndex:indexPath.row];
        //删除数据源记录
        [self deleteData:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationFade];//删除cell
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath
{//删除按钮的字
    return @"删";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //返回编辑模式，默认是删除
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    //移动，不实现这个代理方法，就不会出现移动的按钮
    [self.specialDayArr removeObjectAtIndex:sourceIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{//默认所有的都是可以编辑的（增，删）
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{//默认所有的都是可以移动的
    return YES;
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
    
    //那怎么证明我的数据写入了呢？读出来看看
    NSLog(@"---plist一开始保存时候的内容---%@",dataArray);
}
- (void)rightItemClick
{
    
}
@end
