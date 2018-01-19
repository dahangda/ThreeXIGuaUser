//
//  CZViewController.m
//  hbbciphone
//
//  Created by YanHang on 2018/1/2.
//  Copyright © 2018年 hbbc. All rights reserved.
//

#import "CZViewController.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PayResultViewController.h"

@interface CZViewController ()
@property (nonatomic,strong)UILabel *topLabel;
@property (nonatomic,strong)UILabel *depositLabel;

@property (nonatomic,strong)UIImageView *lineView;
@property (nonatomic,strong)UIImageView *firstImgView;
@property (nonatomic,strong)UILabel *introLabel;
@property (nonatomic,strong)UILabel *hintLabel;
@property (nonatomic,strong)UIImageView *midImgView;
@property (nonatomic,strong)NSArray *imgArr;
@property (nonatomic,strong)UIButton *zhifubaoBtn;
@property (nonatomic,strong)UIButton *weixinBtn;
@property (nonatomic,strong)UIButton *yueBtn;
@property (nonatomic,strong)UILabel *zhifubaoLabel;
@property (nonatomic,strong)UILabel *weixinLabel;
@property (nonatomic,strong)UILabel *yueLabel;
@property (nonatomic,strong)UIImageView *firstChooseImg;
@property (nonatomic,strong)UIImageView *secondChooseImg;
@property (nonatomic,strong)UIImageView *thirdChooseImg;
@property (nonatomic,strong)NSString *payType;
@property (nonatomic,strong)NSString *orderString;
@property (nonatomic,strong) NSString *payOrderID;
@property (nonatomic,strong)NSString *lockingEndTime;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)int time;

@end

@implementation CZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"充值";
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    _topLabel = [[UILabel alloc]init];
    _topLabel.text = @"您正在预定物品使用，本次延期支付";
    _topLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_topLabel];
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(79);
    }];
    
    _depositLabel = [[UILabel alloc]init];
    _depositLabel.textColor = [UIColor redColor];
    _depositLabel.font = [UIFont systemFontOfSize:22];
    _depositLabel.text = _money;
    [self.view addSubview:_depositLabel];
    [_depositLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLabel.right);
        make.centerY.equalTo(_topLabel.mas_centerY);
    }];
    
    UILabel *danweiLabel = [[UILabel alloc]init];
    danweiLabel.text = @"元";
    [self.view addSubview:danweiLabel];
    [danweiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_depositLabel.right);
        make.top.equalTo(79);
    }];
    
    UIImageView *firstlineView = [[UIImageView alloc]init];
    firstlineView.backgroundColor = RGBCOLOR(245, 245, 245);
    [self.view addSubview:firstlineView];
    [firstlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(2);
        make.top.equalTo(danweiLabel.bottom).offset(15);
    }];
    
    _firstImgView = [[UIImageView alloc]init];
    _imgArr = [NSArray arrayWithArray:_responsBody[@"PicList"]];
   NSURL *imgUrl = _imgArr[0];
    [_firstImgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"MD_picture_broken_link_128px_1074947_easyicon.net"]];
    [self.view addSubview:_firstImgView];
    [_firstImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(firstlineView.bottom).offset(15);
        make.width.height.equalTo(100);
    }];
    
    UIImageView *kuangView = [[UIImageView alloc]init];
    [kuangView setImage:[UIImage imageNamed:@"kuang"]];
    [self.view addSubview:kuangView];
    [kuangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_firstImgView.right).offset(5);
        make.right.equalTo(-5);
        make.top.equalTo(firstlineView.bottom).offset(15);
        make.bottom.equalTo(_firstImgView.bottom);
    }];
    
    UILabel *introLabel = [[UILabel alloc]init];
    introLabel.numberOfLines = 3;
    NSString *introtext = _responsBody[@"GoodsIntroduceText"];
    if ([introtext isEqualToString:@""])
    {
        introLabel.text = @"物品简介:";
    }
    else
    {
        introLabel.text = [NSString stringWithFormat:@"物品简介:%@",_responsBody[@"GoodsIntroduceText"]];
    }
    [self.view addSubview:introLabel];
    [introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kuangView.left).offset(10);
        make.top.equalTo(kuangView.top).offset(5);
        make.right.equalTo(kuangView.right).offset(-10);
    }];
    
    
    _lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = RGBCOLOR(245, 245, 245);
    [self.view addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(2);
        make.top.equalTo(_firstImgView.bottom).offset(15);
    }];
    
    UIImageView *payImg = [[UIImageView alloc]init];
    payImg.image = [UIImage imageNamed:@"payImg"];
    [self.view addSubview:payImg];
    [payImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom).offset(15);
        make.left.equalTo(30);
        make.width.height.equalTo(20);
    }];
    
    UILabel *payLabel = [[UILabel alloc]init];
    payLabel.text = @"支付方式";
    [self.view addSubview:payLabel];
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payImg.right).offset(5);
        make.centerY.equalTo(payImg.mas_centerY);
    }];
    
    UIImageView *midLineView = [[UIImageView alloc]init];
    midLineView.backgroundColor = RGBCOLOR(254, 254, 254);
    [self.view addSubview:midLineView];
    [midLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(1);
        make.top.equalTo(payLabel.bottom).offset(15);
    }];
    
    _zhifubaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _zhifubaoBtn.backgroundColor = RGBCOLOR(147, 159, 172);
    [self.view addSubview:_zhifubaoBtn];
    [_zhifubaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midLineView.bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(50);
    }];
    [_zhifubaoBtn addTarget:self action:@selector(chooseZhifubao) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *zhifubaoImg = [[UIImageView alloc]init];
    zhifubaoImg.image = [UIImage imageNamed:@"zhifubaoImg"];
    [_zhifubaoBtn addSubview:zhifubaoImg];
    [zhifubaoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(30);
        make.width.height.equalTo(25);
    }];
    
    _zhifubaoLabel = [[UILabel alloc]init];
    _zhifubaoLabel.text = @"支付宝";
    _zhifubaoLabel.textColor = [UIColor whiteColor];
    _zhifubaoLabel.font = [UIFont systemFontOfSize:20.0];
    [_zhifubaoBtn addSubview:_zhifubaoLabel];
    [_zhifubaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(zhifubaoImg.right).offset(30);
        make.centerY.equalTo(zhifubaoImg.mas_centerY);
    }];
    
    _firstChooseImg = [[UIImageView alloc]init];
    _firstChooseImg.image = [UIImage imageNamed:@"grayBlueCircle"];
    [_zhifubaoBtn addSubview:_firstChooseImg];
    [_firstChooseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zhifubaoImg.mas_centerY);
        make.right.equalTo(-30);
        make.width.height.equalTo(16);
    }];
    
    _lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = RGBCOLOR(254, 254, 254);
    [self.view addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(1);
        make.top.equalTo(_zhifubaoBtn.bottom);
    }];
#pragma mark ********************weixin

    _weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_weixinBtn];
    [_weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(50);
    }];
    [_weixinBtn addTarget:self action:@selector(chooseWeixin) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *weixinImg = [[UIImageView alloc]init];
    weixinImg.image = [UIImage imageNamed:@"weixinImg"];
    [_weixinBtn addSubview:weixinImg];
    [weixinImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(30);
        make.width.height.equalTo(15);
    }];
    
    _weixinLabel = [[UILabel alloc]init];
    _weixinLabel.text = @"微信";
    _weixinLabel.font = [UIFont systemFontOfSize:18.0];
    [_weixinBtn addSubview:_weixinLabel];
    [_weixinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weixinImg.right).offset(30);
        make.centerY.equalTo(weixinImg.mas_centerY);
    }];
    
    _secondChooseImg = [[UIImageView alloc]init];
    _secondChooseImg.image = [UIImage imageNamed:@"grayCircle"];
    [_weixinBtn addSubview:_secondChooseImg];
    [_secondChooseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weixinImg.mas_centerY);
        make.right.equalTo(-30);
        make.width.height.equalTo(16);
    }];
    
    _lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = RGBCOLOR(254, 254, 254);
    [self.view addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(1);
        make.top.equalTo(_weixinBtn.bottom);
    }];
    
    _yueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_yueBtn];
    [_yueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(50);
    }];
    [_yueBtn addTarget:self action:@selector(chooseYue) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *yueImage = [[UIImageView alloc]init];
    yueImage.image = [UIImage imageNamed:@"余额"];
    [_yueBtn addSubview:yueImage];
    [yueImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(30);
        make.width.height.equalTo(25);
    }];
    
    _yueLabel = [[UILabel alloc]init];
    _yueLabel.text = @"用户余额";
    _yueLabel.font = [UIFont systemFontOfSize:20.0];
    [_yueBtn addSubview:_yueLabel];
    [_yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueImage.right).offset(30);
        make.centerY.equalTo(yueImage.mas_centerY);
    }];
    
    _thirdChooseImg = [[UIImageView alloc]init];
    _thirdChooseImg.image = [UIImage imageNamed:@"grayCircle"];
    [_yueBtn addSubview:_thirdChooseImg];
    [_thirdChooseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(yueImage.mas_centerY);
        make.right.equalTo(-30);
        make.width.height.equalTo(16);
    }];
    
    _lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = RGBCOLOR(245, 245, 245);
    [self.view addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(1);
        make.top.equalTo(_yueBtn.bottom);
    }];
    
    _payType = @"2";
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [payBtn setBackgroundColor:RGBCOLOR(66, 165, 234) forState:UIControlStateNormal];
    [payBtn setBackgroundColor:RGBCOLOR(66, 180, 255) forState:UIControlStateHighlighted];
    payBtn.layer.masksToBounds = YES;
    payBtn.layer.cornerRadius = 5;
    [payBtn addTarget:self action:@selector(GotoPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(80);
        make.right.equalTo(-80);
        make.height.equalTo(50);
        make.bottom.equalTo(-50);
    }];
    
}

-(void)back
{
    if (!_lockingEndTime) {
        _lockingEndTime = _oldTime;
    }
    
    if (self.lockTimeBlock) {
        self.lockTimeBlock(_lockingEndTime);
    }
    
    if (self.getMoneyBlock)
    {
        self.getMoneyBlock(_depositLabel.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)GotoPay
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"GoodsSNID":_GoodsSNID,
                                 @"PhoneNumber":PhoneNum,
                                 @"PayType":_payType,
                                 @"AppType":@"2",
                                 @"AppID":APPID,
                                 @"PayMoney":_depositLabel.text,
                                 @"OpenID":@"",
                                 @"OrderType":@"1"
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:reservation success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        if ([responseBody[@"Notice"] isEqualToString:@"操作成功"])
        {
            _orderString = responseBody[@"OrderString"];
            _payOrderID = responseBody[@"PayOrderID"];
            _lockingEndTime = responseBody[@"UnlockingEndTime"];
            if ([_payType isEqualToString:@"1"])
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
            else if([_payType isEqualToString:@"2"])
            {
                [self aliPay];
            }
            else
            {
                _time = 0;
                _timer = [NSTimer scheduledTimerWithTimeInterval:0.500 target:self selector:@selector(getTheResult) userInfo:nil repeats:YES];
                [_timer fire];
                PayResultViewController *prvc = [[PayResultViewController alloc]init];
                prvc.getMoneyBlock = ^(NSString *money)
                {
                    _depositLabel.text = money;
                };
                prvc.carNumber = _GoodsSNID;
                prvc.endTime = _lockingEndTime;
                [self.navigationController pushViewController:prvc animated:YES];
            }
        }
        else
        {
            if ([_payType isEqualToString:@"3"]) {
                [CommonClass showAlertWithMessage:@"余额不足，无法支付"];
            }
            else{
                [CommonClass showAlertWithMessage:responseBody[@"Notice"]];
            }
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
        PayResultViewController *prvc = [[PayResultViewController alloc]init];
        
        prvc.getMoneyBlock = ^(NSString *money)
        {
            _depositLabel.text = money;
            
        };
        
        
        prvc.carNumber = _GoodsSNID;
        prvc.endTime = _lockingEndTime;
        [self.navigationController pushViewController:prvc animated:YES];
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
    [[AlipaySDK defaultService] payOrder:_orderString fromScheme:appScheme callback:^(NSDictionary *resultDic)
     {
         _time = 0;
         _timer = [NSTimer scheduledTimerWithTimeInterval:0.500 target:self selector:@selector(getTheResult) userInfo:nil repeats:YES];
         [_timer fire];
         NSString *restltStates = [NSString stringWithFormat:@"%@",  resultDic[@"resultStatus"]];
         if ([restltStates isEqualToString:@"9000"])
         {
             PayResultViewController *prvc = [[PayResultViewController alloc]init];
             
             prvc.getMoneyBlock = ^(NSString *money)
             {
                 _depositLabel.text = money;
             };
             prvc.carNumber = _GoodsSNID;
             prvc.endTime = _lockingEndTime;
             [self.navigationController pushViewController:prvc animated:YES];
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

-(void)chooseZhifubao
{
    _payType = @"2";
    _zhifubaoBtn.backgroundColor = RGBCOLOR(147, 159, 172);
    _zhifubaoLabel.textColor = [UIColor whiteColor];
    _firstChooseImg.image = [UIImage imageNamed:@"grayBlueCircle"];
    _weixinBtn.backgroundColor = [UIColor whiteColor];
    _weixinLabel.textColor = [UIColor blackColor];
    _secondChooseImg.image = [UIImage imageNamed:@"grayCircle"];
    _yueBtn.backgroundColor = [UIColor whiteColor];
    _yueLabel.textColor = [UIColor blackColor];
    _thirdChooseImg.image = [UIImage imageNamed:@"grayCircle"];
}

-(void)chooseWeixin
{
    _payType = @"1";
    _zhifubaoBtn.backgroundColor = [UIColor whiteColor];
    _zhifubaoLabel.textColor = [UIColor blackColor];
    _firstChooseImg.image = [UIImage imageNamed:@"grayCircle"];
    _weixinBtn.backgroundColor = RGBCOLOR(147, 159, 172);
    _weixinLabel.textColor = [UIColor whiteColor];
    _secondChooseImg.image = [UIImage imageNamed:@"grayBlueCircle"];
    _yueBtn.backgroundColor = [UIColor whiteColor];
    _yueLabel.textColor = [UIColor blackColor];
    _thirdChooseImg.image = [UIImage imageNamed:@"grayCircle"];
}

-(void)chooseYue
{
    _payType = @"3";
    _zhifubaoBtn.backgroundColor = [UIColor whiteColor];
    _zhifubaoLabel.textColor = [UIColor blackColor];
    _firstChooseImg.image = [UIImage imageNamed:@"grayCircle"];
    _weixinBtn.backgroundColor = [UIColor whiteColor];
    _weixinLabel.textColor = [UIColor blackColor];
    _secondChooseImg.image = [UIImage imageNamed:@"grayCircle"];
    _yueBtn.backgroundColor = RGBCOLOR(147, 159, 172);
    _yueLabel.textColor = [UIColor whiteColor];
    _thirdChooseImg.image = [UIImage imageNamed:@"grayBlueCircle"];
}
@end
