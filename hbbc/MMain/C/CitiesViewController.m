//
//  CitiesViewController.m
//  pgyapp
//
//  Created by HBBC-IMacA on 16/5/28.
//  Copyright © 2016年 handbbc. All rights reserved.
//

#import "CitiesViewController.h"

@interface CitiesViewController ()<UITableViewDelegate,UITableViewDataSource>
/**展示城市数据*/
@property (weak, nonatomic) UITableView *tableView;
@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviUI];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //初始化展示视图
    [self initTableView];
    
}
/**创建导航栏视图*/
- (void)createNaviUI {
    
    self.title = @"选择城市";
    self.navigationController.navigationBar.layer.borderWidth = 0;
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 22)];
    [backButton setImage:[UIImage imageNamed:@"shell_btn_leftbg_p.png"]forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
}
//返回按钮响应事件
-(void)backAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
/**初始化展示城市信息视图*/
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cities.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
    }
    cell.textLabel.text = [_cities[indexPath.row] objectForKey:@"CityName"];
    return cell;
}
#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //代理方法
    [self.delegate changeCities:[_cities[indexPath.row] objectForKey:@"CityName"] andcityCode:[_cities[indexPath.row] objectForKey:@"CityCode"] andIndexPath:self.indexPath];
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT * 0.07;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"全部城市";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
@end
