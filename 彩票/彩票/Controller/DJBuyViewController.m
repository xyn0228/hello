//
//  DJBuyViewController.m
//  彩票
//
//  Created by qianfeng on 17/1/5.
//  Copyright © 2017年 LeiYIXu. All rights reserved.
//

#import "DJBuyViewController.h"
#import "DJTitleButton.h"
@interface DJBuyViewController ()

@property(assign,nonatomic,getter=isOpen) BOOL open;

@property(strong , nonatomic) UIView * contrnView;
@end

@implementation DJBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor redColor];
    contentView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:contentView];
    self.contrnView = contentView;
    
    contentView.hidden = YES;
    
}
/**
 *  头部按钮点击事件
 */
- (IBAction)titleBtnOnClick:(DJTitleButton *)sender {
    
    if (!self.isOpen) {
        [UIView animateWithDuration:0.1 animations:^{
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        self.open = YES;
        self.contrnView.hidden = NO;
    }else
    {
    
    [UIView animateWithDuration:0.1 animations:^{
        sender.imageView.transform = CGAffineTransformIdentity;
    }];
        self.open = NO;
        self.contrnView.hidden = YES;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
