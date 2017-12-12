//
//  BillViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/11.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "BillViewController.h"
#import "BillHeaderView.h"
#import "BillModel.h"
#import "BillTableViewCell.h"

@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;
@property (nonatomic,strong)BillHeaderView *headerView;

@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *timeArr;
@property (nonatomic,strong)NSArray *moneyArr;
@property (nonatomic,strong)NSMutableArray *arr;



@end

@implementation BillViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(NSMutableArray *)arr
{
    if (!_arr)
    {
        _arr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleArr = @[@"提现",@"付押金",@"退还押金",@"充值"];
    _timeArr = @[@"2017.10.8  9:56",@"2017.10.7  11:20",@"2017.10.5  11:20",@"2017.10.5  7:20"];
    _moneyArr = @[@"200.00",@"88.00",@"800.00",@"50.00"];
    
    self.title = @"我的账单";
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    _sectionArray = [NSMutableArray array];
    _flagArray  = [NSMutableArray array];
    [_flagArray addObject:@"1"];
    [_flagArray addObject:@"0"];
    [_sectionArray addObject:@[@"2",@"1"]];
    [_sectionArray addObject:@[@"3",@"4",@"44",@"23"]];
    
    
    _aTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _aTableView.dataSource = self;
    _aTableView.delegate = self;
    [_aTableView registerClass:[BillTableViewCell class] forCellReuseIdentifier:@"ReuseBillCell"];
    _aTableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
    [self.view addSubview:_aTableView];
    [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(64);
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_HEIGHT - 64);
    }];
    
    for (int i = 0; i < 4; i++)
    {
        BillModel *billModel = [[BillModel alloc]initWithLeftImg:@"头像" andTitleLabel:_titleArr[i] andTimeLabel:_timeArr[i] andRightLable:_titleArr[i] andMoneyLabel:_moneyArr[i]];
        [self.arr addObject:billModel];
    }
    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _sectionArray[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_flagArray[indexPath.section] isEqualToString:@"0"])
        return 0;
    else
        return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [[UITableViewCell alloc]init];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    cell.textLabel.text = @"押金";
//    cell.detailTextLabel.text = @"2017.10.8";
//    cell.imageView.image = [UIImage imageNamed:@"头像"];
//    
//    cell.clipsToBounds = YES;
    BillTableViewCell *cell = nil;
    BillModel *model = _arr[indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseBillCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clipsToBounds = YES;
    [cell setValue:model];
    
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerView = [[BillHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _headerView.tag = 100 + section;
    
    switch (section) {
        case 0:
            _headerView.alabel.text = @"本月";
            break;
        case 1:
            _headerView.alabel.text = @"全部";
            break;
        default:
            break;
    }
    
    int index = _headerView.tag % 100;
    if ([_flagArray[index] isEqualToString:@"0"])
    {
        _headerView.abtn.selected = NO;
    }
    else
    {
        _headerView.abtn.selected = YES;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
    [_headerView addGestureRecognizer:tap];
    return _headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    footerView.backgroundColor = [UIColor whiteColor];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (void)sectionClick:(UITapGestureRecognizer *)tap{
    
    int index = tap.view.tag % 100;
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSArray *arr = _sectionArray[index];
    for (int i = 0; i < arr.count; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
    
    //找到点击的是哪个headview
    BillHeaderView *headView =  (BillHeaderView *)[self.view viewWithTag:tap.view.tag];
    headView.abtn.userInteractionEnabled = NO;
    if (headView.abtn.selected)
    {
        headView.abtn.selected = NO;
    }
    else
    {
        headView.abtn.selected = YES;
    }

    //判断是展开还是收起
    if ([_flagArray[index] isEqualToString:@"0"])//要展开
    {
        _flagArray[index] = @"1";
        
        [_aTableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
    } else { //要收起
        _flagArray[index] = @"0";
        [_aTableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
    }
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
