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
    self.view.backgroundColor = RGBCOLOR(92, 177, 236);
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
       NSString *string = [NSString stringWithFormat:@"%@元",_balance];
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];

        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, string.length-1)];
        cell.rightLabel.attributedText = mAttStri;
        
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
    _aTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
//    _aTableView.backgroundColor = [UIColor lightGrayColor];
    _aTableView.dataSource = self;
    _aTableView.delegate = self;
    _aTableView.scrollEnabled = NO;
    [_aTableView setSeparatorInset:UIEdgeInsetsZero];
    [_aTableView setLayoutMargins:UIEdgeInsetsZero];
    [_aTableView registerClass:[MyWalletTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
#pragma mark ********************table头

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    
    _aTableView.tableHeaderView = headerView;
    self.aTableView.sectionHeaderHeight = 10;
    self.aTableView.sectionFooterHeight = 0;
    [self.view addSubview:_aTableView];
    [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(64);
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(800);
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
#pragma mark ********************头像

    _imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imgBtn setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    [self.view addSubview:_imgBtn];
    [_imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(titleLabel.bottom).offset(20);
        make.width.height.equalTo(70);
    }];
    _imgBtn.layer.cornerRadius = 35;
    _imgBtn.layer.masksToBounds = YES;
#pragma mark ********************昵称

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"***";
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgBtn.right).offset(15);
        make.top.equalTo(_imgBtn.top).offset(10);
    }];
    
#pragma mark ********************电话号码

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
    
    phoneLabel.textColor = [UIColor grayColor];
    phoneLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.left);
        make.top.equalTo(_nameLabel.bottom).offset(2);
    }];
    
#pragma mark ********************返回按钮
 
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview = nil;
    headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    return headerview;

}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu",section);
    NSUInteger section_number = 0;
    if (section == 0) {
        section_number = 2;
    }
    else if (section == 1){
        section_number = 2;
        
    }
    else if(section == 2){
        
        section_number = 1;
    }
    return section_number ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{       MyWalletTableViewCell *cell = nil;
    
    NSLog(@"%lu-------------------%lu",indexPath.section,indexPath.row);
    if (indexPath.section == 0) {
        MyWalletModel *model = _arr[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1)
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.rightLabel.text = @"0元";
                }
        [cell  setValue:model];
        
    }
    else if (indexPath.section == 1) {
        MyWalletModel *model = _arr[indexPath.row + 2];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell  setValue:model];
        
    }
    else if (indexPath.section == 2){
        
        MyWalletModel *model = _arr[indexPath.row + 4];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell  setValue:model];
        
    }
    
    return  cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[[TheBillViewController alloc]init] animated:YES];
                break;
            case 1:
                
                break;
            default:
                break;
                
        }
    }
    if (indexPath.section == 1) {
        NSLog(@"%lu-------------------%lu",indexPath.section,indexPath.row);
        switch (indexPath.row) {
            case 0:
            [self.navigationController pushViewController:[[RechargeViewController alloc]init] animated:YES];
                break;
            case 1:
                {
                                CashViewController *cvc = [[CashViewController alloc]init];
                                cvc.balance = _balance;
                                [self.navigationController pushViewController:cvc animated:YES];
                            }
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 2) {
        NSLog(@"%lu-------------------%lu",indexPath.section,indexPath.row);
        switch (indexPath.row) {
            case 0:
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
    
    
    
    
    
    
    
//    switch (indexPath.row) {
//        case 0:
//            [self.navigationController pushViewController:[[TheBillViewController alloc]init] animated:YES];
//            break;
//        case 1:
//            break;
//        case 2:
//            [self.navigationController pushViewController:[[RechargeViewController alloc]init] animated:YES];
//            break;
//        case 3:
//        {
//            CashViewController *cvc = [[CashViewController alloc]init];
//            cvc.balance = _balance;
//            [self.navigationController pushViewController:cvc animated:YES];
//        }
//            break;
//        case 4:
//        {
//            GetChargeViewController *cvc = [[GetChargeViewController alloc]init];
//            cvc.depositBalance = _depositBalance;
//            [self.navigationController pushViewController:cvc animated:YES];
//        }
//            break;
//        default:
//            break;
//    }
    
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

