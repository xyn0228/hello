//
//  HomePageSearchView.m
//  Shopping
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "HomePageSearchView.h"
#import "DownLoadManager.h"
#import "InterfaceHeader.h"

/** 二维码按钮的宽度 */
#define QrCodeWidth 40
/** 按钮的tag值 */
#define BaseTag 400

@interface HomePageSearchView()<UIScrollViewDelegate>


@property(nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation HomePageSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        _dataArr = [[NSMutableArray alloc] init];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)setUpUI
{
    //设置scrollView实现回弹效果
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 1)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    //添加View上的显示信息
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(QrCodeWidth, 10, self.frame.size.width - QrCodeWidth, 20)];
    label.text = @"热门搜索";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:17];
    [_scrollView addSubview:label];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadFinish) name:Index_Search_URL object:nil];
    [[DownLoadManager sharedDownLoadManager] addDownLoadMessageWithRUL:Index_Search_URL andType:Index_Search_URL];
}

-(void)downLoadFinish
{
    self.dataArr = [[DownLoadManager sharedDownLoadManager] getDownLoadData:Index_Search_URL];
    //添加热门搜索按钮
    CGFloat spacing = 15.f;
    for (int i = 0; i < self.dataArr.count; i++) {
        int x = i / 3;
        int y = i % 3;
        CGFloat btnW = (SCREEN_WIDTH - 2 * (QrCodeWidth + spacing)) / 3;
        CGFloat btnH = 30;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(QrCodeWidth + (spacing + btnW) * y, 30 + (spacing + btnH) * x + 10 , btnW, btnH);
        btn.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.95f alpha:1.00f];
        [btn setTitle:self.dataArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = BaseTag + i;
        [self.scrollView addSubview:btn];
    }

}

-(void)searchBtnClick:(UIButton *)btn
{
    DLog(@"%d",btn.tag);
}
@end
