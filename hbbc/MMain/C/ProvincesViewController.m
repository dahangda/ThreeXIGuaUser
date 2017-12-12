
//
//  LocationViewController.m
//  pgyapp
//
//  Created by HBBC-IMacA on 16/5/28.
//  Copyright © 2016年 handbbc. All rights reserved.
//

#import "ProvincesViewController.h"
#import "CitiesViewController.h"
#import "AccountInfo.h"

@interface ProvincesViewController ()<UITableViewDelegate,UITableViewDataSource,CitiesViewDelegate>
/**展示省份信息的视图*/
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *citiesInProvinces;
@property (strong, nonatomic) NSString *choseCityName;//选中的城市名
@property (strong, nonatomic) NSString *choseCityCode;//选中的cityCode
@property (strong, nonatomic) NSIndexPath *choseIndexPath;//选中的省份位置
@property (strong, nonatomic) NSString *selectedProvince;//本次选中的省份
@end

@implementation ProvincesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviUI];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //分离出省份和城市
    NSArray *location = [self.locationString componentsSeparatedByString:@"-"];
    //置空
    self.choseCityCode = [NSString string];
    self.choseCityName = location[1];
    self.choseIndexPath = [NSIndexPath new];
    self.selectedProvince = location[0];
    //初始化展示视图
    [self initTableView];
}

/**创建导航栏视图*/
- (void)createNaviUI {
    
    self.title = @"选择省份";
    self.navigationController.navigationBar.layer.borderWidth = 0;
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 22)];
    [backButton setImage:[UIImage imageNamed:@"shell_btn_leftbg_p.png"]forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
}
//返回按钮响应事件
-(void)backAction:(UIButton *)button{
    NSString *choseLocal = [NSString stringWithFormat:@"%@-%@",self.selectedProvince,self.choseCityName];
    if([choseLocal isEqualToString:self.locationString]){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSString *userID;
    if ([AccountInfo sharepeopleInfo].PersonFlag == 1) {
        userID = [AccountInfo sharepeopleInfo].ManagerID;
    } else {
        userID = [AccountInfo sharepeopleInfo].MemberID;
    }

    NSDictionary *parameters = @{
                                 @"PersonFlag":@([AccountInfo sharepeopleInfo].PersonFlag),
                                 @"AppUserID":APPUSERID,
                                 @"UserID":userID,
                                 @"HeadPicFieldID":@"",
                                 @"Sex":@"",
                                 @"ProvinceCode":[_provinces[self.choseIndexPath.row] objectForKey:@"ProvinceCode"],
                                 @"CityCode":self.choseCityCode,
                                 @"Address":@""
                                 };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkSingleton shareManager] httpRequest:parameters url:SETUSERINFO success:^(id responseBody) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSInteger Result = [[responseBody objectForKey:@"Result"] integerValue];
        if(Result == 1){
            [BaseUtil toast:@"修改成功"];
            [self.delegate changeInfoDelegate:choseLocal andIndex:self.currentIndexPath];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [BaseUtil toast:@"修改失败"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failed:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@",error);
    }];

}
/**初始化展示省份的视图*/
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else{
        return _provinces.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"provinceCell"];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"provinceCell"];
    }
    if(indexPath.section == 0){
        cell.textLabel.text = _locationString;
    }else{
        cell.textLabel.text = [_provinces[indexPath.row] objectForKey:@"ProvinceName"];
    }
    return cell;
}
#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //记录选中的省份名
    self.selectedProvince = [_provinces[indexPath.row] objectForKey:@"ProvinceName"];
    
    [self.citiesInProvinces removeAllObjects];
    //遍历获得城市信息
    for(NSDictionary *dic in self.cities){
        if([[dic objectForKey:@"ProvinceCode"] isEqualToString:[self.provinces[indexPath.row] objectForKey:@"ProvinceCode"]]){
            [self.citiesInProvinces addObject:dic];
        }
    }
    CitiesViewController *citiesVC = [[CitiesViewController alloc] init];
    citiesVC.delegate = self;
    citiesVC.cities = _citiesInProvinces;
    citiesVC.indexPath = indexPath;
    [self.navigationController pushViewController:citiesVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT * 0.07;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"当前地区";
    }else{
        return @"全部省份";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
#pragma mark - CitiesViewDelegate
- (void)changeCities:(NSString *)cityName andcityCode:(NSString *)cityCode andIndexPath:(NSIndexPath *)indexPath{
    self.choseCityCode = cityCode;
    self.choseCityName = cityName;
    self.choseIndexPath = indexPath;
}
#pragma mark - 懒加载
- (NSMutableArray *)citiesInProvinces{
    if(!_citiesInProvinces){
        _citiesInProvinces = [NSMutableArray array];
    }
    return _citiesInProvinces;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
