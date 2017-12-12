//
//  TheMainViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/8/25.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "TheMainViewController.h"
#import "UserInforViewController.h"
#import "NewItemsViewController.h"
#import "MyItemsViewController.h"
#import "MyOrderViewController.h"
#import "UserInstructionController.h"


#define btnWidth (SCREEN_WIDTH - 30) / 2
@interface TheMainViewController ()


@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)NSArray *classArr;
@property (nonatomic,strong)NSArray *imgArr;


@end

@implementation TheMainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(66, 165, 234);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _classArr = @[@"NewItemsViewController",@"MyItemsViewController",@"MyOrderViewController",@"UserInstructionController"];
    _imgArr = @[@"newItems",@"myItems",@"myOrder",@"myNews"];
    [self initNaviBar];
    [self initUI];
}

-(void)initNaviBar
{
    self.title = @"共享挖掘机";
    UIButton *btnLeft =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btnLeft setImage:[UIImage imageNamed:@"mshare_menu"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btnLeft];
    [btnLeft addTarget:self action:@selector(UserInfor) forControlEvents:UIControlEventTouchUpInside];
}

-(void)UserInfor
{
    [self.navigationController pushViewController:[[UserInforViewController alloc]init] animated:YES];
}

-(void)initUI
{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner"]];
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(64);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(180);
    }];
    
    for (int i = 0; i < 4; i++)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.layer.cornerRadius = 3;
        _btn.tag = i;
        [self.view addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView.bottom).offset(15 + i/2 * 115);
            make.left.equalTo(10 + i%2 * (btnWidth + 10));
            make.width.equalTo(btnWidth);
            make.height.equalTo(100);
        }];
        [_btn setImage:[UIImage imageNamed:_imgArr[i]] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)jump:(UIButton *)button
{
    long aa = button.tag;
    NSString *className = _classArr[aa];
    UIViewController *subViewController = [[NSClassFromString(className)alloc]init];
    [self.navigationController pushViewController:subViewController animated:YES];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
