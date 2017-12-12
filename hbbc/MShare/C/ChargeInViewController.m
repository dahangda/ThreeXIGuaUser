//
//  ChargeInViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/13.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "ChargeInViewController.h"
#import "RegistViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "RSADataSigner.h"
#import "WXApi.h"

@interface ChargeInViewController ()


@property (nonatomic,strong)UIImageView *wechatImg;
@property (nonatomic,strong)UIImageView *zhifubaoImg;

@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)NSString *payType;
@property (nonatomic,strong)NSString *orderString;
@property (nonatomic,strong)NSString *payStatus;
@property (nonatomic,strong)UIButton *wechat;
@property (nonatomic,strong)UIButton *zhifubao;
@property (nonatomic,strong) NSString *payOrderID;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)int time;

@end

@implementation ChargeInViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.title = @"交纳押金";
    
    UILabel *topLabl = [[UILabel alloc]init];
    topLabl.text = @"金额";
    topLabl.textColor = [UIColor grayColor];
    topLabl.font = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:topLabl];
    [topLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(69);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    _moneyLabel = [[UILabel alloc]init];
    _moneyLabel.text = [NSString stringWithFormat:@"%@元",_PayDespositNum];
    _moneyLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabl.bottom).offset(20);
        make.centerX.equalTo(topLabl.mas_centerX);
    }];
    
    UILabel *midLabel = [[UILabel alloc]init];
    midLabel.text = @"押金随心退，安全速到账";
    midLabel.textColor = [UIColor grayColor];
    midLabel.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:midLabel];
    [midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLabel.bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UIImageView *lineView = [[UIImageView alloc]init];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(1);
        make.top.equalTo(midLabel.bottom).offset(20);
    }];
    
    _wechatImg = [[UIImageView alloc]init];
    [_wechatImg setImage:[UIImage imageNamed:@"pay_wechat"]];
    [self.view addSubview:_wechatImg];
    [_wechatImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(15);
        make.left.equalTo(20);
        make.width.height.equalTo(40);
    }];
    
    UILabel *wechatLabel = [[UILabel alloc]init];
    wechatLabel.text = @"微信";
    [self.view addSubview:wechatLabel];
    [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_wechatImg.mas_centerY);
        make.left.equalTo(_wechatImg.right).offset(10);
    }];
    
    _zhifubaoImg = [[UIImageView alloc]init];
    [_zhifubaoImg setImage:[UIImage imageNamed:@"pay_zhifubao"]];
    [self.view addSubview:_zhifubaoImg];
    [_zhifubaoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wechatImg.bottom).offset(40);
        make.left.equalTo(20);
        make.width.height.equalTo(40);
    }];
    
    UILabel *zhifubaoLabel = [[UILabel alloc]init];
    zhifubaoLabel.text = @"支付宝";
    [self.view addSubview:zhifubaoLabel];
    [zhifubaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_zhifubaoImg.mas_centerY);
        make.left.equalTo(_zhifubaoImg.right).offset(10);
    }];
    
    
    _wechat = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wechat setImage:[UIImage imageNamed:@"gray_circle"] forState:UIControlStateNormal];
    [_wechat setImage:[UIImage imageNamed:@"greenPay_circle"] forState:UIControlStateSelected];
    _wechat.layer.cornerRadius = 12;
    _wechat.layer.masksToBounds = YES;
    _wechat.selected = YES;
    [self.view addSubview:_wechat];
    [_wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_wechatImg.mas_centerY);
        make.right.equalTo(-50);
        make.width.height.equalTo(22);
    }];
    [_wechat addTarget:self action:@selector(chooseWechat) forControlEvents:UIControlEventTouchUpInside];
    
    _zhifubao = [UIButton buttonWithType:UIButtonTypeCustom];
    [_zhifubao setImage:[UIImage imageNamed:@"gray_circle"] forState:UIControlStateNormal];
    [_zhifubao setImage:[UIImage imageNamed:@"greenPay_circle"] forState:UIControlStateSelected];
    _zhifubao.layer.cornerRadius = 12;
    _zhifubao.layer.masksToBounds = YES;
    [self.view addSubview:_zhifubao];
    [_zhifubao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_zhifubaoImg.mas_centerY);
        make.right.equalTo(-50);
        make.width.height.equalTo(22);
    }];
    [_zhifubao addTarget:self action:@selector(chooseZhifubao) forControlEvents:UIControlEventTouchUpInside];
    _payType = @"1";
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [payBtn setTitle:@"交纳押金" forState:UIControlStateNormal];
    [payBtn setBackgroundColor:RGBCOLOR(66, 165, 234) forState:UIControlStateNormal];
    [payBtn setBackgroundColor:RGBCOLOR(66, 180, 255) forState:UIControlStateHighlighted];
    payBtn.layer.masksToBounds = YES;
    payBtn.layer.cornerRadius = 5;
    [self.view addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(50);
        make.bottom.equalTo(-30);
    }];
    [payBtn addTarget:self action:@selector(PayDeposit) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.font = [UIFont systemFontOfSize:13.0];
    bottomLabel.textColor = [UIColor grayColor];
    bottomLabel.text = @"我们不会以任何方式要求您输入银行账户和密码";
    [self.view addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(payBtn.top).offset(-20);
    }];
}


-(void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)chooseWechat
{
    _wechat.selected = YES;
    _zhifubao.selected = NO;
    _payType = @"1";
}

- (void)chooseZhifubao
{
    _wechat.selected = NO;
    _zhifubao.selected = YES;
    _payType = @"2";
}


- (void)PayDeposit
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"PayType":_payType,
                                 @"DepositCount":_PayDespositNum,
                                 @"AppID":APPID,
                                 @"OpenID":@""
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:UserPayDeposit success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        _orderString = responseBody[@"OrderString"];
        _payOrderID = responseBody[@"PayOrderID"];
        
        if (_wechat.selected)
        {
            if (![WXApi isWXAppInstalled]){  // 是否安装了微信
                
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有安装微信" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alter show];
            } else if (![WXApi isWXAppSupportApi]){ // 是否支持微信支付
                
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不支持微信支付" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alter show];
                
                
            }else
            {  //已安装微信, 进行支付
                NSDictionary *aDic = [NSJSONSerialization JSONObjectWithData:[_orderString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
                
                //需要创建这个支付对象
                PayReq* req= [[PayReq alloc]init];
                //由用户微信号和AppID组成的唯一标识，用于校验微信用户
                //req.openID = [aDic objectForKey:@"appid"];
                
                // 商家id，在注册的时候给的
                req.partnerId = [aDic objectForKey:@"partnerid"];
                // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
                req.prepayId  = [aDic objectForKey:@"prepayid"];
                // 根据财付通文档填写的数据和签名
                //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
                req.package = @"Sign=WXPay";
                // 随机编码，为了防止重复的，在后台生成
                req.nonceStr = [aDic objectForKey:@"noncestr"];
                // 这个是时间戳，也是在后台生成的，为了验证支付的
                NSString * stamp = [aDic objectForKey:@"timestamp"];
                req.timeStamp = stamp.intValue;
                // 这个签名也是后台做的
                req.sign = [aDic objectForKey:@"sign"];
                //日志输出NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\nsign=%@",[aDic objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.sign );
                //发送请求到微信，等待微信返回onResp
                [WXApi sendReq:req];
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPay" object:nil];
            }
        }
        else
        {
            [self aliPay];
        }
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

//微信支付支付完成回调
-(void)getOrderPayResult:(NSNotification *)notification
{
    _time = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.500 target:self selector:@selector(getTheResult) userInfo:nil repeats:YES];
    [_timer fire];
    
    NSString *status = notification.object;
    if ([status isEqualToString:@"success"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"alerdyLogin" object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
            if ([status isEqualToString:@"cancel"])
            {
                status = @"2";
            }
            else
            {
                status = @"3";
            }
            NSDictionary *parameters = @{
                                         @"ECID":ECID,
                                         @"Status":status,
                                         @"PayOrderID":_payOrderID,
                                         @"AppID":APPID
                                         };
            [[NetworkSingleton shareManager] httpRequest:parameters url:SetNOTPayResultStatus success:^(id responseBody){
                DHResponseBodyLog(responseBody);
                
            } failed:^(NSError *error)
             {
                 DHErrorLog(error);
             }];
    }
}

#pragma mark 每隔0.5秒请求支付结果，最多6次
-(void)getTheResult
{
    _time++;
    if (_time == 6)
    {
        [_timer invalidate];
        _timer = nil;
    }
    //支付结果接口
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"PayOrderID":_payOrderID,
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:GetPayResultStatus success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        NSString *payState = [NSString stringWithFormat:@"%@",responseBody[@"PayStatus"]];
        if ([payState isEqualToString:@"1"])
        {
            [_timer invalidate];
            _timer = nil;
        }
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

//支付宝支付
-(void)aliPay
{
    NSString *appScheme = @"gongxianggongyuuseralipayxsd";
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:_orderString fromScheme:appScheme callback:^(NSDictionary *resultDic){
        _time = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.500 target:self selector:@selector(getTheResult) userInfo:nil repeats:YES];
        [_timer fire];
        NSString *restltStates = [NSString stringWithFormat:@"%@",  resultDic[@"resultStatus"]];
        if ([restltStates isEqualToString:@"9000"])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alerdyLogin" object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
                NSDictionary *parameters = @{
                                             @"ECID":ECID,
                                             @"Status":@"2",
                                             @"PayOrderID":_payOrderID,
                                             @"AppID":APPID
                                             };
                [[NetworkSingleton shareManager] httpRequest:parameters url:SetNOTPayResultStatus success:^(id responseBody){
                    DHResponseBodyLog(responseBody);
                    
                } failed:^(NSError *error)
                 {
                     DHErrorLog(error);
                 }];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
