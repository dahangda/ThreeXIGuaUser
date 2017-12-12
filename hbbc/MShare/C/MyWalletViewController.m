//
//  MyWalletViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/11.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MyWalletModel.h"
#import "MyWalletTableViewCell.h"
#import "UserInforViewController.h"
//#import "MyBillViewController.h"
#import "TheBillViewController.h"
#import "RechargeViewController.h"
#import "CashViewController.h"
#import "GetChargeViewController.h"

@interface MyWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

//用户名
@property (nonatomic,strong)NSString *myName;
//余额
@property (nonatomic,strong)NSString *balance;
//押金
@property (nonatomic,strong)NSString *depositBalance;


@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)UITableViewCell *acell;
@property (nonatomic,strong)UIButton *imgBtn;
@property (nonatomic,assign)NSArray *imgArray;
@property (nonatomic,assign)NSArray *labelArray;
@property(nonatomic,strong)NSMutableArray *arr;


@end

@implementation MyWalletViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self json];
    
}

-(void)json
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:MYWALLET success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        _nameLabel.text = responseBody[@"UserName"];
        _balance = [NSString stringWithFormat:@"%@",responseBody[@"UserBalance"]];
        MyWalletTableViewCell *cell = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.rightLabel.text = [_balance stringByAppendingString:@"元"];
        _depositBalance = [NSString stringWithFormat:@"%@",responseBody[@"DepositBalance"]];
        
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

-(void)initUI
{
    _labelArray = [NSArray arrayWithObjects:@"账单",@"余额",@"充值",@"提现",@"退还押金",nil];
    _imgArray = [NSArray arrayWithObjects:@"账单",@"余额",@"充值",@"提现",@"退押金",nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _aTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _aTableView.dataSource = self;
    _aTableView.delegate = self;
    _aTableView.scrollEnabled = NO;
    [_aTableView setSeparatorInset:UIEdgeInsetsZero];
    [_aTableView setLayoutMargins:UIEdgeInsetsZero];
    [_aTableView registerClass:[MyWalletTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    headerView.backgroundColor = RGBCOLOR(92, 177, 236);
    
    
    _aTableView.tableHeaderView = headerView;
    
    [self.view addSubview:_aTableView];
    [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(400);
    }];
    
    for (int i = 0; i < 5; i++)
    {
        MyWalletModel *userModel = [[MyWalletModel alloc]initWithLeftImg:_imgArray[i] andLeftLabel:_labelArray[i]];
        [self.arr addObject:userModel];
    }
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"我的钱包";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(30);
    }];
    
    _imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imgBtn setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    [self.view addSubview:_imgBtn];
    [_imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(titleLabel.bottom).offset(30);
        make.width.height.equalTo(84);
    }];
    _imgBtn.layer.cornerRadius = 42;
    _imgBtn.layer.masksToBounds = YES;
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"***";
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgBtn.right).offset(15);
        make.top.equalTo(_imgBtn.top).offset(20);
    }];
    
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    NSString *phoneNum = PhoneNum;
    if ([phoneNum isEqualToString:@""] || phoneNum == nil)
    {
        phoneLabel.text = @"***********";
    }
    else
    {
        phoneLabel.text = phoneNum;
    }
    
    phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.left);
        make.top.equalTo(_nameLabel.bottom).offset(2);
    }];
    
    
    UIImageView *imgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 25, 25)];
    [imgLeft setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *btnLeft =[[UIButton alloc]initWithFrame:CGRectMake(0, 30, 80, 25)];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btnLeft addSubview:imgLeft];
    [self.view addSubview:btnLeft]; 
}

-(NSMutableArray *)arr
{
    if (!_arr)
    {
        _arr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _arr;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyWalletTableViewCell *cell = nil;
    MyWalletModel *model = _arr[indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell  setValue:model];
    if (indexPath.row == 1)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.rightLabel.text = @"0元";
    }
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[TheBillViewController alloc]init] animated:YES];
            break;
        case 1:
            break;
        case 2:
            [self.navigationController pushViewController:[[RechargeViewController alloc]init] animated:YES];
            break;
        case 3:
        {
            CashViewController *cvc = [[CashViewController alloc]init];
            cvc.balance = _balance;
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case 4:
        {
            GetChargeViewController *cvc = [[GetChargeViewController alloc]init];
            cvc.depositBalance = _depositBalance;
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        default:
            break;
    }
    
}

-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}


#pragma  mark 返回
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoUserInfor
{
    [self.navigationController pushViewController:[[UserInforViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

