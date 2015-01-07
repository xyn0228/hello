//
//  DJTabBarController.m
//  彩票
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 LeiYIXu. All rights reserved.
//

#import "DJTabBarController.h"
#import "TabBar.h"
#import "TabBarButton.h"

@interface DJTabBarController ()<DJTabBarDelegata>

@end

@implementation DJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
     //创建自定义View
    TabBar *myTabbar = [[TabBar alloc]init];
    myTabbar.frame = self.tabBar.frame;
    myTabbar.delegate = self;
    [self.view addSubview:myTabbar];
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        
        NSString * norImage = [NSString stringWithFormat:@"TabBar%d",i+1];
        NSString * selImage = [NSString stringWithFormat:@"TabBar%dSel",i+1];
        //只要调用自定义的Tabbar方法就会创建一个按钮
        [myTabbar addTabBarButtonWithNormalImageName:norImage andDisableImageName:selImage];
        
    }
    //删除系统自带的tabbar
    [self.tabBar removeFromSuperview];
    
    //设置全部导航栏主题
    UINavigationBar * navBar =  [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    [navBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18],NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

-(void)tabBarDidSelectBtnFrom:(NSInteger)from WithTo:(NSInteger)to
{
    //切换子控制器
    self.selectedIndex = to;
}

@end
