//
//  IuxuryTableViewCell.m
//  Shopping
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "IuxuryTableViewCell.h"
#import "IuxuryModel.h"
#import "NSString+StringToDate.h"
/** 图片与上下的边距 */
#define Spacing 15
/** 奢抢惠图片宽度 */
#define imageW 150

@interface IuxuryTableViewCell()

@end

@implementation IuxuryTableViewCell

-(void)createIuxuryCellWithData:(IuxuryModel *)model
{
    CGFloat imageViewX = (SCREEN_WIDTH * 0.5 - imageW) * 0.5;
    UIImageView * iuxuryImageView = [[UIImageView alloc] initWithFrame:CGRectMake( imageViewX, Spacing, imageW, imageW)];
    [iuxuryImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"loading"]];
    iuxuryImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:iuxuryImageView];
    
    
    CGFloat labelX = CGRectGetMaxX(iuxuryImageView.frame) + Spacing * 2;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 2.5 * Spacing, SCREEN_WIDTH - labelX, 20)];
    label.text = @"奢抢惠";
    label.font = [UIFont systemFontOfSize:19];
    label.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:label];
    
    CGFloat timeLabelX = 40.f;
    for (int i = 0; i < 5 ; i++) {
        if(i % 2 )
        {
            UILabel * pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX - 10 + timeLabelX * (i + 1) * 0.5 , CGRectGetMaxY(label.frame) + Spacing * 0.5, 10, 20)];
            pointLabel.text = @":";
            pointLabel.textColor = [UIColor blackColor];
            pointLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:pointLabel];
        }
        else
        {
            UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX + timeLabelX * i * 0.5, CGRectGetMaxY(label.frame) + Spacing * 0.5, 30, 20)];
            timeLabel.text = @"11";
            timeLabel.backgroundColor = [UIColor blackColor];
            timeLabel.textColor = [UIColor whiteColor];
            timeLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:timeLabel];
        }
    }
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, CGRectGetMaxY(label.frame) + 25 + Spacing * 1.5, 30, 20)];
    nameLabel.text = model.brandCnName;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:nameLabel];
    
    UILabel * ennameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 10, CGRectGetMaxY(label.frame) + 25 + Spacing * 1.5, 60, 20)];
    ennameLabel.text = model.brandEnName;
    ennameLabel.textColor = [UIColor blackColor];
    ennameLabel.textAlignment = NSTextAlignmentLeft;
    ennameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:ennameLabel];
    
    UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, CGRectGetMaxY(nameLabel.frame) + Spacing * 0.1, 100, 20)];

    NSString * str = [NSString stringWithFormat:@"%ld",(long)model.secooPrice];
    priceLabel.text = [NSString stringWithFormat:@"RMB   %@",[self stringWithComma:str]];
    priceLabel.textColor = [UIColor blackColor];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:priceLabel];
}

-(NSString *)stringWithComma:(NSString *)str
{
    NSMutableString * strM = [NSMutableString stringWithString:str];
    static int div = 0;
    for (NSInteger i = strM.length; i > 0; i--) {
        div++;
        if(div % 3 == 0 && i != 1)
        {
            div = 0;
            [strM insertString:@"," atIndex:i - 1];
        }
    }
    return strM;
    return nil;
}

@end
