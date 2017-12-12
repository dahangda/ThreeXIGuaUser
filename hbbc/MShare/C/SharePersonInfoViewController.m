//
//  SharePersonInfoViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/14.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "SharePersonInfoViewController.h"
#import "SharePersonInforView.h"
#import "SharePersonInfoModel.h"

@interface SharePersonInfoViewController ()


@property (nonatomic,strong)NSArray *objcArr;

@property (nonatomic,strong)SharePersonInforView *spiv;


@end

@implementation SharePersonInfoViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.title = @"关于我们";
    
    _spiv = [[SharePersonInforView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_spiv];
    [self json];
}


-(void)json
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:ABOUTUS success:^(id responseBody){DHResponseBodyLog(responseBody);
        NSLog(@"%@",responseBody[@"Notice"]);
        _objcArr = [AssignToObject customModel:@"SharePersonInfoModel" ToDictionary:responseBody];
        [_spiv setValues:_objcArr[0]];
    }
                                          failed:^(NSError *error)
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
