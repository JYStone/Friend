//
//  WeaveTimeController.m
//  Friend
//
//  Created by jy on 2018/1/12.
//  Copyright © 2018年 M. All rights reserved.
//

#import "WeaveTimeController.h"
#import "NotepadTextView.h"
@interface WeaveTimeController ()

@end

@implementation WeaveTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_F9F9F9;
    self.title = @"编织时光";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    [self setupScrollView];
}

- (void)rightClick {
    NSLog(@"完成");
}
- (void)setupScrollView {
    //scrollView 自动适应Viewde 高度
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = COLOR_RANDOM;
    [self.view addSubview:scrollView];
    
    NotepadTextView *textView = [[NotepadTextView alloc] init];
    textView.alwaysBounceVertical = YES;// 垂直方向上拥有有弹簧效果
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    
    textView.placehoder = @"请输入文字";
    textView.font = QHQFontSizeRegular(34);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
