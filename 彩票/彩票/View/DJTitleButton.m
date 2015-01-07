//
//  DJTitleButton.m
//  彩票
//
//  Created by qianfeng on 17/1/5.
//  Copyright © 2017年 LeiYIXu. All rights reserved.
//

#import "DJTitleButton.h"

@interface DJTitleButton ()

@property(strong , nonatomic) UIFont * myFont;

@end

@implementation DJTitleButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    self.myFont = [UIFont systemFontOfSize:15];
    self.titleLabel.font = self.myFont;
    
    self.imageView.contentMode = UIViewContentModeCenter;
}
//返回标题按钮文字的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = contentRect.size.height;
    NSString * title = self.currentTitle;
    
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    md[NSFontAttributeName] = self.myFont;
   CGRect titleRect = [title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:md context:nil];
    CGFloat titleW = titleRect.size.width;
    return CGRectMake(titleX, titleY, titleW, titleH);
    
    
    NSLog(@"1111");
}
//返回标题image的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageW = 16;
    CGFloat imageX = contentRect.size.width - imageW;

    return CGRectMake(imageX, imageY, imageW, imageH);
}
@end
