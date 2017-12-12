//
//  RegistViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/31.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "RegistViewController.h"
#import "CertainViewController.h"
#import "ChargeInViewController.h"
#import "UserProtocalViewController.h"

@interface RegistViewController ()

@property (nonatomic,strong)UIImageView *topImgView;
@property (nonatomic,strong)UIImageView *midImgView;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UITextField *numberField;
@property (nonatomic,strong)UITextField *proveField;
@property (nonatomic,strong)UIButton *getNumberBtn;
@property (nonatomic,strong)UIButton *btmBtn;
@property (nonatomic,strong)UILabel *proveLabel;
@property (nonatomic,strong)UILabel *midLeftLabel;
@property (nonatomic,strong)UIButton *midRightBtn;
@property (nonatomic,strong)UILabel *btomLabel;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)int time;
@property (nonatomic,strong)NSString *OpenDesposit;



@end

@implementation RegistViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册登录" ;
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    _topImgView = [[UIImageView alloc]init];
    _topImgView.backgroundColor = RGBCOLOR(242, 242, 242);
    [self.view addSubview:_topImgView];
    [_topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(107);
        make.height.equalTo(50);
    }];
    
    _numberLabel = [[UILabel alloc]init];
    _numberLabel.text = @"手机号";
    [self.view addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topImgView.mas_centerY);
        make.left.equalTo(_topImgView.left).offset(15);
        make.width.equalTo(60);
    }];
    
    _numberField = [[UITextField alloc]init];
    _numberField.placeholder = @"请输入手机号码";
    _numberField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [self.view addSubview:_numberField];
    [_numberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topImgView.mas_centerY);
        make.left.equalTo(_numberLabel.right).offset(10);
        make.width.equalTo(150);
    }];
    
    _midImgView = [[UIImageView alloc]init];
    _midImgView.backgroundColor = RGBCOLOR(242, 242, 242);
    [self.view addSubview:_midImgView];
    [_midImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.width.equalTo(215);
        make.top.equalTo(_topImgView.bottom).offset(15);
        make.height.equalTo(50);
    }];
    
    _proveLabel = [[UILabel alloc]init];
    _proveLabel.text = @"验证码";
    [self.view addSubview:_proveLabel];
    [_proveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_midImgView.mas_centerY);
        make.left.equalTo(_midImgView.left).offset(15);
        make.width.equalTo(60);
    }];
    
    _proveField = [[UITextField alloc]init];
    _proveField.placeholder = @"请输入验证码";
    _proveField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [self.view addSubview:_proveField];
    [_proveField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_midImgView.mas_centerY);
        make.left.equalTo(_proveLabel.right).offset(10);
        make.width.equalTo(120);
    }];
    
    _getNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getNumberBtn.backgroundColor = RGBCOLOR(66, 165, 234);
    _getNumberBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    _getNumberBtn.layer.masksToBounds = YES;
    _getNumberBtn.layer.cornerRadius = 5;
    [_getNumberBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:_getNumberBtn];
    [_getNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_midImgView.mas_centerY);
        make.left.equalTo(_midImgView.right).offset(2);
        make.right.equalTo(self.view.right).offset(-10);
        make.height.equalTo(50);
    }];
    
    [_getNumberBtn addTarget:self action:@selector(getnum) forControlEvents:UIControlEventTouchUpInside];
    _time = 60;
    
    _btmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btmBtn setBackgroundColor:RGBCOLOR(66, 165, 234) forState:UIControlStateNormal];
    [_btmBtn setBackgroundColor:RGBCOLOR(66, 180, 255) forState:UIControlStateHighlighted];
    _btmBtn.layer.masksToBounds = YES;
    _btmBtn.layer.cornerRadius = 5;
    [_btmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:_btmBtn];
    [_btmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(50);
        make.top.equalTo(_midImgView.bottom).offset(100);
    }];
    [_btmBtn addTarget:self action:@selector(goToCertain) forControlEvents:UIControlEventTouchUpInside];
    
    _midLeftLabel = [[UILabel alloc]init];
    _midLeftLabel.text = @"点击确定，即表示已阅读并同意";
    _midLeftLabel.textColor = [UIColor grayColor];
    _midLeftLabel.font = [UIFont systemFontOfSize:10.0];
    float width = (SCREEN_WIDTH - 112 - 145) / 2;
    [self.view addSubview:_midLeftLabel];
    [_midLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(width);
        make.top.equalTo(_btmBtn.bottom).offset(15);
    }];

    _midRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_midRightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_midRightBtn setTitle:@"《客户端APP用户协议》" forState:UIControlStateNormal];
    _midRightBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [self.view addSubview:_midRightBtn];
    [_midRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_midLeftLabel.mas_centerY);
        make.left.equalTo(_midLeftLabel.right);
        make.width.equalTo(112);
    }];
    [_midRightBtn addTarget:self action:@selector(readUserPortocal) forControlEvents:UIControlEventTouchUpInside];

    _btomLabel = [[UILabel alloc]init];
    _btomLabel.text = @"视动世纪(北京)科技有限公司";
    _btomLabel.textColor = [UIColor grayColor];
    _btomLabel.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:_btomLabel];
    [_btomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-30);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


//阅读客户端app用户协议
-(void)readUserPortocal
{
    [self.navigationController pushViewController:[[UserProtocalViewController alloc]init] animated:YES];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [_numberField resignFirstResponder];
    [_proveField resignFirstResponder];
}

//手机号码验证
-(BOOL) validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
//点击获取验证码
-(void)getnum
{
    if([self validateMobile:_numberField.text])
    {
        if (!_timer)
        {
            NSDictionary *parameters = @{
                                         @"ECID":ECID,
                                         @"PhoneNumber":_numberField.text,
                                         @"AppType":@"2",
                                         @"AppID":APPID
                                         };
            [[NetworkSingleton shareManager] httpRequest:parameters url:GETSMSVERIFYCODE success:^(id responseBody){DHResponseBodyLog(responseBody);
                NSLog(@"%@",responseBody[@"Notice"]);
            } failed:^(NSError *error)
             {
                 DHErrorLog(error);
             }];
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reduce) userInfo:nil repeats:YES];//设置变化的时间间隔以及变化的方法（reduce）
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
            [_timer fire];
            [_proveField becomeFirstResponder];
        }
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你好" message:@"手机号格式不正确" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ensureAction];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)reduce
{
    if (_time != 0)
    {
        _time--;
        [_getNumberBtn setTitle:[NSString stringWithFormat:@"%d",_time] forState:UIControlStateNormal];
        _getNumberBtn.backgroundColor = RGBCOLOR(242, 242, 242);
        _getNumberBtn.userInteractionEnabled = NO;
    }
    else
    {
        [_getNumberBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getNumberBtn.userInteractionEnabled = YES;
        _getNumberBtn.backgroundColor = RGBCOLOR(66, 165, 234);
        [_timer invalidate];  // 从运行循环中移除， 对运行循环的引用进行一次 release
        _timer = nil;
        _time = 60;
    }
    
}

//  点击确定调注册接口
-(void)goToCertain
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":_numberField.text,
                                 @"TempVerifyCode":_proveField.text,
                                 @"AppType":@"2",
                                 @"AutoLoginKey":@"",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:DOLOGIN success:^(id responseBody){DHResponseBodyLog(responseBody);
        NSLog(@"%@",responseBody[@"Notice"]);
        if ([responseBody[@"Notice"] isEqualToString:@"操作成功"])
        {
            NSDictionary *dic = @{@"APPName":responseBody[@"AppName"]};
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getAppName" object:nil userInfo:dic];
            [[NSUserDefaults standardUserDefaults] setObject:responseBody[@"PhoneNumber"] forKey:@"PhoneNumber"];
            [[NSUserDefaults standardUserDefaults] setObject:responseBody[@"AutoLoginKey"] forKey:@"UserAutoLoginKey"];
            NSString * openCertification = [NSString stringWithFormat:@"%@",responseBody[@"OpenCertification"]];
            _OpenDesposit = [NSString stringWithFormat:@"%@",responseBody[@"OpenDesposit"]];
            NSString * CertificationStatus = [NSString stringWithFormat:@"%@",responseBody[@"CertificationStatus"]];
            NSString *DespositStatus = [NSString stringWithFormat:@"%@",responseBody[@"DespositStatus"]];
            NSString *PayDespositNum = [NSString stringWithFormat:@"%@",responseBody[@"PayDespositNum"]];
            // 是否需要实名认证
            if ([openCertification isEqualToString:@"1"])
            {
                // 实名认证是否通过
                if ([CertificationStatus isEqualToString:@"1"])
                {
                    NSLog(@"已通过");
                    //是否需要开启押金
                    if ([_OpenDesposit isEqualToString:@"1"])
                    {
                        //交纳押金状态
                        if ([DespositStatus isEqualToString:@"1"])
                        {
                            ChargeInViewController *cvc = [[ChargeInViewController alloc]init];
                            cvc.PayDespositNum = PayDespositNum;
                            [self.navigationController pushViewController:cvc animated:YES];
                        }
                        else
                        {
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"alerdyLogin" object:nil];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }
                    else
                    {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"alerdyLogin" object:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
                else
                {
                    CertainViewController *cvc = [[CertainViewController alloc]init];
                    cvc.PayDespositNum = PayDespositNum;
                    cvc.openDesposit = _OpenDesposit;
                    [self.navigationController pushViewController:cvc animated:YES];
                }
            }
            else
            {
                //是否需要开启押金
                if ([_OpenDesposit isEqualToString:@"1"])
                {
                    //交纳押金状态
                    if ([DespositStatus isEqualToString:@"1"])
                    {
                        ChargeInViewController *cvc = [[ChargeInViewController alloc]init];
                        cvc.PayDespositNum = PayDespositNum;
                        [self.navigationController pushViewController:cvc animated:YES];
                    }
                    else
                    {
                         [[NSNotificationCenter defaultCenter]postNotificationName:@"alerdyLogin" object:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
                else
                {
                     [[NSNotificationCenter defaultCenter]postNotificationName:@"alerdyLogin" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
        else
        {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲" message:@"验证码错误" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:OKAction];
                [self.navigationController presentViewController:alertController animated:YES completion:nil];
        }
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
}

@end
