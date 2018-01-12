//
//  RefreshHeader.m
//  Friend
//
//  Created by jy on 2018/1/9.
//  Copyright © 2018年 M. All rights reserved.
//

#import "RefreshHeader.h"

@implementation RefreshHeader

- (void)prepare {
    [super prepare];
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i<10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"timeline-animation-%lu", (unsigned long)i]];
        [idleImages addObject:image];
    }
    [self setImages:@[[UIImage imageNamed:@"timeline-animation-1"]] forState:MJRefreshStateIdle];
    [self setImages:idleImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
    
    // 设置文字
    [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开可以刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    // 设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:15];
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    self.stateLabel.textColor = [UIColor blackColor];
    
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
}

@end
