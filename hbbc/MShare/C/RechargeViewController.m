//
//  RechargeViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/11.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "RechargeViewController.h"
#import "PayMoneyProtocalViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "UserInforViewController.h"

#define btnWidth (SCREEN_WIDTH - 40 - 260)

@interface RechargeViewController ()

@property(nonatomic,strong)UIButton *moneyBtn;
@property (nonatomic,strong)UIImageView *wechatImg;
@property (nonatomic,strong)UIImageView *zhifubaoImg;
@property (nonatomic,strong)UIButton *wechat;
@property (nonatomic,strong)UIButton *zhifubao;
@property (nonatomic,strong)NSString *payType;
@property (nonatomic,strong)NSMutableArray *btnArr;
@property (nonatomic,strong) NSString *payOrderID;
@property (nonatomic,strong)NSString *orderString;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)int time;
@property (nonatomic,strong)NSString *money;

@end

@implementation RechargeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.title = @"充值";
    [self initUI];
}

-(void)initUI
{
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = @"充值金额";
    [self.view addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(84);
    }];
    NSArray *titleArr = @[@"充100元",@"充50元",@"充20元",@"充10元"];
    _money = @"100";
    _btnArr = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < 4; i++)
    {
        _moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moneyBtn.layer.cornerRadius = 3;
        _moneyBtn.layer.borderColor = RGBCOLOR(66, 165, 234).CGColor;
        _moneyBtn.layer.borderWidth = 1;
        _moneyBtn.backgroundColor = [UIColor whiteColor];
        _moneyBtn.tag = i;
        [_moneyBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [_moneyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_moneyBtn addTarget:self action:@selector(chooseMoney:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_moneyBtn];
        [_moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topLabel.bottom).offset(20 + i/2 * 62);
            make.left.equalTo(20 + i%2 * (btnWidth + 130));
            make.width.equalTo(130);
            make.height.equalTo(42);
        }];
        if (i == 0)
        {
            _moneyBtn.backgroundColor = RGBCOLOR(66, 165, 234);
            [_moneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [_btnArr addObject:_moneyBtn];
    }
    
    UILabel *midLabel = [[UILabel alloc]init];
    midLabel.text = @"充值方式";
    [self.view addSubview:midLabel];
    [midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(_moneyBtn.bottom).offset(30);
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
    
    UIImageView *midlineView = [[UIImageView alloc]init];
    midlineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:midlineView];
    [midlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(1);
        make.top.equalTo(_wechatImg.bottom).offset(15);
    }];
    
    _zhifubaoImg = [[UIImageView alloc]init];
    [_zhifubaoImg setImage:[UIImage imageNamed:@"pay_zhifubao"]];
    [self.view addSubview:_zhifubaoImg];
    [_zhifubaoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wechatImg.bottom).offset(30);
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
    
    UIImageView *btomlineView = [[UIImageView alloc]init];
    btomlineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btomlineView];
    [btomlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(1);
        make.top.equalTo(_zhifubaoImg.bottom).offset(15);
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
    [payBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    payBtn.layer.cornerRadius = 5;
    payBtn.backgroundColor = RGBCOLOR(66, 165, 234);
    [self.view addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(50);
        make.bottom.equalTo(-50);
    }];
    [payBtn addTarget:self action:@selector(PayMoney) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *midLeftLabel = [[UILabel alloc]init];
    midLeftLabel.text = @"点击立即充值,即表示您已经同意";
    midLeftLabel.textColor = [UIColor grayColor];
    midLeftLabel.font = [UIFont systemFontOfSize:10.0];
    float width = (SCREEN_WIDTH - 112 - 145) / 2;
    [self.view addSubview:midLeftLabel];
    [midLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(width);
        make.top.equalTo(payBtn.bottom).offset(15);
    }];
    
    UIButton *midRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [midRightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [midRightBtn setTitle:@"《充值活动协议》" forState:UIControlStateNormal];
    midRightBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [self.view addSubview:midRightBtn];
    [midRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(midLeftLabel.mas_centerY);
        make.left.equalTo(midLeftLabel.right);
        make.width.equalTo(112);
    }];
    [midRightBtn addTarget:self action:@selector(goToRead) forControlEvents:UIControlEventTouchUpInside];
}

-(void)chooseMoney:(UIButton *)button
{
    for (UIButton *btn in _btnArr)
    {
        if (btn.tag == button.tag)
        {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = RGBCOLOR(66, 165, 234);
        }
        else
        {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
        }
    }
    switch (button.tag) {
        case 0:
            _money = @"100";
            break;
        case 1:
            _money = @"50";
            break;
        case 2:
            _money = @"20";
            break;
        case 3:
            _money = @"10";
            break;
        default:
            break;
    }
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

-(void)PayMoney
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"PayType":_payType,
                                 @"AppID":APPID,
                                 @"AppType":@"2",
                                 @"RechargeAmount":_money,
                                 @"OpenID":@""
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:RECHARGEMoney success:^(id responseBody){
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
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getTheResult) userInfo:nil repeats:YES];
    [_timer fire];
    
    NSString *status = notification.object;
    if ([notification.object isEqualToString:@"success"])
    {
        [CommonClass showAlertWithMessage:@"充值成功"];
        
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[UserInforViewController class]])
            {
                UserInforViewController *dfgc =(UserInforViewController *)controller;
                [self.navigationController popToViewController:dfgc animated:YES];
            }
        }
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
    [[AlipaySDK defaultService] payOrder:_orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        //支付结果接口
        NSDictionary *parameters = @{
                                     @"ECID":ECID,
                                     @"PhoneNumber":PhoneNum,
                                     @"PayOrderID":_payOrderID,
                                     @"AppID":APPID
                                     };
        [[NetworkSingleton shareManager] httpRequest:parameters url:GetPayResultStatus success:^(id responseBody){
            DHResponseBodyLog(responseBody);
            
        } failed:^(NSError *error)
         {
             DHErrorLog(error);
         }];
        NSString *restltStates = [NSString stringWithFormat:@"%@",  resultDic[@"resultStatus"]];
        if ([restltStates isEqualToString:@"9000"])
        {
            [CommonClass showAlertWithMessage:@"充值成功"];
            
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[UserInforViewController class]])
                {
                    UserInforViewController *dfgc =(UserInforViewController *)controller;
                    [self.navigationController popToViewController:dfgc animated:YES];
                }
            }
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


-(void)goToRead
{
    [self.navigationController pushViewController:[[PayMoneyProtocalViewController alloc]init] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

