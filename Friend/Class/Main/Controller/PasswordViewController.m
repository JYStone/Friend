//
//  PasswordViewController.m
//  Friend
//
//  Created by jy on 2018/1/8.
//  Copyright © 2018年 M. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, assign) BOOL passwordIsOpen;
@property (nonatomic, strong) UISwitch *switchBtn;
@end

@implementation PasswordViewController

- (NSMutableArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObjects:@"锁屏密码",@"Touch ID",nil];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_FFFFFF;
    [self setUpTableView];
}

- (void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = COLOR_RANDOM;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (void)setUpTableViewHeader
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*HEIGHT_SCALE_6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"llala";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"setting-%ld",indexPath.row+1]];
    cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    
    UISwitch *switchBtn = [self setupSwithWithTag:indexPath.row];
    if (indexPath.row == 0) {
        switchBtn.enabled = YES;
    }else {
        self.switchBtn = switchBtn;
        switchBtn.enabled = self.passwordIsOpen;
    }
    [cell.contentView addSubview:switchBtn];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UISwitch *)setupSwithWithTag:(NSInteger)tag
{
    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(DEVICE_SCREEN_WIDTH-51-20, (100*HEIGHT_SCALE_6-31)/2, 51, 31)];
    switchButton.tag = 100+tag;
    [switchButton setOn:NO];
    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    return switchButton;
}

-(void)switchAction:(UISwitch *)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (sender.tag == 100){
        self.passwordIsOpen = isButtonOn;
        self.switchBtn.enabled = isButtonOn;
        if (isButtonOn) {
            NSLog(@"1是");
        }else {
            NSLog(@"1否");
        }
    }else {
        if (isButtonOn) {
            NSLog(@"是");
        }else {
            NSLog(@"否");
        }
    }
}

@end
