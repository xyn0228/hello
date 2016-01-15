//
//  IuxuryModel.h
//  Shopping
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IuxuryModel : NSObject
/** 开始时间 */
@property (nonatomic, assign) long endTime;
/** 商品名称 */
@property (nonatomic, copy) NSString *productName;
/** 图片网址 */
@property (nonatomic, copy) NSString *imageUrl;
/** size */
//@property (nonatomic, assign) NSInteger size;
/** 英文名 */
@property (nonatomic, copy) NSString *brandEnName;
/** 中文名 */
@property (nonatomic, copy) NSString *brandCnName;
/** 时间节点 */
@property (nonatomic, copy) NSString *key;
/** 价格 */
@property (nonatomic, assign) NSInteger secooPrice;
/** 开始时间 */
@property (nonatomic, assign) long startTime;

@end
