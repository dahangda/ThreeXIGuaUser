                                 //
//  GoodsDetailViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/11/10.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsOrderPayViewController.h"

@interface GoodsDetailViewController ()<UIScrollViewDelegate>
{
    CGFloat textViewHeight;
    CGFloat keyWordHeight;
    CGFloat scrollViewHeight;
}

@property (nonatomic, strong) UIScrollView *bigScrollView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic,strong)NSArray *photos;
@property (nonatomic,assign)int page;
@property (nonatomic,strong)UILabel *pageLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong)UILabel *topLabel;
@property (nonatomic,strong)UILabel *introLabel;
@property (nonatomic,strong)UIImageView *lineView;
@property (nonatomic,strong)UIImageView *leftImgView;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *liveState;
@property (nonatomic,strong)NSString *keywordString;
@property (nonatomic,strong)NSMutableArray *keywordArr;
@property (nonatomic,strong)NSMutableArray *kindArr;
@property (nonatomic,strong)NSMutableArray *rightArr;
@property (nonatomic,strong)UILabel *llabel;
@property (nonatomic,strong)UILabel *rlabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,copy)NSString *money;



@end

@implementation GoodsDetailViewController

//懒加载scrollView
- (UIScrollView *)bigScrollView
{
    if (_bigScrollView == nil)
    {
        _bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        [self.view addSubview:_bigScrollView];
        
        _bigScrollView.bounces = YES;
        _bigScrollView.showsVerticalScrollIndicator = NO;
        _bigScrollView.showsHorizontalScrollIndicator = NO;
        _bigScrollView.backgroundColor = RGBCOLOR(233, 233, 234);
        _bigScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    }
    return _bigScrollView;
}
//懒加载scrollView
- (UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        [self.bigScrollView addSubview:_scrollView];
        
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        
        _scrollView.delegate = self;
        
        _scrollView.contentSize = CGSizeMake(_photos.count * SCREEN_WIDTH, 0);
    }
    return _scrollView;
}
//懒加载pageControl
- (UIPageControl *)pageControl
{
    if (_pageControl == nil)
    {
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.numberOfPages = _photos.count;
        
        CGSize size = [_pageControl sizeForNumberOfPages:_photos.count];
        
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.view.center.x, 190);
        //当前页的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        //其余页的颜色
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
        [self.bigScrollView addSubview:_pageControl];
        
        [_pageControl addTarget:self action:@selector(pagechanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

-(NSMutableArray *)kindArr
{
    if (!_kindArr)
    {
        _kindArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _kindArr;
}

-(NSMutableArray *)rightArr
{
    if (!_rightArr)
    {
        _rightArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _rightArr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"公寓预定";
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initUI];
    
    [self setupTimer];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI
{
    _photos = _resPonsbody[@"PicList"];
    //设置scrollView中图片
    for (int i = 0; i < _photos.count; i++)
    {
     
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollView.frame];
        
        [imageView sd_setImageWithURL:_photos[i] placeholderImage:[UIImage imageNamed:@"MD_picture_broken_link_128px_1074947_easyicon.net"]];
        
        [self.scrollView addSubview:imageView];
    }
    //设置每个imageView的位置
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger index, BOOL * _Nonnull stop) {
        CGRect frame = imageView.frame;
        frame.origin.x = index * frame.size.width;
        imageView.frame = frame;
    }];
    
    self.pageControl.currentPage = 0;
    
    UIImageView *pageView = [[UIImageView alloc]init];
    pageView.backgroundColor = [UIColor blackColor];
    pageView.layer.cornerRadius = 8;
    [_bigScrollView addSubview:pageView];
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH - 40);
        make.top.equalTo(175);
        make.height.equalTo(20);
        make.width.equalTo(30);
    }];
    
    _pageLabel = [[UILabel alloc]init];
    _pageLabel.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)_photos.count];
    _pageLabel.textColor = [UIColor whiteColor];
    [pageView addSubview:_pageLabel];
    [_pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _introLabel = [[UILabel alloc]init];
    _introLabel.backgroundColor = [UIColor whiteColor];
    _introLabel.textColor = [UIColor blackColor];
    _introLabel.numberOfLines = 0;
    if ([_resPonsbody[@"GoodsIntroduceText"] isEqualToString:@""])
    {
        _introLabel.text = @"物品简介:";
    }
    else
    {
        _introLabel.text = [NSString stringWithFormat:@"物品简介:%@",_resPonsbody[@"GoodsIntroduceText"]];
    }
    _introLabel.font = [UIFont systemFontOfSize:12];
    [_bigScrollView addSubview:_introLabel];
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.bottom).offset(10);
       
        make.height.equalTo(40);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    textViewHeight = [ self heightFromString:_introLabel.text withFont:[UIFont systemFontOfSize:17.0] constraintToWidth:SCREEN_WIDTH - 50];
   //第一个线
    _lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = [UIColor whiteColor];
    [_bigScrollView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(40);
        make.top.equalTo(_introLabel.bottom).offset(10);
    }];
    
    _leftImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redMoney.png"]];
    [_lineView addSubview:_leftImgView];
    [_leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.height.width.equalTo(13);
        make.centerY.equalTo(_lineView.centerY);
    }];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.text = [NSString stringWithFormat:@"%@",_resPonsbody[@"GoodsDeposit"]];
    _priceLabel.font = [UIFont systemFontOfSize:22];
    _priceLabel.textColor = [UIColor redColor];
    [_bigScrollView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftImgView.mas_centerY);
        make.left.equalTo(_leftImgView.right);
    }];
    
    UILabel *priceDanwei = [[UILabel alloc]init];
    priceDanwei.text = @"元/天";
    [_bigScrollView addSubview:priceDanwei];
    [priceDanwei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftImgView.mas_centerY);
        make.left.equalTo(_priceLabel.right);
    }];
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.text = @"今日可住";
    rightLabel.font = [UIFont systemFontOfSize:22];
    rightLabel.textColor = RGBCOLOR(23, 150, 82);
    [_bigScrollView addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftImgView.mas_centerY);
        make.left.equalTo(SCREEN_WIDTH/2 + 40);
    }];
    
    UIImageView *rightImgView = [[UIImageView alloc]init];
    rightImgView.image = [UIImage imageNamed:@"duihao"];
    [_bigScrollView addSubview:rightImgView];
    [rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightLabel.left);
        make.centerY.equalTo(_leftImgView.mas_centerY);
        make.width.height.equalTo(13);
    }];
    
 
    
    NSArray *imageArr = @[@"caise1",@"caise2",@"caise3",@"caise4",@"caise5",@"caise6",@"caise1"];
    _keywordString = _resPonsbody[@"LabelContent"];
    NSArray *keyArray = [_keywordString componentsSeparatedByString:@";"];
    _keywordArr = [NSMutableArray arrayWithArray:keyArray];
    [_keywordArr removeLastObject];
    
    _lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = [UIColor whiteColor];
    [_bigScrollView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(40);
        make.top.equalTo(_leftImgView.bottom).offset(20);
    }];
    
   UIImageView *lineView1 = [[UIImageView alloc]init];
    lineView1.backgroundColor = [UIColor whiteColor];
    [_bigScrollView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(40);
        make.top.equalTo(_lineView.bottom).offset(10);
    }];
    
    UIImageView *lineView2 = [[UIImageView alloc]init];
    lineView2.backgroundColor = [UIColor whiteColor];
    [_bigScrollView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(40);
        make.top.equalTo(lineView1.bottom).offset(10);
    }];
    
    for (int i = 0; i < _keywordArr.count; i++)
    {
        NSArray *dd = [_keywordArr[i] componentsSeparatedByString:@","];
        [self.kindArr addObject:dd[0]];
        [self.rightArr addObject:dd[1]];
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:imageArr[i]];
        [_bigScrollView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lineView.top).offset(10+ i / 2 * 50);
            make.left.equalTo(10 + i % 2 * (SCREEN_WIDTH/2+10));
            make.width.height.equalTo(15);
        }];
        
        _llabel = [[UILabel alloc]init];
        _llabel.text = [_kindArr[i] stringByAppendingString:@":"];
        _llabel.textColor = RGBCOLOR(73, 73, 73);
        [_bigScrollView addSubview:_llabel];
        [_llabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imgView.mas_centerY);
            make.left.equalTo(imgView.right);
        }];
        
        _rlabel = [[UILabel alloc]init];
        _rlabel.text = _rightArr[i];
        _rlabel.textColor = RGBCOLOR(73, 73, 73);
        [_bigScrollView addSubview:_rlabel];
        [_rlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imgView.mas_centerY);
            make.left.equalTo(_llabel.right).offset(5);
        }];
    }
    
    _lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = [UIColor whiteColor];
    [_bigScrollView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(80);
        make.top.equalTo(_rlabel.bottom).offset(15);
    }];
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.text = [@"地址:" stringByAppendingString:_addr];
    _addressLabel.numberOfLines = 0;
    _addressLabel.font =[UIFont systemFontOfSize:16];
    [_bigScrollView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.width.equalTo(SCREEN_WIDTH - 60);
        make.top.equalTo(_lineView.top).offset(15);
    }];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setImage:[UIImage imageNamed:@"lookPath"] forState:UIControlStateNormal];
    [self.view addSubview:_leftBtn];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.right.equalTo( -SCREEN_WIDTH / 2 - 10);
        make.height.equalTo(50);
        make.bottom.equalTo(-20);
    }];
    [_leftBtn addTarget:self action:@selector(lookPath) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setImage:[UIImage imageNamed:@"theorderBtn"] forState:UIControlStateNormal];
    [self.view addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-30);
        make.left.equalTo(SCREEN_WIDTH / 2 + 10);
        make.height.equalTo(50);
        make.bottom.equalTo(-20);
    }];
    [_rightBtn addTarget:self action:@selector(gotoOrder) forControlEvents:UIControlEventTouchUpInside];
    
}
//查看路线
-(void)lookPath
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getTheSNID" object:_carNumber];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)gotoOrder
{
    GoodsOrderPayViewController *gopc = [[GoodsOrderPayViewController alloc]init];
    gopc.isPlan = YES;
    gopc.responsBody = _resPonsbody;
    gopc.GoodsSNID = _carNumber;
    
    gopc.getMoneyBlock = ^(NSString *money) {
        _money = money;
    };
    if (_money) {
        gopc.money = _money;
    }
    else
    {
    NSString *GoodsDeposit = [NSString stringWithFormat:@"%@",_resPonsbody[@"GoodsDeposit"]];
    NSString *GoodsUsePrice = [NSString stringWithFormat:@"%@",_resPonsbody[@"GoodsUsePrice"]];
    double money = [GoodsDeposit doubleValue] + [GoodsUsePrice doubleValue];
    gopc.money = [NSString stringWithFormat:@"%.2f",money];
    }
    [self.navigationController pushViewController:gopc animated:YES];
}

//计算文字高度
-(CGFloat)heightFromString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)width
{
    if (text && font) {
        CGRect rect  = [text boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
        return rect.size.height;
    }
    return 0;
}

#pragma mark - ScrollView的代理方法UIScrollViewDelegate
/**
 * scrollView停止滚动，更新页数
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算页面
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = page;
    _pageLabel.text = [NSString stringWithFormat:@"%d/%lu",page + 1,(unsigned long)_photos.count];
}

/**
 * 初始化定时器
 */
- (void)setupTimer
{
    self.timer = [NSTimer timerWithTimeInterval:3.5 target:self selector:@selector(timerChanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 * 定时器生效，图片自动轮播
 */
- (void)timerChanged
{
    int photos = (int)_photos.count;
    int page = (self.pageControl.currentPage + 1) % photos;
    self.pageControl.currentPage = page;
    _pageLabel.text = [NSString stringWithFormat:@"%d/%lu",page + 1,(unsigned long)_photos.count];
    [self pagechanged:self.pageControl];
}

/**
 * 随pageControl页数改变，调整scrollView视图内容
 */
- (void)pagechanged:(UIPageControl *)pageControl
{   // 根据页数，获得对应位置图片的x坐标
    CGFloat x = (pageControl.currentPage)* self.scrollView.bounds.size.width;
    // 根据坐标的值，调整scrollView的视图内容
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

/**
 * 开始移动scrollView
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器
    [self.timer invalidate];
}

/**
 * 移动scrollView完毕
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
