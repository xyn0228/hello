//
//  IndexViewController.m
//  Shopping
//
//  Created by qianfeng on 16/1/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "IndexViewController.h"
#import "QrCodeViewController.h"
#import "HomeOneTableViewCell.h"
#import "IuxuryTableViewCell.h"
#import "DetailWebViewController.h"

#import "MyNavitaionItem.h"
#import "MyNavigationBar.h"
#import "HeaderView.h"
#import "HomePageSearchView.h"
#import "EllipseRectView.h"

#import "IndexFirstModel.h"
#import "IuxuryModel.h"

#import "InterfaceHeader.h"

#import "NSString+StringToDate.h"

/** 二维码按钮的宽 */
#define QrCodeWidth 40
/** tableView头视图的高度 */
#define HeaderH (75 + SCREEN_WIDTH * 560 / 750)
/** cell的间距 */
#define Spacing 6
/** navigation的隐藏 */
#define TabBarAlpha 64 * 0.4


@interface IndexViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,HeaderViewDelegate>
/** 获取全局tabbar */
@property(nonatomic,strong) MyNavigationBar * bar;
/** 主界面tableView */
@property(nonatomic,strong) UITableView * tableView;
/** 主界面tableView数据源 */
@property(nonatomic,strong) NSMutableArray * dataSource;
/** 搜索文本 */
@property(nonatomic,strong) UITextField * searchTextField;
/** 搜索界面 */
@property(nonatomic,strong) HomePageSearchView * searchView;
/** 设置搜索的回弹效果 */
@property(nonatomic,strong) UIScrollView * scrollView;
/** 主界面tableViewCell数据源 */
@property(nonatomic,strong) NSMutableArray * tableViewDataSource;
/** 奢抢惠数据 */
@property(nonatomic,strong) NSMutableArray * iuxuryDataSource;
#warning mark -- 暂时没用到
/** 奢抢惠定时器 */
@property(nonatomic,strong) NSTimer * iuxuryTimer;
#warning mark -- 好像也没用到呢
/** 日期格式 */
@property(nonatomic,strong) NSDateFormatter * dataFormetter;
/**  */
@property(nonatomic,copy) NSString * iuxuryString;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMyNavigationBar];
    [self loadSearchUI];
    [self loadHomePage];
    [self tableView];
}

#pragma mark -- 数据界面懒加载
/** tableView懒加载 */
-(UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, -20, SCREEN_WIDTH, SCREEN_HEIGHT + 20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView registerClass:[HomeOneTableViewCell class] forCellReuseIdentifier:@"indexCell"];
//        [_tableView registerClass:[IuxuryTableViewCell class] forCellReuseIdentifier:@"indexCell"];
        [self.view insertSubview:_tableView atIndex:0];
    }
    return _tableView;
}
/** tableviewCell的懒加载 */
-(NSMutableArray *)tableViewDataSource
{
    if(_tableViewDataSource == nil)
    {
        if(self.dataSource.count == 0 || self.iuxuryDataSource.count == 0) return _tableViewDataSource;
        _tableViewDataSource = [NSMutableArray arrayWithArray:self.dataSource];
        [_tableViewDataSource removeObjectAtIndex:0];
    }
    return _tableViewDataSource;
}
/** tableView数据懒加载 */
-(NSMutableArray *)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
/** 奢抢惠数据懒加载 */
-(NSMutableArray *)iuxuryDataSource
{
    if(_iuxuryDataSource == nil)
    {
        _iuxuryDataSource = [[NSMutableArray alloc] init];
    }
    return _iuxuryDataSource;
}
#pragma mark -- 奢抢惠的定时器
/** 添加定时器 */
-(void)addIuxuryTimer
{
#warning mark -- 方法没实现
    _iuxuryTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(iuxuryChanged:) userInfo:nil repeats:YES];
}
/** 移除计时器 */
-(void)removeTimer
{
    [_iuxuryTimer invalidate];
    _iuxuryTimer = nil;
    
}
/** 视图即将显示添加定时器 */
#warning mark -- 应该是数据请求完成后加载定时器
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addIuxuryTimer];
}
/** 视图已经消失移除定时器 */
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self removeTimer];
}

-(void)iuxuryChanged:(NSTimer *)timer
{
    
}
/** 得到系统时间，以秒计算 */
-(NSDate *)getSysTime
{
    return [NSDate date];
}
/** 得到系统时间，以年月日格式返回 */
//-(NSString *)getSysDate
//{
//    _dataFormetter = [[NSDateFormatter alloc] init];
//    [_dataFormetter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
//    NSDate * date = [NSDate date];
//    return [_dataFormetter stringFromDate:date];
//}

#pragma mark -- 加载UI界面
/** 加载导航 */
-(void)loadMyNavigationBar
{
    MyNavitaionItem *leftItem = [[MyNavitaionItem alloc] init];
    leftItem.itemImageName = @"scaner";
    
    MyNavitaionItem * rightItem = [[MyNavitaionItem alloc] init];
    rightItem.itemImageName = @"img_search";
    
    self.bar = [self createMyNavigationBarWithBgImageName:nil andTitle:@"SECOO" andTitleView:nil andLeftItems:@[leftItem] andRightItems:@[rightItem] andSEL:@selector(btnClick:) andClass:self];
}
/**
 *  加载搜索界面
 */
-(void)loadSearchUI
{
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 20, SCREEN_WIDTH - QrCodeWidth, 44)];
    _searchTextField.backgroundColor = [UIColor whiteColor];
    _searchTextField.placeholder = @"搜索商品和品牌";
    _searchTextField.font = [UIFont systemFontOfSize:15];
    //是否纠错
    _searchTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //再次编辑是否清空
    _searchTextField.clearsOnBeginEditing = NO;
    //首字母是否大写
    _searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    //无输入内容不能搜索
    _searchTextField.enablesReturnKeyAutomatically = YES;
    //添加取消按钮
    EllipseRectView * view = [[EllipseRectView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchCancelBtn:)];
    [view addGestureRecognizer:tap];
    
    _searchTextField.rightView = view;
    _searchTextField.rightViewMode = UITextFieldViewModeAlways;

    [self.view addSubview:_searchTextField];
    //添加搜索下的显示view
    _searchView = [[HomePageSearchView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:_searchView];
}
#pragma mark -- 数据下载
/**
 *  加载主界面数据
 */
-(void)loadHomePage
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadHomePage) name:Index_Message_URL object:nil];
    [[DownLoadManager sharedDownLoadManager] addDownLoadMessageWithRUL:Index_Message_URL andType:Index_Message_URL];
}

/**
 *  完成奢抢惠数据加载并刷新界面
 */
-(void)downLoadIuxuryFinish
{
    self.iuxuryDataSource = [[DownLoadManager sharedDownLoadManager] getDownLoadData:self.iuxuryString];
    [self.tableViewDataSource insertObject:self.iuxuryDataSource.firstObject atIndex:1];
    [self.tableView reloadData];
}
/**
 *  完成主界面数据加载并且刷新界面
 */
-(void)downLoadHomePage
{
    self.dataSource = [[DownLoadManager sharedDownLoadManager] getDownLoadData:Index_Message_URL];
    [self tableViewDataSource];
    [self loadHeaderView];
    [self performSelectorOnMainThread:@selector(loadHeaderView) withObject:nil waitUntilDone:NO];
    
    
    for (NSArray * arr in self.dataSource) {
        for (IndexFirstModel * model in arr) {
            DLog(@"%@----%@----%@-----",model.mytitle,model.pcdate,model.productid);
        }
    }
    
    
    
    /** 加载奢抢惠数据 */
    NSString * dateStr = [[NSString dateStrBySysDate] componentsSeparatedByString:@" "].firstObject;
    self.iuxuryString = [NSString stringWithFormat:Index_Iuxury_URL,dateStr];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadIuxuryFinish) name:self.iuxuryString object:nil];
    [[DownLoadManager sharedDownLoadManager] addDownLoadMessageWithRUL:self.iuxuryString andType:self.iuxuryString];
}

/** tableView头视图 */
-(void)loadHeaderView
{
    HeaderView * header = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeaderH) andWithImageNames:self.dataSource.firstObject];
    self.tableView.tableHeaderView = header;
    header.delegate = self;
}
#pragma mark -- 跳转到下一个界面所需要的公共方法
/** 得到网址并跳转 */
-(void)jumpToOtherControllerWithURLStr:(NSString *)urlStr andTitle:(NSString *)title
{
    DetailWebViewController * vc = [[DetailWebViewController alloc] init];
    vc.urlStr = urlStr;
    if(!([title isEqualToString:@"无标题"]||[title isEqualToString:@""]||title == nil))
    {
        vc.myTitle = title;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
/** 判断哪个字符串不为空，做相应的拼接并返回 */
-(NSString *)getNotNilStrWithModel:(IndexFirstModel *)model
{
    NSString * urlStr;
    if(!(model.pcdate == nil || [model.pcdate isEqualToString:@""]))
    {
        urlStr = [NSString stringWithFormat:Index_Pcdate_URL,model.pcdate];
    }
    else if(!(model.productid == nil || [model.productid isEqualToString:@""]))
    {
        urlStr = [NSString stringWithFormat:Index_Productid_URL,model.productid];
    }
    else if (!(model.flashid == nil||[model.flashid isEqualToString:@""]))
    {
        urlStr = [NSString stringWithFormat:Index_Flashid_URL,model.flashid];
    }
    return urlStr;
}

#pragma mark -- headerView代理
/** 头视图滚动图片的点击事件 */
-(void)headerView:(HeaderView *)headerView didSelectImageView:(NSInteger)selectedImageView
{   //拼接网址并跳转界面
    IndexFirstModel * model = self.dataSource.firstObject[selectedImageView - 101];
    NSString * urlStr = [self getNotNilStrWithModel:model];
    [self jumpToOtherControllerWithURLStr:urlStr andTitle:model.mytitle];
    
//    NSDateFormatter * f = [[NSDateFormatter alloc] init];
//    f.dateFormat = @"";
//    NSDate * lastDate = [f dateFromString:@""];
//    
//    NSDate * date = [NSDate date];
//    NSTimeInterval inter = [date timeIntervalSinceDate:lastDate];
    
}

-(void)headerView:(HeaderView *)headerView didSelectSwitchBtn:(NSInteger)switchBtnIndex
{
    NSArray * arr = @[@"http://iphone.secoo.com/appActivity/20151102_new.shtml",
                      @"http://iphone.secoo.com/staticpages/hwzy.html",
                      @"http://iphone.secoo.com/appActivity/app_auction_index.shtml",
                      @"http://iphone.secoo.com/iphone4.1.4/view/flash_purchase_list.html",
                      @"http://iphone.secoo.com/appActivity/app_1217zcyl_s.shtml"];
    NSArray * titleArr = @[@"玩转新品",@"海外直邮",@"拍卖",@"闪购",@"新客专享"];
    [self jumpToOtherControllerWithURLStr:arr[switchBtnIndex - 200] andTitle:titleArr[switchBtnIndex - 200]];
}
#pragma mark -- tableView代理
/** cell的个数 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewDataSource.count;
}
/** cell的内容加载 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeOneTableViewCell * cell = [[HomeOneTableViewCell alloc] init];
    IuxuryTableViewCell * iuxuCell = [[IuxuryTableViewCell alloc] init];
    NSArray * arr = self.tableViewDataSource[indexPath.row];
    if(indexPath.row == 1)
    {
        [iuxuCell createIuxuryCellWithData:self.tableViewDataSource[1]];
        iuxuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return iuxuCell;
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell createTableViewCellWithDataSourceArr:arr];
        __weak typeof(self) weakSelf = self;
        //block回传数据处理
        void(^cellBlock)(NSInteger) = ^(NSInteger index){
            if((arr.count == 4 ||arr.count == 5)&&(index == 300 || index == 301))
            {
                IndexFirstModel * model = arr[0];
                [weakSelf jumpToOtherControllerWithURLStr:[weakSelf getNotNilStrWithModel:model] andTitle:model.mytitle];
            }
            else
            {
                IndexFirstModel * model = arr[index - 300];
                [weakSelf jumpToOtherControllerWithURLStr:[weakSelf getNotNilStrWithModel:model] andTitle:model.mytitle];
            }
        };
        cell.block = cellBlock;
    }
    return cell;
}
/** cell高度设置 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = self.tableViewDataSource[indexPath.row];
    CGFloat hight;
    if(indexPath.row == 1)
    {
        hight = 180.f;
    }
    else
    {
        switch (array.count) {
            case 1:
                hight =SCREEN_WIDTH * 350 / 750 + Spacing;
                break;
            case 2:
                hight =(SCREEN_WIDTH - Spacing) * 0.5 * 470 / 370 + Spacing;
                break;
            case 4:
                hight = SCREEN_WIDTH * 70 / 750 + SCREEN_WIDTH * 330 / 750 +(SCREEN_WIDTH - Spacing) * 230 / 370 + Spacing;
                break;
            case 5:
                hight = SCREEN_WIDTH * 493 / 750+ SCREEN_WIDTH /3 + Spacing;
                break;
            default:
                break;
        }
    }
    return hight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1)
    {
        [self jumpToOtherControllerWithURLStr:@"http://iphone.secoo.com/appActivitys/appActivity/sqh_list.shtml" andTitle:@"奢抢惠"];
    }
}

#pragma mark -- scrollView代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /** tableView滑动时navigation的隐藏或显示 */
    if([scrollView isEqual:self.tableView])
    {
        CGFloat yOffset = self.tableView.contentOffset.y;
        CGFloat destince = yOffset / TabBarAlpha;
        if(destince <= 1)
        {
            self.bar.alpha = destince;
        }
        else if(destince > 1)
        {
            self.bar.alpha = 1.0;
        }
    }
#warning mark -- 滑动事件
    /** 热搜的scrollView的滑动事件 */
    else
    {
        [_searchTextField resignFirstResponder];
        self.tabBarController.tabBar.hidden = NO;
    }
}

#pragma mark -- tabbar按钮点击
/** navigationBar按钮点击方法 */
-(void)btnClick:(UIButton *) btn
{
    //左按钮--二维码
    if(btn.tag == 1000)
    {
        [self qrCodeBtnClick];
    }
    //右按钮--搜索
    else
    {
        [self searchBtnClick];
    }
}
/**
 *  左按钮点击事件
 */
-(void)qrCodeBtnClick
{
    QrCodeViewController * vc = [[QrCodeViewController alloc] init];
    vc.QrCodeSuncessBlock = ^(QrCodeViewController * qvc,NSString * successStr)
    {
        NSLog(@"%@",successStr);
        [qvc dismissViewControllerAnimated:YES completion:nil];
    };
    vc.QrCodeFailBlock = ^(QrCodeViewController * qvc)
    {
#warning mark -- 扫描失败要进行的操作
        NSLog(@"FILE");
        [qvc dismissViewControllerAnimated:YES completion:nil];
    };
    /** 取消扫描调用 */
    vc.QrCodeCancleBlock = ^(QrCodeViewController * qvc)
    {
        [qvc dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:vc animated:YES completion:nil];

}
/**
 *  右按钮点击事件
 */
-(void)searchBtnClick
{
    CGRect searchFeild = CGRectMake( QrCodeWidth, 20, SCREEN_WIDTH - QrCodeWidth, 44);
    CGRect searchView = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    [UIView animateWithDuration:0.2 animations:^{
        _searchTextField.frame = searchFeild;
        _searchView.frame = searchView;
    }];
    [_searchTextField becomeFirstResponder];

    self.tabBarController.tabBar.hidden = YES;
    self.bar.alpha = 1.0;
}
/**
 *  取消搜索，回到主界面
 */
-(void)searchCancelBtn:(UITapGestureRecognizer *)tap
{
    CGRect searchFeild = CGRectMake( SCREEN_WIDTH, 20, SCREEN_WIDTH - QrCodeWidth, 44);
    CGRect searchView = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    [UIView animateWithDuration:0.2 animations:^{
        _searchTextField.frame = searchFeild;
        _searchView.frame = searchView;
    }];
    _searchTextField.text = @"";
    [_searchTextField resignFirstResponder];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
