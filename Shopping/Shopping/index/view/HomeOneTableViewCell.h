//
//  HomeOneTableViewCell.h
//  Shopping
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeOneTableViewCell : UITableViewCell

-(void)createTableViewCellWithDataSourceArr:(NSArray *)arr;

@property(nonatomic,copy) void(^block)(NSInteger);

@end
