//
//  DidPayOrdersViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/19.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "DidPayOrdersViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"
#import "AssignToObject.h"
#import "MJRefresh.h"

@interface DidPayOrdersViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *introLabel;
@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)NSArray *aorderArr;
@property (nonatomic,strong)NSArray *amodelArr;

@end

@implementation DidPayOrdersViewController

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
    [[NetworkSingleton shareManager] httpRequest:parameters url:CompletedORDERS success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        [_aTableView.mj_header endRefreshing];
        self.aorderArr = [responseBody objectForKey:@"OrderList"];
        self.amodelArr = [AssignToObject customModel:@"MyOrderModel" ToArray:_aorderArr];
        [self.aTableView reloadData];
        if ([responseBody[@"Notice"] isEqualToString:@"操作成功"])
        {
            self.imageView.hidden = YES;
            self.introLabel.hidden = YES;
        }
        else
        {
            self.imageView.hidden = NO;
            self.introLabel.hidden = NO;
        }
        
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
            make.top.equalTo(64 + 36);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(SCREEN_HEIGHT - 64 - 36);
        }];
    }
    return _aTableView;
}

-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mshare_no_order"]];
        [self.view addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(64 + 36 + 100);
            make.centerX.equalTo(self.view.mas_centerX);
            make.height.width.equalTo(130);
        }];
    }
    return _imageView;
}

-(UILabel *)introLabel
{
    if (!_introLabel)
    {
        _introLabel = [[UILabel alloc]init];
        _introLabel.text = @"您还没有相关的订单";
        [self.view addSubview:_introLabel];
        [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(_imageView.bottom).offset(20);
        }];
    }
    return _introLabel;
}

-(void)refreshCell
{
    [self ajson];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _aorderArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setValues:_amodelArr[indexPath.row]];
    NSString *orderID = [_aorderArr[indexPath.row] objectForKey:@"OrderPayOrderID"];
    __weak typeof (self)weakself = self;
    cell.deleteOrderBlock = ^{
        NSDictionary *parameters = @{
                                     @"ECID":ECID,
                                     @"PhoneNumber":PhoneNum,
                                     @"AppType":@"2",
                                     @"OrderPayOrderID":orderID,
                                     @"AppID":APPID
                                     };
        [[NetworkSingleton shareManager] httpRequest:parameters url:DELETEORDER success:^(id responseBody){
            DHResponseBodyLog(responseBody);
            [weakself ajson];
        } failed:^(NSError *error)
         {
             DHErrorLog(error);
         }];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}

-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
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
