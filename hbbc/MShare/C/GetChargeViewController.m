//
//  GetChargeViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/11.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "GetChargeViewController.h"
#import "NewItemSelectTableViewCell.h"


@interface GetChargeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UILabel *allCash;
@property (nonatomic,strong)UILabel *commitCashLabel;
@property (nonatomic,strong)UITextField *commitAccount;
@property (nonatomic,strong)UIButton *commitTypeBtn;
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UIView *mengbanView;
@property (nonatomic,strong)UITableView *firstTableView;
@property (nonatomic,strong)NewItemSelectTableViewCell *firstCell;
@property (nonatomic,strong)NSArray *firstLabelArr;
@property (nonatomic,strong)NSString *WithdrawalsType;

@end

@implementation GetChargeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
//    
//    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
//    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn addSubview:backImg];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    _firstLabelArr = @[@"支付宝",@"微信"];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self initUI];
}

-(void)initUI
{
    UIView *topImg = [[UIView alloc]init];
    topImg.backgroundColor =  RGBCOLOR(65, 165, 236);;
    
    [self.view addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(0);
        make.height.equalTo(200);
    }];
#pragma mark *******************返回按钮
    
    UIImageView *imgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 25, 25)];
    [imgLeft setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *btnLeft =[[UIButton alloc]initWithFrame:CGRectMake(0, 30, 80, 25)];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btnLeft addSubview:imgLeft];
    [self.view addSubview:btnLeft];
#pragma mark ********************tlttile
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"退还押金";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(btnLeft.mas_centerY);
    }];
    
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = @"当前余额（元)";
    topLabel.font = [UIFont systemFontOfSize:15];
    topLabel.textColor = [UIColor whiteColor];
    [topImg addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(btnLeft.bottom).offset(20);
    }];
    
    
    
//

    
    _allCash = [[UILabel alloc]init];
    _allCash.font = [UIFont systemFontOfSize:50];
    _allCash.text = _depositBalance;
    _allCash.textColor = [UIColor whiteColor];;
    [topImg addSubview:_allCash];
    [_allCash mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
            make.top.equalTo(topLabel.bottom).offset(20);
    }];

    
    
    
    
    UIImageView *middleView = [[UIImageView alloc]init];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(topImg.bottom).offset(10);
        make.height.equalTo(40);
    }];
    
    UILabel *commitMoney = [[UILabel alloc]init];
    commitMoney.text = @"退还金额";
    [middleView addSubview:commitMoney];
    [commitMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.centerY.equalTo(middleView.centerY);
        make.width.equalTo(80);
    }];
    
    
    UILabel *danwei = [[UILabel alloc]init];
    danwei.text = @"元";
    danwei.textColor = [UIColor grayColor];
    [middleView addSubview:danwei];
    [danwei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(commitMoney.mas_centerY);
        make.right.equalTo(-10);
        make.width.equalTo(20);
    }];
    
    _commitCashLabel = [[UILabel alloc]init];
    _commitCashLabel.textAlignment = NSTextAlignmentRight;
    _commitCashLabel.text = _depositBalance;
    _commitCashLabel.textColor = [UIColor grayColor];
    [self.view addSubview:_commitCashLabel];
    [_commitCashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(commitMoney.mas_centerY);
        make.right.equalTo(danwei.left);
    }];
    
    
    //提现方式
    UIImageView *middleView1 = [[UIImageView alloc]init];
    middleView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:middleView1];
    [middleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(middleView.bottom).offset(10);
        make.height.equalTo(40);
    }];
    
    
    UILabel *commitType = [[UILabel alloc]init];
    commitType.text = @"提现方式";
    [middleView1 addSubview:commitType];
    [commitType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(middleView1.centerY);
        make.left.equalTo(20);
        make.width.equalTo(80);
    }];
    
    
    UIImageView *typeImg = [[UIImageView alloc]init];
    typeImg.image = [UIImage imageNamed:@"gray_blue_circle"];
    [middleView1 addSubview:typeImg];
    [typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(middleView1.mas_centerY);
        make.width.height.equalTo(20);
    }];
    
    _commitTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_commitTypeBtn];
    [_commitTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(typeImg.left);
        make.left.equalTo(commitType.right).offset(10);
        make.centerY.equalTo(middleView.mas_centerY);
        make.height.equalTo(20);
    }];
    [_commitTypeBtn addTarget:self action:@selector(chooseCommitType) forControlEvents:UIControlEventTouchUpInside];
    
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.text = @"支付宝";
    _typeLabel.textAlignment = NSTextAlignmentRight;
    _typeLabel.textColor = [UIColor grayColor];
    [self.view addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(typeImg.left);
        make.width.equalTo(100);
        make.centerY.equalTo(middleView1.mas_centerY);
    }];
    
    UIImageView *middleView2 = [[UIImageView alloc]init];
    middleView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:middleView2];
    [middleView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(middleView1.bottom).offset(10);
        make.height.equalTo(40);
    }];
    
    UILabel *commitID = [[UILabel alloc]init];
    commitID.text = @"提现账户";
    [middleView2 addSubview:commitID];
    [commitID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.width.equalTo(80);
        make.centerY.equalTo(middleView2.centerY);
    }];
    
    _commitAccount = [[UITextField alloc]init];
    _commitAccount.textAlignment = NSTextAlignmentRight;
    _commitAccount.placeholder = PhoneNum;
    _commitAccount.userInteractionEnabled = YES;
    _commitAccount.textColor = [UIColor grayColor];
    _commitAccount.returnKeyType = UIReturnKeyDone;
    _commitAccount.delegate = self;
    [self.view addSubview:_commitAccount];
    [_commitAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(commitID.mas_centerY);
        make.right.equalTo(-10);
        make.left.equalTo(commitID.right).offset(10);
    }];
    
    UILabel *noticeLabel = [[UILabel alloc]init];
    noticeLabel.text = @"提现申请将在2-7个工作日内处理完成";
    noticeLabel.font = [UIFont systemFontOfSize:12];
    noticeLabel.textColor = [UIColor grayColor];
    [self.view addSubview:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.bottom).offset(-15);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyBtn setBackgroundColor:RGBCOLOR(66, 165, 234) forState:UIControlStateNormal];
    [applyBtn setBackgroundColor:RGBCOLOR(66, 180, 255) forState:UIControlStateHighlighted];
    applyBtn.layer.masksToBounds = YES;
    applyBtn.layer.cornerRadius = 5;
    [applyBtn setTitle:@"申请退款" forState:UIControlStateNormal];
    [self.view addSubview:applyBtn];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(45);
        make.bottom.equalTo(noticeLabel.top).offset(-20);
    }];
    [applyBtn addTarget:self action:@selector(applyForCash) forControlEvents:UIControlEventTouchUpInside];
    
   
}

#pragma mark 开始输入时屏幕上移
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.4 animations:^{self.view.frame = CGRectMake(self.view.frame.origin.x,  - 70, self.view.frame.size.width, self.view.frame.size.height);}];
    return YES;
}

#pragma mark 点击屏幕键盘消失屏幕下移到正常位置
-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [UIView animateWithDuration:0.4 animations:^{self.view.frame = CGRectMake(self.view.frame.origin.x,  0, self.view.frame.size.width, self.view.frame.size.height);}];
    [_commitAccount resignFirstResponder];
}

#pragma mark 点击键盘上的完成按钮屏幕下移到正常位置
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.4 animations:^{self.view.frame = CGRectMake(self.view.frame.origin.x,  0, self.view.frame.size.width, self.view.frame.size.height);}];
    [_commitAccount resignFirstResponder];
    return YES;
}

-(UIView *)mengbanView
{
    if (!_mengbanView)
    {
        _mengbanView = [[UIView alloc]initWithFrame:self.view.frame];
        _mengbanView.backgroundColor = [UIColor blackColor];
        _mengbanView.alpha = 0.5;
    }
    return _mengbanView;
}

-(UITableView *)firstTableView
{
    if(!_firstTableView)
    {
        _firstTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _firstTableView.dataSource = self;
        _firstTableView.delegate = self;
        _firstTableView.scrollEnabled = NO;
        _firstTableView.layer.cornerRadius = 5;
        [_firstTableView setSeparatorInset:UIEdgeInsetsZero];
        [_firstTableView setLayoutMargins:UIEdgeInsetsZero];
        [_firstTableView registerClass:[NewItemSelectTableViewCell class] forCellReuseIdentifier:@"firstTableViewCell"];
        [self.view addSubview:_firstTableView];
        [_firstTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_centerY);
            make.left.equalTo(50);
            make.right.equalTo(-50);
            make.height.equalTo(38 * 2);
        }];
    }
    return _firstTableView;
}

-(void)chooseCommitType
{
    [self.view addSubview:self.mengbanView];
    _mengbanView.hidden = NO;
    [self.view addSubview:self.firstTableView];
    _firstTableView.hidden = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _firstCell = [tableView dequeueReusableCellWithIdentifier:@"firstTableViewCell"];
    _firstCell.label.text = _firstLabelArr[indexPath.row];
    _firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0)
    {
        _firstCell.btn.selected = YES;
    }
    return _firstCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _firstTableView.hidden = YES;
    _mengbanView.hidden = YES;
    _typeLabel.text = _firstLabelArr[indexPath.row];
    for (NSInteger i = 0; i < 2; i++)
    {
        NewItemSelectTableViewCell *cell = [_firstTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.btn.selected = NO;
        if (i == indexPath.row)
        {
            cell.btn.selected = YES;
        }
    }
    
}
-(void)applyForCash
{
    if( [_commitTypeBtn.titleLabel.text isEqualToString:@"支付宝"])
    {
        _WithdrawalsType = @"2";
    }
    else
    {
        _WithdrawalsType = @"1";
    }
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"WithdrawalsAmount":_commitCashLabel.text,
                                 @"WithdrawalsAccountID":PhoneNum,
                                 @"WithdrawalsType":_WithdrawalsType,
                                 @"OperationType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:APPLYFORCASH success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        [CommonClass showAlertWithMessage:responseBody[@"Notice"]];
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
    
    
    
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


