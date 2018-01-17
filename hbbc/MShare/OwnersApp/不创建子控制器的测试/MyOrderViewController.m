//
//  MyOrderViewController.m
//  sdsjOwnerApp
//
//  Created by Handbbc on 2017/8/22.
//  Copyright © 2017年 xushaodong. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"
#import "AssignToObject.h"
#import "MJRefresh.h"

@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

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

@end

@implementation MyOrderViewController

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
    [self setUpAllChildViewController];
    [self setUpDisplayStyle:^(UIColor *__autoreleasing *titleScrollViewBgColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIColor *__autoreleasing *proColor, UIFont *__autoreleasing *titleFont, CGFloat *titleButtonWidth, BOOL *isShowPregressView, BOOL *isOpenStretch, BOOL *isOpenShade) {
        *titleFont = [UIFont systemFontOfSize:16];
        *selColor = RGB(66, 165, 234);
        /*
         以下BOOL值默认都为NO
         */
        *isShowPregressView = YES;                      //是否开启标题下部Pregress指示器
        *isOpenStretch = YES;                           //是否开启指示器拉伸效果
        *isOpenShade = YES;                             //是否开启字体渐变
    }];
    [self ajson];
    [self bjson];
    [self cjson];
    [self djson];

}

#pragma mark - 添加所有子控制器
- (void)setUpAllChildViewController
{
    NSArray *titles = @[@"全部",@"预定",@"未完成",@"已完成"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIViewController *vc = [UIViewController new];
        vc.title = titles[i];
        switch (i) {
            case 0:
                [vc.view addSubview:self.aTableView];
                vc.view.backgroundColor = [UIColor yellowColor];
                break;
            case 1:
                [vc.view addSubview:self.bTableView];
                vc.view.backgroundColor = [UIColor greenColor];
                break;
            case 2:
                [vc.view addSubview:self.cTableView];
                break;
            case 3:
//                [vc.view addSubview:self.dTableView];
                vc.view.backgroundColor = [UIColor yellowColor];
                break;
            default:
                break;
        }
//        vc.view.backgroundColor = [UIColor whiteColor];
        [self addChildViewController:vc];
    }
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
    return 60;
}

-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
