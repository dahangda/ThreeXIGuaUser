//
//  ProgressViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/11/9.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "ProgressViewController.h"
#import "GoodsDetailViewController.h"
#import "openLockViewController.h"
#import "LDProgressView.h"

@interface ProgressViewController ()

@property (nonatomic,strong)UIImageView  *imgView;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong)NSString *endTime;
@property (nonatomic,strong)NSString *money;


@end

@implementation ProgressViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"扫码开锁";
    //设置结束时间为空，若开锁成功则不为空
    _endTime = @"";

    
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
    
    LDProgressView *   progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(50, SCREEN_HEIGHT/2, SCREEN_WIDTH - 100, 20)];
    progressView.color = [UIColor colorWithRed:0.00f green:0.64f blue:0.00f alpha:1.00f];
    progressView.flat = @YES;
    progressView.showBackgroundInnerShadow = @NO;
    progressView.progress = 0.9999;//目标进度，若为1，则默认无动画
    progressView.showText = @NO;//展示进度
    progressView.animate = @YES;//动画
    progressView.type = LDProgressStripes;
    [self.view addSubview:progressView];
    
    _label = [[UILabel alloc]init];
    _label.textColor = RGBCOLOR(29, 133, 28);
    _label.text = @"正在开锁，耐心等候";
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(progressView.top).offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self performSelector:@selector(ajson) withObject:nil afterDelay:1];
}


-(void)ajson
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"AppType":@"2",
                                 @"PhoneNumber":PhoneNum,
                                 @"GoodsSNID":_carNumber,
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:openHouseLock success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        if ([responseBody[@"Notice"] isEqualToString:@"操作成功"])
        {
            openLockViewController *olvc = [[openLockViewController alloc]init];
            olvc.resPonsbody = _resPonsbody;
            olvc.endTime = responseBody[@"UnlockingEndTime"];
//            olvc.result = @"开锁成功";
            olvc.carNumber = _carNumber;
            [self.navigationController pushViewController:olvc animated:YES];
        }

    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}


#pragma  mark 返回
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
