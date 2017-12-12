//
//  CertainViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/31.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "CertainViewController.h"
#import "ChargeInViewController.h"

@interface CertainViewController ()

@property (nonatomic,strong)UIImageView *topImgView;
@property (nonatomic,strong)UIImageView *midImgView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *idLabel;
@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)UITextField *idField;
@property (nonatomic,strong)UIButton *goToBtn;

@end

@implementation CertainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"实名认证" ;
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
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"姓名";
    [self.view addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topImgView.mas_centerY);
        make.left.equalTo(_topImgView.left).offset(15);
        make.width.equalTo(60);
    }];
    
    _nameField = [[UITextField alloc]init];
    _nameField.placeholder = @"请输入您的真实姓名";
    [self.view addSubview:_nameField];
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topImgView.mas_centerY);
        make.left.equalTo(_nameLabel.right).offset(20);
        make.right.equalTo(_topImgView.right).offset(50);
    }];
    
    _midImgView = [[UIImageView alloc]init];
    _midImgView.backgroundColor = RGBCOLOR(242, 242, 242);
    [self.view addSubview:_midImgView];
    [_midImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(_topImgView.bottom).offset(15);
        make.height.equalTo(50);
    }];
    
    _idLabel = [[UILabel alloc]init];
    _idLabel.text = @"证件号";
    [self.view addSubview:_idLabel];
    [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_midImgView.mas_centerY);
        make.left.equalTo(_midImgView.left).offset(15);
        make.width.equalTo(60);
    }];
    
    _idField = [[UITextField alloc]init];
    _idField.placeholder = @"请输入您的身份证号";
    [self.view addSubview:_idField];
    [_idField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_midImgView.mas_centerY);
        make.left.equalTo(_idLabel.right).offset(20);
        make.right.equalTo(_midImgView.right).offset(50);
    }];
    
    _goToBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goToBtn setBackgroundColor:RGBCOLOR(66, 165, 234) forState:UIControlStateNormal];
    [_goToBtn setBackgroundColor:RGBCOLOR(66, 180, 255) forState:UIControlStateHighlighted];
    _goToBtn.layer.masksToBounds = YES;
    _goToBtn.layer.cornerRadius = 5;
    [_goToBtn setTitle:@"开始认证" forState:UIControlStateNormal];
    [self.view addSubview:_goToBtn];
    [_goToBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(50);
        make.top.equalTo(_midImgView.bottom).offset(100);
    }];
    [_goToBtn addTarget:self action:@selector(goToCertify) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [_idField resignFirstResponder];
    [_nameField resignFirstResponder];
}



//身份证号检查
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//点击认证按钮
-(void)goToCertify
{
    if ([self validateIdentityCard:_idField.text])
    {
        NSDictionary *parameters = @{
                                     @"ECID":ECID,
                                     @"PhoneNumber":[[NSUserDefaults standardUserDefaults]objectForKey:@"PhoneNumber"],
                                     @"RealName":_nameField.text,
                                     @"CertificationNumber":_idField.text,
                                     @"AppType":@"2",
                                     @"AppID":APPID
                                     };
        [[NetworkSingleton shareManager] httpRequest:parameters url:NAMECERTAIN success:^(id responseBody){DHResponseBodyLog(responseBody);
            if ([_openDesposit isEqualToString:@"1"]) {
                [[NSUserDefaults standardUserDefaults]setObject:_nameField.text forKey:@"UserName"];
                ChargeInViewController *cic = [[ChargeInViewController alloc]init];
                cic.PayDespositNum = _PayDespositNum;
                [self.navigationController pushViewController:cic animated:YES];
            }
            else
            {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"alerdyLogin" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        failed:^(NSError *error)
         {
             DHErrorLog(error);
         }];
        
        
    }
    else
    {
        UIAlertView *aaaa = [[UIAlertView alloc]initWithTitle:@"" message:@"姓名或证件号格式不对" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [aaaa show];
    }
    
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
