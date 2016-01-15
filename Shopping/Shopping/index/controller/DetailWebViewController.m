//
//  DetailWebViewController.m
//  Shopping
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "DetailWebViewController.h"

#import "MyNavigationBar.h"
#import "MyNavitaionItem.h"

@interface DetailWebViewController ()

/** 获取全局tabbar */
@property(nonatomic,strong) MyNavigationBar * bar;

@end

@implementation DetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMyNavigationBar];
    [self useWebViewWithURLStr:self.urlStr];
}
/** 加载导航 */
-(void)loadMyNavigationBar
{
    MyNavitaionItem *leftItem = [[MyNavitaionItem alloc] init];
    leftItem.itemImageName = @"back";
    
    MyNavitaionItem * rightItem = [[MyNavitaionItem alloc] init];
    rightItem.itemImageName = @"share";
    
    self.bar = [self createMyNavigationBarWithBgImageName:nil andTitle:self.myTitle andTitleView:nil andLeftItems:@[leftItem] andRightItems:@[rightItem] andSEL:@selector(backHomePage:) andClass:self];
}
/** 加载webView界面 */
-(void)useWebViewWithURLStr:(NSString *)urlStr
{
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}
/** 返回按钮的返回事件 */
-(void)backHomePage:(UIButton *)btn
{
    if(btn.tag == 1000)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        
    }
}

#pragma mark -- 显示和隐藏tabBar
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
