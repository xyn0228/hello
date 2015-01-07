//
//  TabBar.h
//  彩票
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 LeiYIXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DJTabBarDelegata <NSObject>
/**
 *  从哪个视图到哪个视图
 */
-(void)tabBarDidSelectBtnFrom:(NSInteger)from WithTo:(NSInteger)to;

@end

@interface TabBar : UIView

@property(weak , nonatomic) id<DJTabBarDelegata> delegate;
/**
 *  提供给外界创建按钮
 */
-(void)addTabBarButtonWithNormalImageName:(NSString *)norName andDisableImageName:(NSString *)disName;

@end
