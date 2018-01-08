//
//  NSArray+Extension.m
//  Friend
//
//  Created by JY on 2017/11/3.
//  Copyright © 2017年 M. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)
- (BOOL)hasContentString:(NSString *)str
{
    __block BOOL hasContent = NO;
    [self enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:str]) {
            hasContent = YES;
            *stop = YES;
        }
    }];
    return hasContent;
}
@end
