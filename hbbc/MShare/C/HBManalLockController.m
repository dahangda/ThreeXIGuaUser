//
//  HBManalLockController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBManalLockController.h"
#import <AVFoundation/AVFoundation.h>
#import "ProgressViewController.h"
#import "GoodsDetailViewController.h"

#define kwidth  [UIScreen mainScreen].bounds.size.width
@interface HBManalLockController ()

@property (nonatomic,strong)UIImageView  *imgView;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UIButton *lightBtn;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UIImageView *topLineView;
@property (nonatomic,strong)UIImageView *botmLineView;
@property (nonatomic,strong)UIImageView *leftLineView;
@property (nonatomic,strong)UIImageView *rightLineView;

@end

@implementation HBManalLockController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"输入编号";
    
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    _imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"thelogo"]];
    [self.view addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(80);
        make.width.equalTo(SCREEN_WIDTH - 100);
        make.height.equalTo(127);
    }];


    _textField = [[UITextField alloc]init];
    UIFont *afont = [UIFont systemFontOfSize:16];
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入物品编号" attributes:@{NSFontAttributeName:afont}];
    _textField.tintColor = RGBCOLOR(66, 165, 234);
    _textField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [self.view addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_imgView.bottom).offset(50);
        make.width.equalTo(SCREEN_WIDTH - 200);
        make.height.equalTo(50);
    }];
    
    
    _topLineView = [[UIImageView alloc]init];
    _topLineView.backgroundColor = RGBCOLOR(66, 165, 234);
    [self.view addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_textField.top).offset(-5);
        make.height.equalTo(2);
        make.left.equalTo(50);
        make.right.equalTo(-50);
    }];
    
    _botmLineView = [[UIImageView alloc]init];
    _botmLineView.backgroundColor = RGBCOLOR(66, 165, 234);
    [self.view addSubview:_botmLineView];
    [_botmLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textField.bottom).offset(2);
        make.height.equalTo(2);
        make.left.equalTo(50);
        make.right.equalTo(-50);
    }];
    
    _leftLineView = [[UIImageView alloc]init];
    _leftLineView.backgroundColor = RGBCOLOR(66, 165, 234);
    [self.view addSubview:_leftLineView];
    [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLineView.bottom).offset(-1);
        make.width.equalTo(2);
        make.left.equalTo(50);
        make.bottom.equalTo(_textField.bottom).offset(2);
    }];
    
    _rightLineView = [[UIImageView alloc]init];
    _rightLineView.backgroundColor = RGBCOLOR(66, 165, 234);
    [self.view addSubview:_rightLineView];
    [_rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLineView.bottom).offset(-1);
        make.width.equalTo(2);
        make.right.equalTo(-50);
        make.bottom.equalTo(_textField.bottom).offset(2);
    }];
    
    
    _label = [[UILabel alloc]init];
    _label.text = @"输入编号,获取解锁码";
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_textField.bottom).offset(30);
    }];
    

    _lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lightBtn setImage:[UIImage imageNamed:@"mshare_scan_torch_white"] forState:UIControlStateNormal];
    _lightBtn.layer.cornerRadius = 22;
    _lightBtn.layer.masksToBounds = YES;
    [self.view addSubview:_lightBtn];
    [_lightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_label.bottom).offset(30);
        make.width.height.equalTo(43);
    }];
    [_lightBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setBackgroundColor:RGBCOLOR(66, 165, 234) forState:UIControlStateNormal];
    [_btn setBackgroundColor:RGBCOLOR(66, 180, 255) forState:UIControlStateHighlighted];
    _btn.layer.masksToBounds = YES;
    _btn.layer.cornerRadius = 5;
    [_btn setTitle:@"确认" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(queryBtOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lightBtn.bottom).offset(30);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(50);
    }];
   
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

#pragma  mark 返回
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark-> 确定
-(void)queryBtOnClick:(UIButton*)button
{
    [CommonClass showMBProgressHUD:nil andWhereView:self.view];
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"AppID":APPID,
                                 @"AppType":@"2",
                                 @"GoodsSNID":_textField.text,
                                 @"PhoneNumber":PhoneNum
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:USERITEMDETAIL success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        [CommonClass hideMBprogressHUD:self.view];
        NSString *status = [NSString stringWithFormat:@"%@",responseBody[@"Status"]];
        NSString *addr = responseBody[@"Addr"];
        if ([responseBody[@"Notice"] isEqualToString:@"操作成功"])
        {
            //使用中
            if ([status isEqual:@"2"])
            {
                ProgressViewController *dfc = [[ProgressViewController alloc]init];
                dfc.carNumber = _textField.text;
                dfc.resPonsbody = responseBody;
                [self.navigationController pushViewController:dfc animated:YES];
            }
            //待使用
            else if([status isEqual:@"1"])
            {
                GoodsDetailViewController *gdc = [[GoodsDetailViewController alloc]init];
                gdc.carNumber = _textField.text;
                gdc.addr = addr;
                gdc.resPonsbody = responseBody;
                [self.navigationController pushViewController:gdc animated:YES];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲" message:@"该物品正在审核中" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:OKAction];
                [self.navigationController presentViewController:alertController animated:YES completion:nil];
            }
        }
        else
        {
            if ([status isEqual:@"2"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲" message:@"该物品他人正在使用中" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:OKAction];
                [self.navigationController presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲" message:@"请保证输入正确的物品编号" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:OKAction];
                [self.navigationController presentViewController:alertController animated:YES completion:nil];
            }
        }
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];

}

#pragma mark-> 闪光灯
-(void)openFlash:(UIButton*)button{
    
    button.selected = !button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
    
}
#pragma mark-> 开关闪光灯
- (void)turnTorchOn:(BOOL)on
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [_textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
