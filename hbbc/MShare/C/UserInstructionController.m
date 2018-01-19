//
//  UserInstructionController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/14.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "UserInstructionController.h"
#import "MJRefresh.h"
#import "AssignToObject.h"

@interface UserInstructionController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UIImageView *leftImg;
@property (nonatomic,strong)UIImageView *rightImg;
@property (nonatomic,strong)UILabel *lefttitleLabel;
@property (nonatomic,strong)UILabel *rightTitleLabel;
@property (nonatomic,strong)UIImageView *leftLine;
@property (nonatomic,strong)UIImageView *rightLine;
@property (nonatomic,strong)UIImageView *lineImg;

@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)UITableViewCell *acell;
@property (nonatomic,strong)NSArray *messageArr;

@end

@implementation UserInstructionController

#pragma mark ********************talbeview

-(UITableView *)aTableView
{
    if(!_aTableView)
    {
        _aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -50, SCREEN_WIDTH, 900) style:UITableViewStyleGrouped];
        _aTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
        
        self.aTableView.sectionFooterHeight = 0;
        _aTableView.dataSource = self;
        _aTableView.delegate = self;
        [_aTableView setSeparatorInset:UIEdgeInsetsZero];
        [_aTableView setLayoutMargins:UIEdgeInsetsZero];
        _aTableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
        [_aTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
        _aTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self performSelector:@selector(refreshCell) withObject:nil afterDelay:0];
        }];
        [_aTableView.mj_header beginRefreshing];
        [self.view addSubview:_aTableView];
        [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_rightLine.bottom);
            make.left.equalTo(0);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(SCREEN_HEIGHT);
        }];
    }
    return _aTableView;
}

-(void)refreshCell
{
    if (_leftBtn.selected)
    {
        [self ajson];
    }
    else
    {
        [self bjson];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
  self.view.backgroundColor = RGBCOLOR(92, 177, 236);
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerView];
    
    UIImageView *imgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 25, 25)];
    [imgLeft setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *btnLeft =[[UIButton alloc]initWithFrame:CGRectMake(0, 30, 80, 25)];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btnLeft addSubview:imgLeft];
    [self.view addSubview:btnLeft];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"我的消息";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(btnLeft.mas_centerY);
    }];
#pragma mark ********************中间线

    _lineImg = [[UIImageView alloc]init];
    _lineImg.backgroundColor = RGBCOLOR(245, 245, 245);
    [self.view addSubview:_lineImg];
    [_lineImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(1);
        make.height.equalTo(30);
    }];
#pragma mark ********************左边按钮

    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   
    _leftBtn.selected = YES;
    [self.view addSubview:_leftBtn];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(_lineImg.left);
        make.top.equalTo(titleLabel.bottom).offset(5);
        make.height.equalTo(40);
    }];
    [_leftBtn addTarget:self  action:@selector(systemNews) forControlEvents:UIControlEventTouchUpInside];
#pragma mark ********************右边按钮

    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lineImg.right);
        make.right.equalTo(0);
        make.top.equalTo(titleLabel.bottom).offset(5);
        make.height.equalTo(40);
    }];
    [_rightBtn addTarget:self  action:@selector(businessNews) forControlEvents:UIControlEventTouchUpInside];
#pragma mark ********************左边图片

    _leftImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mshare_system_message_selected"]];
    [self.view addSubview:_leftImg];
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(20);
        make.top.equalTo(70);
        make.left.equalTo(40);
    }];
    
 #pragma mark ********************左边lable
    _lefttitleLabel = [[UILabel alloc]init];
    _lefttitleLabel.text = @"系统通知";
    _lefttitleLabel.textAlignment = NSTextAlignmentCenter;
    _lefttitleLabel.textColor = RGBCOLOR(92, 177, 236);
    _lefttitleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_lefttitleLabel];
    [_lefttitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(_leftImg.bottom).offset(5);
        make.left.equalTo(_leftImg.right).offset(10);
        make.centerY.equalTo(_leftImg.mas_centerY);
    }];
    
    _leftLine = [[UIImageView alloc]init];
    _leftLine.backgroundColor = RGBCOLOR(92, 177, 236);
    [self.view addSubview:_leftLine];
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_headerView.bottom);
        make.height.equalTo(2);
        make.left.equalTo(0);
        make.right.equalTo(_lineImg.left);
    }];
#pragma mark ********************右边图片

    _rightImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mshare_business_message_unselected"]];
    [self.view addSubview:_rightImg];
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(20);
        make.top.equalTo(70);
        make.right.equalTo(- SCREEN_WIDTH / 4 - 30);
    }];
#pragma mark ********************右边lable
    _rightTitleLabel = [[UILabel alloc]init];
    _rightTitleLabel.text = @"业务通知";
    _rightTitleLabel.textAlignment = NSTextAlignmentCenter;
    _rightTitleLabel.textColor = [UIColor blackColor];
    _rightTitleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_rightTitleLabel];
    [_rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rightImg.right).offset(10);
        make.centerY.equalTo(_rightImg.mas_centerY);
    }];
    
    _rightLine = [[UIImageView alloc]init];
    _rightLine.backgroundColor = RGBCOLOR(92, 177, 236);;
    [self.view addSubview:_rightLine];
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_headerView.bottom);
        make.height.equalTo(2);
        make.right.equalTo(0);
        make.left.equalTo(_lineImg.right);
    }];
    _rightLine.hidden = YES;
    
    [self ajson];
    

}

-(void)ajson
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:SYSTEMNEWS success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        [_aTableView.mj_header endRefreshing];
        _messageArr = [responseBody objectForKey:@"MessageList"];
        [self.aTableView reloadData];
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

-(void)bjson
{
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":PhoneNum,
                                 @"AppType":@"2",
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:BUSSINESSNEWS success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        [_aTableView.mj_header endRefreshing];
        _messageArr = [responseBody objectForKey:@"MessageList"];
        [self.aTableView reloadData];
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

-(void)systemNews
{
    _leftBtn.selected = YES;
    _rightBtn.selected = NO;
    _leftImg.image = [UIImage imageNamed:@"mshare_system_message_selected"];
    _rightImg.image = [UIImage imageNamed:@"mshare_business_message_unselected"];
    _lefttitleLabel.textColor = RGBCOLOR(92, 177, 236);
    _rightTitleLabel.textColor = [UIColor grayColor];
    _leftLine.hidden = NO;
    _rightLine.hidden = YES;
    [self ajson];
}

-(void)businessNews
{
    _rightBtn.selected = YES;
    _leftBtn.selected = NO;
    _leftImg.image = [UIImage imageNamed:@"mshare_system_message_unselected"];
    _rightImg.image = [UIImage imageNamed:@"mshare_business_message_selected"];
    _rightTitleLabel.textColor =  RGBCOLOR(92, 177, 236);;
    _lefttitleLabel.textColor = [UIColor grayColor];
    _leftLine.hidden = YES;
    _rightLine.hidden = NO;
    [self bjson];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _messageArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TableViewCell"];
    NSURL *messagePic = [NSURL URLWithString:[_messageArr[indexPath.row] objectForKey:@"MessageTypePic"]];
    [cell.imageView sd_setImageWithURL:messagePic placeholderImage:[UIImage imageNamed:@"yewutongzhi"]];
    cell.textLabel.text = [_messageArr[indexPath.row] objectForKey:@"MessageName"];
    cell.detailTextLabel.text = [_messageArr[indexPath.row] objectForKey:@"MessageContent"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
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

