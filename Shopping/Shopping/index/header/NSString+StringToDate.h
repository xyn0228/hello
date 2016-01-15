//
//  NSString+StringToDate.h
//  Shopping
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringToDate)
/** 字符串转化成Date */
+(NSDate *)DateByString:(NSString *)str;
/** 得到系统时间（字符串形式） */
+(NSString *)dateStrBySysDate;
@end
