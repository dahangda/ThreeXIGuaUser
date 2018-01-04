//
//  MyOrdersViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/19.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "SGTopTitleView.h"
#import "AllOrdersViewController.h"
#import "WaitPayOrdersViewController.h"
#import "DotPayOrdersViewController.h"
#import "DidPayOrdersViewController.h"

@interface MyOrdersViewController ()<SGTopTitleViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)SGTopTitleView *topTitleView;
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)NSArray *titleArr;

@end

@implementation MyOrdersViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    _titleArr = @[@"全部订单",@"预定订单",@"未完成订单",@"已完成订单"];
    [self setupChildViewController];
    _topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 36)];
    _topTitleView.scrollTitleArr = [NSArray arrayWithArray:_titleArr];
    _topTitleView.titleAndIndicatorColor = RGBCOLOR(66, 165, 234);
    _topTitleView.delegate_SG = self;
    [self.view addSubview:_topTitleView];
    
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titleArr.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    AllOrdersViewController *homeVC= [[AllOrdersViewController alloc]init];
    [self.mainScrollView addSubview:homeVC.view];
    [self addChildViewController:homeVC];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
}
#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index {
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

- (void)setupChildViewController {
    //所有订单
    AllOrdersViewController *homeVC = [[AllOrdersViewController alloc] init];
    
    [self addChildViewController:homeVC];
    
    // 待付款订单
    WaitPayOrdersViewController *videoVC = [[WaitPayOrdersViewController alloc] init];
    [self addChildViewController:videoVC];
    
    // 未完成订单
    DotPayOrdersViewController *subjectVC = [[DotPayOrdersViewController alloc] init];
    [self addChildViewController:subjectVC];
    
    //已完成订单
    DidPayOrdersViewController *picVC = [[DidPayOrdersViewController alloc] init];
    [self addChildViewController:picVC];   
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    vc.navigationController.navigationItem.title = _titleArr[index];
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}

#pragma  mark 返回
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    
    [self.topTitleView scrollTitleLabelSelecteded:selLabel];
    // 3.让选中的标题居中
    [self.topTitleView scrollTitleLabelSelectededCenter:selLabel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
