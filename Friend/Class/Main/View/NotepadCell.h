//
//  NotepadCell.h
//  Friend
//
//  Created by jy on 2018/1/12.
//  Copyright © 2018年 M. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotepadCellDelegate<NSObject>
- (void)likeActionClick;
- (void)commentActionClick;
@end

@interface NotepadCell : UITableViewCell
@property (nonatomic, weak) id<NotepadCellDelegate>delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
