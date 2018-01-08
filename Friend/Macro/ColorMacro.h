//
//  ColorMacro.h
//  Friend
//
//  Created by JY on 2017/2/8.
//  Copyright © 2017年 M. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h

#import "UIColor+Hex.h"

#define COLOR(var)   [UIColor colorWithHexString:var]
#define COLOR_BASE(var, alpha)   [UIColor colorWithHexString:var alpha:alpha]
#define COLOR_RGB(r,g,b)       [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]
#define COLOR_RGB_BASE(r,g,b,a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define COLOR_RANDOM           COLOR_RGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

#define COLOR_FFFFFF COLOR(@"FFFFFF")
#define COLOR_F3F4F5 COLOR(@"F3F4F5")
#define COLOR_FFC43A COLOR(@"FFC43A")
#define COLOR_FF4F5B COLOR(@"FF4F5B")
#define COLOR_659FFF COLOR(@"659FFF")
#define COLOR_0DB789 COLOR(@"0DB789")
#define COLOR_333333 COLOR(@"333333")
#define COLOR_282E39 COLOR(@"282E39")
#define COLOR_8C959D COLOR(@"8C959D")
#define COLOR_5A90F2 COLOR(@"5A90F2")
#define COLOR_DFE3E3 COLOR(@"DFE3E3")
#define COLOR_F9F9F9 COLOR(@"F9F9F9")

#endif /* QHQColorMacro_h */
