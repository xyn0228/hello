
#import "HeaderView.h"
#import "IndexFirstModel.h"

#define VIEW_BOUNDS self.bounds.size
#define SCROLLVIEW_WIDTH  (_scrollView.frame.size.width)
#define SCROLLVIEW_HEIGHT (_scrollView.frame.size.height)
#define ImageBaseTag 100
#define SwitchBtnTag 200
#define ScrollH SCREEN_WIDTH * 560 / 750
#define Spacing 15
#define SwitchBtnCount 5

@interface HeaderView ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) UIPageControl * pageControl;
@property(nonatomic,strong) UIImageView * imageView;
@end

@implementation HeaderView

#pragma mark - 视图加载

/** 初始化 */
-(instancetype)initWithFrame:(CGRect)frame andWithImageNames:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 初始化加载控件 */
        [self loadHeaderViewWithDataArray:dataArray];
    }
    return self;
}
/** 初始化加载控件 */
-(void)loadHeaderViewWithDataArray:(NSArray *)dataArray
{
    /** 加载scrollView控件 */
    [self loadScrollViewWithDataArray:dataArray];
    [self loadPageControlWithNum:dataArray.count];
    [self loadSwitchBtn];
    [self addTimer];
}

/** 加载scrollView控件 */
-(void)loadScrollViewWithDataArray:(NSArray *)dataArray
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScrollH)];
    _scrollView.contentSize = CGSizeMake(SCROLLVIEW_WIDTH * (dataArray.count + 2), SCROLLVIEW_HEIGHT);
    for (int i = 0; i<dataArray.count + 2; i++) {
        IndexFirstModel * model;
        if(i == 0)
        {
            model = dataArray.lastObject;
        }
        else if (i == dataArray.count + 1)
        {
            model = dataArray.firstObject;
        }
        else
        {
            model = dataArray[i - 1];
        }
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCROLLVIEW_WIDTH * i, 0, SCROLLVIEW_WIDTH, SCROLLVIEW_HEIGHT)];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"loading"]];
        _imageView.userInteractionEnabled = YES;
        _imageView.tag = i + ImageBaseTag;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedImageTap:)];
        [_imageView addGestureRecognizer:tap];
        
        UILabel * titles = [[UILabel alloc] initWithFrame:CGRectMake(0 , SCROLLVIEW_HEIGHT - 40, SCROLLVIEW_WIDTH, 20)];
        titles.text = model.mytitle;
        titles.font = [UIFont systemFontOfSize:14];
        titles.textColor = [UIColor whiteColor];
        titles.textAlignment = NSTextAlignmentCenter;
        
        [_imageView addSubview:titles];
        [_scrollView addSubview:_imageView];
    }
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
    
    [self addSubview:_scrollView];
}

/** 加载pageControl控件 */
-(void)loadPageControlWithNum:(NSInteger)count
{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0 , SCROLLVIEW_HEIGHT - 15, SCROLLVIEW_WIDTH, 5)];
    _pageControl.numberOfPages = count;
    //pageControl被选中的颜色和没有被选中的颜色的设置
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.enabled = NO;
    
    [self addSubview:_pageControl];
}

-(void)loadSwitchBtn
{
    CGFloat btnW = (SCREEN_WIDTH - 6 * Spacing)/SwitchBtnCount;
    CGFloat btnH = 45.f;
    for (int i = 0; i < SwitchBtnCount; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor blueColor];
        btn.frame = CGRectMake( (btnW + Spacing) * i + Spacing , CGRectGetMaxY(_scrollView.frame) + Spacing, btnW, btnH);
        [btn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = SwitchBtnTag + i;
        [self addSubview:btn];
        
    }
}

/** 添加定时器 */
-(void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

#pragma mark - 触发事件

/** 跳转到下一张图 */
-(void)nextImage
{
    CGFloat x = _scrollView.contentOffset.x;
    [_scrollView setContentOffset:CGPointMake(x + SCROLLVIEW_WIDTH, 0) animated:YES];
}

/** 移除计时器 */
-(void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
    
}
#pragma mark -- 实现协议

/** 图片手势点击事件 */
-(void)selectedImageTap:(UITapGestureRecognizer *)tap
{
    if([self.delegate respondsToSelector:@selector(headerView:didSelectImageView:)])
    {
        [self.delegate headerView:self didSelectImageView:tap.view.tag];
    }
}

-(void)switchBtnClick:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(headerView:didSelectSwitchBtn:)])
    {
        [self.delegate headerView:self didSelectSwitchBtn:btn.tag];
    }
}

#pragma mark - 滚动视图的协议方法

/** 当有动画执行时调用该方法 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewJudge:scrollView];
}

/** 当手指离开滚动视图上的操作 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addTimer];
    [self scrollViewJudge:scrollView];
}

/** 滚动页数判断 */
-(void)scrollViewJudge:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / SCROLLVIEW_WIDTH;
    if(page == _pageControl.numberOfPages + 1)
    {
        [_scrollView setContentOffset:CGPointMake(SCROLLVIEW_WIDTH, 0) animated:NO];
        _pageControl.currentPage = 0;
    }
    else if(page == 0)
    {
        [_scrollView setContentOffset:CGPointMake(SCROLLVIEW_WIDTH * _pageControl.numberOfPages, 0) animated:NO];
        _pageControl.currentPage = _pageControl.numberOfPages - 1;
    }
    else
    {
        _pageControl.currentPage = page - 1;
    }
}

/** 当手指触到滚动视图上的操作 */
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self removeTimer];
}
@end
