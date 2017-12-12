//
//  RechargeBillViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/12/5.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "RechargeBillViewController.h"
#import "ThebillModel.h"
#import "TheBillTableViewCell.h"
#import "AssignToObject.h"
#import "MJRefresh.h"

@interface RechargeBillViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)NSArray *aorderArr;
@property (nonatomic,strong)NSArray *amodelArr;

@end

@implementation RechargeBillViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self ajson];
}

-(void)ajson
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:LookRechargeBill success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        [self.aTableView.mj_header endRefreshing];
        self.aorderArr = responseBody[@"BillSet"];
        self.amodelArr = [AssignToObject customModel:@"ThebillModel" ToArray:_aorderArr];
        [self.aTableView reloadData];
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

-(UITableView *)aTableView
{
    if(!_aTableView)
    {
        _aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 0, 0) style:UITableViewStylePlain];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
        [_aTableView registerClass:[TheBillTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
        [_aTableView setSeparatorInset:UIEdgeInsetsZero];
        [_aTableView setLayoutMargins:UIEdgeInsetsZero];
        _aTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _aTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self performSelector:@selector(refreshCell) withObject:nil afterDelay:0];
        }];
        [_aTableView.mj_header beginRefreshing];
        [self.view addSubview:_aTableView];
        [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(64 + 36);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(SCREEN_HEIGHT - 64 - 36);
        }];
    }
    return _aTableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _amodelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheBillTableViewCell  *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setValue:_amodelArr[indexPath.row]];
    return  cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}



-(void)refreshCell
{
    [self ajson];
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
