//
//  TabBar.m
//  彩票
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 LeiYIXu. All rights reserved.
//

#import "TabBar.h"
#import "TabBarButton.h"

@interface TabBar ()

@property(strong , nonatomic) UIButton * btnn;

@end

@implementation TabBar

-(void)addTabBarButtonWithNormalImageName:(NSString *)norName andDisableImageName:(NSString *)disName
{
    TabBarButton * btn = [[TabBarButton alloc]init];
    
    [btn setBackgroundImage:[UIImage imageNamed:norName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:disName] forState:UIControlStateDisabled];
    
    [self addSubview:btn];
    
    [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchDown];
    
    //设置为选中状态
    if (1 == self.subviews.count) {
        [self btnOnClick:btn];
    }
    
    //设置按钮高亮状态不调整图片
    btn.adjustsImageWhenHighlighted = NO;

}

-(void)btnOnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidSelectBtnFrom:WithTo:) ]) {
        [self.delegate tabBarDidSelectBtnFrom:self.btnn.tag WithTo:button.tag - 99];
    }
    
    self.btnn.enabled = YES;
    
    button.enabled = NO;
    
    self.btnn = button;
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    for (int i = 0; i < self.subviews.count; i++) {
        
        UIButton * btn = self.subviews[i];

        CGFloat btnY = 0;
        CGFloat btnW = self.frame.size.width / self.subviews.count;
        CGFloat btnH = self.frame.size.height;
        CGFloat btnX = i * btnW;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        btn.tag = i + 99;
    }

}

@end
