//
//  NSString+StringToDate.m
//  Shopping
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "NSString+StringToDate.h"

@implementation NSString (StringToDate)
+(NSDate *)DateByString:(NSString *)str
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    return [dateFormatter dateFromString:str];
}

+(NSString *)dateStrBySysDate
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSDate * date = [NSDate date];
    return [dateFormatter stringFromDate:date];
}
@end
