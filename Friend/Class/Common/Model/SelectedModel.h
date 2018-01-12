//
//  SelectedModel.h
//  Friend
//
//  Created by jy on 2018/1/11.
//  Copyright © 2018年 M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectedModel : NSObject
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  是否选中
 */
@property (nonatomic, assign, getter=isSelect) BOOL select;
@end
