//
//  IuxuryTableViewCell.h
//  Shopping
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  IuxuryModel;
@interface IuxuryTableViewCell : UITableViewCell
-(void)createIuxuryCellWithData:(IuxuryModel *)model;
@end
