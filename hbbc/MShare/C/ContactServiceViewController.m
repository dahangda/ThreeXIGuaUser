//
//  ContactServiceViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/8/1.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "ContactServiceViewController.h"

@interface ContactServiceViewController ()<UITextViewDelegate>

@end

@implementation ContactServiceViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.title = @"联系客服";
    
    _textView = [[UITextView alloc]init];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.textColor = [UIColor grayColor];
    self.textView.delegate = self;
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(70);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(150);
    }];
    
    _placeholderLabel = [[UILabel alloc]init];
    _placeholderLabel.text = @" 请输入您对我们的意见(请输入至少10个字)";
    _placeholderLabel.textColor = [UIColor grayColor];
    _placeholderLabel.font = [UIFont systemFontOfSize:16];
    [_textView addSubview:_placeholderLabel];
    [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn  setTitle:@"提交" forState:UIControlStateNormal];
    [_btn setBackgroundColor:RGBCOLOR(66, 165, 234) forState:UIControlStateNormal];
    [_btn setBackgroundColor:RGBCOLOR(66, 180, 255) forState:UIControlStateHighlighted];
    _btn.layer.masksToBounds = YES;
    _btn.layer.cornerRadius = 5;
    [self.view addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(_textView.bottom).offset(60);
        make.height.equalTo(50);
    }];
    [_btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)submit
{
    [CommonClass showMBProgressHUD:@"正在提交" andWhereView:self.view];
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":[[NSUserDefaults standardUserDefaults]objectForKey:@"PhoneNumber"],
                                 @"CSFeedback":_textView.text,
                                 @"AppType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:SUBMITUSERADVICE success:^(id responseBody){DHResponseBodyLog(responseBody);
        NSLog(@"%@",responseBody[@"Notice"]);
        [CommonClass hideMBprogressHUD:self.view];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"亲，我们已收到您的意见" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:OKAction];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];

    }
     failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

#pragma  mark 返回
-(void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _placeholderLabel.hidden = YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [_textView resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
