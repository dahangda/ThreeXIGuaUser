//
//  PayResultViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/12/6.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "PayResultViewController.h"

@interface PayResultViewController ()

@end

@implementation PayResultViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //关闭此页侧滑返回功能
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"支付结果";
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    _imgView = [[UIImageView alloc]init];
    _imgView.image = [UIImage imageNamed:@"lockOK"];
    [self.view addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(120);
        make.width.height.equalTo(125);
        make.left.equalTo(50);
    }];
    
    _resultLabel = [[UILabel alloc]init];
    _resultLabel.font = [UIFont systemFontOfSize:40];
    _resultLabel.text = @"支付成功";
    [self.view addSubview:_resultLabel];
    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-50);
        make.centerY.equalTo(_imgView.mas_centerY);
    }];
    
    UILabel *dianLabel = [[UILabel alloc]init];
    dianLabel.text = @".......................";
    dianLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:dianLabel];
    [dianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_imgView.bottom).offset(20);
    }];
    
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.text = @"您的开锁截止时间为:";
    [self.view addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dianLabel.bottom).offset(50);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.text = _endTime;
    _timeLabel.font = [UIFont systemFontOfSize:25];
    _timeLabel.textColor = [UIColor redColor];
    [self.view addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLabel.bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UILabel *midLabel = [[UILabel alloc]init];
    midLabel.text = @"如果时间不够请及时充值";
    [self.view addSubview:midLabel];
    [midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    _btmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btmBtn setBackgroundColor:RGBCOLOR(66, 165, 234) forState:UIControlStateNormal];
    [_btmBtn setBackgroundColor:RGBCOLOR(66, 180, 255) forState:UIControlStateHighlighted];
    _btmBtn.layer.masksToBounds = YES;
    _btmBtn.layer.cornerRadius = 5;
    [_btmBtn setTitle:@"充值" forState:UIControlStateNormal];
    [_btmBtn addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btmBtn];
    [_btmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(-50);
        make.height.equalTo(50);
        make.width.equalTo(200);
    }];
}


#pragma  mark 返回
-(void)back{
    //如果是由支付界面进来的
    //    if ([_result isEqualToString:@"支付成功"])
    //    {
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }
    //如果是由开锁界面进来的
    //    else
    //    {
    [self.navigationController popToRootViewControllerAnimated:YES];
    //    }
    
    
    
}

#pragma  mark 充值
-(void)recharge
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"AppType":@"2",
                                 @"PhoneNumber":PhoneNum,
                                 @"GoodsSNID":_carNumber,
                                 @"AppID":APPID,
                                 @"OrderType":@"2"
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:rechargeUnlockTime success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        if ([responseBody[@"Notice"] isEqualToString:@"操作成功"])
        {
            _money = [NSString stringWithFormat:@"%@",responseBody[@"PayMoney"]];
            //            //如果是由支付界面进来的
            //            if ([_result isEqualToString:@"支付成功"])
            //            {
                            if (self.getMoneyBlock)
                            {
                                self.getMoneyBlock(_money);
                            }
                            [self.navigationController popViewControllerAnimated:YES];
            //            }
            //如果是由开锁界面进来的
            //            else
            //            {
//            GoodsOrderPayViewController *gopc = [[GoodsOrderPayViewController alloc]init];
//            gopc.money = _money;
//            gopc.responsBody = _resPonsbody;
//            gopc.GoodsSNID = _carNumber;
//            [self.navigationController pushViewController:gopc animated:YES];
            //            }
        }
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
