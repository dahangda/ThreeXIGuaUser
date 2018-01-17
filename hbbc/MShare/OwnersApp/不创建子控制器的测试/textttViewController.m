//
//  textttViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/19.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "textttViewController.h"
#import "SGTopTitleView.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"
#import "AssignToObject.h"
#import "MJRefresh.h"

@interface textttViewController ()<SGTopTitleViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)UITableView *bTableView;
@property (nonatomic,strong)UITableView *cTableView;
@property (nonatomic,strong)UITableView *dTableView;
@property (nonatomic,strong)NSArray *aorderArr;
@property (nonatomic,strong)NSArray *amodelArr;
@property (nonatomic,strong)NSArray *borderArr;
@property (nonatomic,strong)NSArray *bmodelArr;
@property (nonatomic,strong)NSArray *corderArr;
@property (nonatomic,strong)NSArray *cmodelArr;
@property (nonatomic,strong)NSArray *dorderArr;
@property (nonatomic,strong)NSArray *dmodelArr;
@property(nonatomic,strong)SGTopTitleView *topTitleView;
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)NSArray *titleArr;

@end

@implementation textttViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIButton *btnLeft =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [btnLeft setImage:[UIImage imageNamed:@"sharenavigation_back"] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btnLeft];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    _titleArr = @[@"全部",@"预定",@"未完成",@"已完成"];
    [self setupChildViewController];
    _topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 36)];
    _topTitleView.scrollTitleArr = [NSArray arrayWithArray:_titleArr];
    _topTitleView.titleAndIndicatorColor = UIColorFromRGB(0xE3383B);
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
 
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
    [self ajson];
    [self bjson];
    [self cjson];
    [self djson];
    
}
-(void)ajson
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:MYORDERS success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        self.aorderArr = [responseBody objectForKey:@"OrderList"];
        self.amodelArr = [AssignToObject customModel:@"MyOrderModel" ToArray:_aorderArr];
        [_aTableView reloadData];
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

-(void)bjson
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:PendingpayORDERS success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        self.borderArr = [responseBody objectForKey:@"OrderList"];
        self.bmodelArr = [AssignToObject customModel:@"MyOrderModel" ToArray:_borderArr];
        [_bTableView reloadData];
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

-(void)cjson
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:NotDoneORDERS success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        self.corderArr = [responseBody objectForKey:@"OrderList"];
        self.cmodelArr = [AssignToObject customModel:@"MyOrderModel" ToArray:_corderArr];
        [_cTableView reloadData];
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

-(void)djson
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:CompletedORDERS success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        self.dorderArr = [responseBody objectForKey:@"OrderList"];
        self.dmodelArr = [AssignToObject customModel:@"MyOrderModel" ToArray:_dorderArr];
        [_dTableView reloadData];
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

-(NSArray *)aorderArr
{
    if (!_aorderArr)
    {
        _aorderArr = [NSArray array];
    }
    return _aorderArr;
}

-(NSArray *)amodelArr
{
    if (!_amodelArr)
    {
        _amodelArr = [NSArray array];
    }
    return _amodelArr;
}

-(UITableView *)aTableView
{
    if(!_aTableView)
    {
        _aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 0, 0) style:UITableViewStylePlain];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
        [_aTableView registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
        [_aTableView setSeparatorInset:UIEdgeInsetsZero];
        [_aTableView setLayoutMargins:UIEdgeInsetsZero];
        _aTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self performSelector:@selector(refreshCell) withObject:nil afterDelay:0];
        }];
        [_aTableView.mj_header beginRefreshing];
        _aTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_aTableView];
        [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(64 + 50);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(SCREEN_HEIGHT - 64 - 50);
        }];
    }
    return _aTableView;
}

-(NSArray *)borderArr
{
    if (!_borderArr)
    {
        _borderArr = [NSArray array];
    }
    return _borderArr;
}

-(NSArray *)bmodelArr
{
    if (!_bmodelArr)
    {
        _bmodelArr = [NSArray array];
    }
    return _bmodelArr;
}

-(UITableView *)bTableView
{
    if(!_bTableView)
    {
        _bTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 0, 0) style:UITableViewStylePlain];
        _bTableView.delegate = self;
        _bTableView.dataSource = self;
        [_bTableView registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
        [_bTableView setSeparatorInset:UIEdgeInsetsZero];
        [_bTableView setLayoutMargins:UIEdgeInsetsZero];
        _bTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self performSelector:@selector(refreshCell) withObject:nil afterDelay:0];
        }];
        [_bTableView.mj_header beginRefreshing];
        _bTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_bTableView];
        [_bTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(64 + 50);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(SCREEN_HEIGHT - 64 - 50);
        }];
    }
    return _bTableView;
}


-(NSArray *)corderArr
{
    if (!_corderArr)
    {
        _corderArr = [NSArray array];
    }
    return _corderArr;
}

-(NSArray *)cmodelArr
{
    if (!_cmodelArr)
    {
        _cmodelArr = [NSArray array];
    }
    return _cmodelArr;
}

-(UITableView *)cTableView
{
    if(!_cTableView)
    {
        _cTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 0, 0) style:UITableViewStylePlain];
        _cTableView.delegate = self;
        _cTableView.dataSource = self;
        [_cTableView registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
        [_cTableView setSeparatorInset:UIEdgeInsetsZero];
        [_cTableView setLayoutMargins:UIEdgeInsetsZero];
        _cTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self performSelector:@selector(refreshCell) withObject:nil afterDelay:0];
        }];
        [_cTableView.mj_header beginRefreshing];
        _cTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_cTableView];
        [_cTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(64 + 50);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(SCREEN_HEIGHT - 64 - 50);
        }];
    }
    return _cTableView;
}

-(NSArray *)dorderArr
{
    if (!_dorderArr)
    {
        _dorderArr = [NSArray array];
    }
    return _dorderArr;
}

-(NSArray *)dmodelArr
{
    if (!_dmodelArr)
    {
        _dmodelArr = [NSArray array];
    }
    return _dmodelArr;
}

-(UITableView *)dTableView
{
    if(!_dTableView)
    {
        _dTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 0, 0) style:UITableViewStylePlain];
        _dTableView.delegate = self;
        _dTableView.dataSource = self;
        [_dTableView registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
        [_dTableView setSeparatorInset:UIEdgeInsetsZero];
        [_dTableView setLayoutMargins:UIEdgeInsetsZero];
        _dTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self performSelector:@selector(refreshCell) withObject:nil afterDelay:0];
        }];
        [_dTableView.mj_header beginRefreshing];
        _dTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_dTableView];
        [_dTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(64 + 50);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(SCREEN_HEIGHT - 64 - 50);
        }];
    }
    return _dTableView;
}

-(void)refreshCell
{
    //    [self json];
    [_aTableView.mj_header endRefreshing];
    [_bTableView.mj_header endRefreshing];
    [_cTableView.mj_header endRefreshing];
    [_dTableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_aTableView])
    {
        return _aorderArr.count;
    }
    else if ([tableView isEqual:_bTableView])
    {
        return _borderArr.count;
    }
    else if ([tableView isEqual:_cTableView])
    {
        return _corderArr.count;
    }
    else if ([tableView isEqual:_dTableView])
    {
        return _dorderArr.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSArray *itemNumberArr = @[@"23665595",@"12663498",@"54577248",@"64554245",@"23665593",@"12355632",@"89789664"];
    //    NSArray *nameArr = @[@"李甜甜",@"刘凯",@"刘金宝",@"张萌",@"冯海海",@"马云",@"萧炎"];
    //    NSArray *phoneArr = @[@"15156568953",@"15675867556",@"13286869438",@"15126597863",@"15846849956",@"15744583396",@"1789892530"];
    MyOrderTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([tableView isEqual:_aTableView])
    {
        [cell setValues:_amodelArr[indexPath.row]];
    }
    else if ([tableView isEqual:_bTableView])
    {
        [cell setValues:_bmodelArr[indexPath.row]];
    }
    else if ([tableView isEqual:_cTableView])
    {
        [cell setValues:_cmodelArr[indexPath.row]];
    }
    else if ([tableView isEqual:_dTableView])
    {
        [cell setValues:_dmodelArr[indexPath.row]];
    }
    
    //    cell.itemNumber.text = itemNumberArr[indexPath.row];
    //    cell.orderNumber.text = itemNumberArr[indexPath.row];
    //    cell.name.text = nameArr[indexPath.row];
    //    cell.phone.text = phoneArr[indexPath.row];
    //    cell.orderTime.text = @"2017-10-5";
    //    NSArray *arr = @[@"定金已支付",@"定金已支付",@"支付失败",@"支付失败",@"支付失败",@"已支付",@"已支付"];
    //    if ([tableView isEqual:_aTableView])
    //    {
    //        cell.orderState.text = arr[indexPath.row];
    //        if ([arr[indexPath.row] isEqualToString:@"定金已支付"])
    //        {
    //            cell.rightImg.backgroundColor = RGB(252, 102, 33);
    //        }
    //        else if([arr[indexPath.row] isEqualToString:@"已支付"])
    //        {
    //            cell.rightImg.backgroundColor = RGBCOLOR(58, 200, 39);
    //        }
    //        else
    //        {
    //            cell.rightImg.backgroundColor = [UIColor redColor];
    //        }
    //    }
    //    else if ([tableView isEqual:_bTableView])
    //    {
    //        cell.orderState.text = @"定金已支付";
    //        cell.rightImg.backgroundColor = RGB(252, 102, 33);
    //    }
    //    else if ([tableView isEqual:_cTableView])
    //    {
    //        cell.orderState.text = @"支付失败";
    //        cell.rightImg.backgroundColor = [UIColor redColor];
    //    }
    //    else
    //    {
    //        cell.orderState.text = @"已支付";
    //        cell.rightImg.backgroundColor = RGBCOLOR(58, 200, 39);
    //    }
    //    cell.imgView.image = [UIImage imageNamed:@"share0"];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}
#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index {
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}
#pragma mark - 添加所有子控制器
- (void)setupChildViewController {
    for (NSInteger i = 0; i < _titleArr.count; i++)
    {
        UIViewController *vc = [UIViewController new];
        vc.title = _titleArr[i];
        
        switch (i) {
            case 0:
                [vc.view addSubview:self.aTableView];
                vc.view.backgroundColor = [UIColor redColor];
                break;
            case 1:
                [vc.view addSubview:self.bTableView];
                vc.view.backgroundColor = [UIColor blueColor];
                break;
            case 2:
                [vc.view addSubview:self.cTableView];
                vc.view.backgroundColor = [UIColor redColor];
                break;
            case 3:
                [vc.view addSubview:self.dTableView];
                break;
            default:
                break;
        }
        
//        vc.view.backgroundColor = [UIColor whiteColor];
        [self addChildViewController:vc];
    }
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

#pragma  mark 返回
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
