//
//  HomeOneTableViewCell.m
//  Shopping
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "HomeOneTableViewCell.h"
#import "IndexFirstModel.h"

#define Spacing 6

#define baseTap 300

@interface HomeOneTableViewCell()

@end

@implementation HomeOneTableViewCell

-(void)createTableViewCellWithDataSourceArr:(NSArray *)arr
{
    self.contentView.backgroundColor = [UIColor colorWithRed:0.56f green:0.56f blue:0.56f alpha:1.00f];
    switch (arr.count) {
        case 1:
            [self loadSingleCellWithDataSource:arr];
            break;
        case 2:
            [self loadDoubelCellWithDataSource:arr];
            break;
        case 4:
            [self loadFourCellWithDataSource:arr];
            break;
        case 5:
            [self loadFiveCellWithDataSource:arr];
            break;
        default:
            break;
    }
}
/** 一张图片 */
-(void)loadSingleCellWithDataSource:(NSArray *)array
{
    IndexFirstModel * model = array.lastObject;
    CGFloat midImageH = SCREEN_WIDTH * 350 / 750;
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, Spacing * 0.5, SCREEN_WIDTH, midImageH)];
    /** 处理背景色 */
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, midImageH + Spacing * 0.5)];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    [self.contentView addSubview:view];
    [self loadBaseImageViewWithImageView:imageView andModel:model andWithTag:0];
}
/** 两张图片 */
-(void)loadDoubelCellWithDataSource:(NSArray *)array
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < array.count; i++) {
        IndexFirstModel * model = array[i]; // h = (screen_width - spacing) * 0.5 * 470 / 370;
        CGFloat imageViewW = (SCREEN_WIDTH - Spacing) * 0.5;
        CGFloat imageViewH = imageViewW * 470 / 370;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((Spacing + imageViewW) * i, Spacing * 0.5, imageViewW, imageViewH)];
        [self loadBaseImageViewWithImageView:imageView andModel:model andWithTag:i];
    }
}
/** 四张图片 */
-(void)loadFourCellWithDataSource:(NSArray *)array
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < array.count; i++) {
        IndexFirstModel * model = array[i];
        UIImageView * imageView = [[UIImageView alloc] init];
        CGFloat imageViewBaseH = SCREEN_WIDTH * 70 / 750;
        CGFloat midImageViewH = SCREEN_WIDTH * 330 / 750;
        if(i == 1)
        {
            imageView.frame = CGRectMake(0, imageViewBaseH, SCREEN_WIDTH, midImageViewH);
        }
        else if (i == 0)
        {
            imageView.frame = CGRectMake(0, Spacing * 0.5, SCREEN_WIDTH, imageViewBaseH);
        }
        else
        {
            CGFloat imageViewW = (SCREEN_WIDTH - Spacing) * 0.5;
            CGFloat imageViewH = imageViewW * 460 / 370;
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake((Spacing + imageViewW) * (i - 2), imageViewBaseH + midImageViewH + Spacing , imageViewW, imageViewH)];
        }
        [self loadBaseImageViewWithImageView:imageView andModel:model andWithTag:i];
    }
}
/** 五张图片 */
-(void)loadFiveCellWithDataSource:(NSArray *)array
{
    for (int i = 0; i < array.count; i++) {
        IndexFirstModel * model = array[i];//h = SCREEN_WIDTH * 493 / 750+ screen_wi /3 + spacing
        UIImageView * imageView = [[UIImageView alloc] init];
        CGFloat imageViewBaseH = SCREEN_WIDTH * 493 / 750;
        if(i == 0)
        {
            imageView.frame = CGRectMake(0, Spacing * 0.5, SCREEN_WIDTH, imageViewBaseH);
            
        }
        else if (i == 1)
        {
            CGFloat imageViewH = imageViewBaseH /493 * 75;
            CGFloat imageViewW = imageViewH * 225 / 70;
            CGFloat imageViewX = (SCREEN_WIDTH - imageViewW) * 0.5;
            imageView.frame = CGRectMake( imageViewX, Spacing * 0.5, imageViewW, imageViewH);
        }
        else
        {
            CGFloat imageViewH = SCREEN_WIDTH / 3;
            imageView.frame = CGRectMake(imageViewH * (i - 2), imageViewBaseH, imageViewH, imageViewH);
        }
        [self loadBaseImageViewWithImageView:imageView andModel:model andWithTag:i];
    }
}
/** 图片的公共设置 */
-(void)loadBaseImageViewWithImageView:(UIImageView *)imageView andModel:(IndexFirstModel *)model andWithTag:(int)index
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"loading"]];
    imageView.tag = baseTap + index;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewClick:)];
    [imageView addGestureRecognizer:tap];
    
    [self.contentView addSubview:imageView];
}

-(void)tapImageViewClick:(UIGestureRecognizer *)tap
{
    self.block(tap.view.tag);
}
@end
