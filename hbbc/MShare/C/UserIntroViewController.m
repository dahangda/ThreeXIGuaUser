//
//  UserIntroViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/31.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "UserIntroViewController.h"
#import "UserInforTableViewCell.h"
#import "UserProtocalViewController.h"
#import "PayMoneyProtocalViewController.h"
#import "MoneyIntroViewController.h"


@interface UserIntroViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *aTableView;
@property (nonatomic,assign)NSArray *questionArr;
@property (nonatomic,strong)NSArray *imgArr;




@end

@implementation UserIntroViewController



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
    self.navigationItem.title = @"用户指南";
    
    
    
    _questionArr = @[@"用户协议",@"充值协议",@"押金说明"];
    _imgArr = @[@"用户协议",@"充值协议",@"押金说明"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _aTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _aTableView.dataSource = self;
    _aTableView.delegate = self;
    _aTableView.scrollEnabled = NO;
    [_aTableView setSeparatorInset:UIEdgeInsetsZero];
    [_aTableView setLayoutMargins:UIEdgeInsetsZero];
    _aTableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
    [self.view addSubview:_aTableView];
    [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(74);
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(132);
    }];
}


#pragma  mark 返回
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInforTableViewCell *cell = [[UserInforTableViewCell alloc]init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.leftLabel.text = _questionArr[indexPath.row];
    [cell.leftView setImage:[UIImage imageNamed:_imgArr[indexPath.row]]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[UserProtocalViewController alloc]init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[PayMoneyProtocalViewController alloc]init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[MoneyIntroViewController alloc]init] animated:YES];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
