//
//  DJMeViewController.m
//  彩票
//
//  Created by qianfeng on 15/1/7.
//  Copyright © 2015年 LeiYIXu. All rights reserved.
//

#import "DJMeViewController.h"

@interface DJMeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *longInBtn;

@end

@implementation DJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    /**
     *  登录按钮
     */
    [self ImageBtn];
}
/**
 *  登录按钮
 */
-(void)ImageBtn
{
    UIImage *image = [UIImage imageNamed:@"RedButton"];
    
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height *0.5;
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeStretch];
    [self.longInBtn setBackgroundImage:newImage forState:UIControlStateNormal];
    
    UIImage * selImage = [UIImage imageNamed:@"RedButtonPressed"];
    
    CGFloat selImageW = selImage.size.width * 0.5;
    CGFloat selImageH = selImage.size.height * 0.5;
    UIImage *newSelImage = [selImage resizableImageWithCapInsets:UIEdgeInsetsMake(selImageH, selImageW, selImageH, selImageW) resizingMode:UIImageResizingModeStretch];
    [self.longInBtn setBackgroundImage:newSelImage forState:UIControlStateHighlighted];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
