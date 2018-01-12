//
//  SetReminderController.h
//  Friend
//
//  Created by jy on 2018/1/11.
//  Copyright © 2018年 M. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReminderBlockToStirng)(NSInteger index);
@interface SetReminderController : UITableViewController
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) ReminderBlockToStirng block;
@end
