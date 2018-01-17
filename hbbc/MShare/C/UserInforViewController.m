//
//  UserInforViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/31.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "UserInforViewController.h"
#import "UserInforTableViewCell.h"
#import "UserInforModel.h"
#import "UserIntroViewController.h"
#import "UserInstructionController.h"
#import "ContactServiceViewController.h"
#import "SharePersonInfoViewController.h"
#import "RegistViewController.h"
#import "MyWalletViewController.h"
#import "CertainViewController.h"
#import "ChargeInViewController.h"
#import "MyOrderViewController.h"
#import "textttViewController.h"
#import "MyOrdersViewController.h"

@interface UserInforViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)UITableViewCell *acell;
@property (nonatomic,strong)UIButton *imgBtn;
@property (nonatomic,assign)NSArray *imgArray;
@property (nonatomic,assign)NSArray *labelArray;
@property(nonatomic,strong)NSMutableArray *arr;
@property (nonatomic,strong)UIImagePickerController *upc;





@end

@implementation UserInforViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(92, 177, 236);
    
    _labelArray = [NSArray arrayWithObjects:@"用户指南",@"我的消息",@"联系客服",@"关于我们",@"我的钱包",@"我的订单",nil];
    _imgArray = [NSArray arrayWithObjects:@"mshare_guide_icon",@"mshare_message_icon",@"mshare_contact_icon",@"mshare_info_about_us_icon",@"我的钱包",@"我的订单",nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _aTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _aTableView.dataSource = self;
    _aTableView.delegate = self;
    _aTableView.scrollEnabled = NO;
    _aTableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
    [_aTableView setSeparatorInset:UIEdgeInsetsZero];
    [_aTableView setLayoutMargins:UIEdgeInsetsZero];
    [_aTableView registerClass:[UserInforTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    headerView.backgroundColor = [UIColor whiteColor];
    //[UIColor whiteColor];
    //RGBCOLOR(92, 177, 236);
    
#pragma mark ********************tableView头

    _aTableView.tableHeaderView = headerView;
    self.aTableView.sectionHeaderHeight = 10;
    self.aTableView.sectionFooterHeight = 0;
    [self.view addSubview:_aTableView];
    [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(64);
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_HEIGHT);
    }];
    
    for (int i = 0; i < 6; i++)
    {
        UserInforModel *userModel = [[UserInforModel alloc]initWithLeftImg:_imgArray[i] andLeftLabel:_labelArray[i]];
        [self.arr addObject:userModel];
    }
#pragma mark ********************返回按钮

    UIImageView *imgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 25, 25)];
    [imgLeft setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *btnLeft =[[UIButton alloc]initWithFrame:CGRectMake(0, 30, 80, 25)];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btnLeft addSubview:imgLeft];
    [self.view addSubview:btnLeft];
#pragma mark ********************tlttile
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"个人信息";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(btnLeft.mas_centerY);
    }];
#pragma mark ********************头像

    _imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imgBtn setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    [self.view addSubview:_imgBtn];
    [_imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgLeft.mas_centerX).offset(20);
        make.top.equalTo(titleLabel.bottom).offset(30);
        make.width.height.equalTo(84);
    }];
    _imgBtn.layer.cornerRadius = 42;
    _imgBtn.layer.masksToBounds = YES;
    [_imgBtn addTarget:self action:@selector(changePhoto) forControlEvents:UIControlEventTouchUpInside];
 #pragma mark ********************头像lable
    UILabel *nameLabel = [[UILabel alloc]init];
    if ([PhoneNum isEqualToString:@""] || PhoneNum == nil)
    {
        nameLabel.text = @"请登录";
    }
    else
    {
        nameLabel.text = PhoneNum;
    }

    nameLabel.textColor = [UIColor grayColor];
    nameLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(-20);
        make.centerY.equalTo(_imgBtn.mas_centerY).offset(20);
    }];
    
   #pragma mark ********************昵称lable
    UILabel *niChengLabel = [[UILabel alloc]init];
    if ([PhoneNum isEqualToString:@""] || PhoneNum == nil)
    {
        niChengLabel.text = @"请登录";
    }
    else
    {
        niChengLabel.text = @"昵称暂无";
    }
    
    niChengLabel.textColor = [UIColor blackColor];
    niChengLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:niChengLabel];
    [niChengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(-20);
        make.centerY.equalTo(_imgBtn.mas_centerY).offset(-10);
    }];
    
    
#pragma mark ********************注销按钮

    
    UIButton *btmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btmBtn setTitle:@"注销" forState:UIControlStateNormal];
    btmBtn.layer.cornerRadius = 5;
    [btmBtn setBackgroundColor:RGBCOLOR(92, 177, 236) forState:UIControlStateNormal];
    [btmBtn setBackgroundColor:RGBCOLOR(227, 62, 65) forState:UIControlStateHighlighted];
    [self.view addSubview:btmBtn];
    [btmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-10);
        make.height.equalTo(40);
        make.left.equalTo(30);
        make.right.equalTo(-30);
    }];
    [btmBtn addTarget:self action:@selector(goToLoad) forControlEvents:UIControlEventTouchUpInside];
    
}

-(NSMutableArray *)arr
{
    if (!_arr)
    {
        _arr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _arr;
}


#pragma mark - UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview = nil;
    headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    return headerview;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 3;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu",section);
    NSUInteger section_number = 0;
    if (section == 0) {
        section_number = 3;
    }
    else if (section == 1){
        section_number = 2;
        
    }
    else if(section == 2){
        
           section_number = 1;
    }
    return section_number ;
}


-(UIImagePickerController *)upc
{
    if (!_upc)
    {
        _upc = [[UIImagePickerController alloc]init];
        _upc.delegate = self;
    }
    return _upc;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInforTableViewCell *cell = nil;
    
      NSLog(@"%lu-------------------%lu",indexPath.section,indexPath.row);
    if (indexPath.section == 0) {
        UserInforModel *model = _arr[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell  setValue:model];
        
    }
   else if (indexPath.section == 1) {
       UserInforModel *model = _arr[indexPath.row + 3];
       cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       [cell  setValue:model];
       
    }
   else if (indexPath.section == 2){
  
    UserInforModel *model = _arr[indexPath.row + 5];
    cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell  setValue:model];
      
   }
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section == 0) {
         NSLog(@"%lu-------------------%lu",indexPath.section,indexPath.row);
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[[UserIntroViewController alloc]init] animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:[[UserInstructionController alloc]init] animated:YES];
                break;
            case 2:
                
                [self.navigationController pushViewController:[[ContactServiceViewController alloc]init] animated:YES];
            break;
                
        }
    }
    if (indexPath.section == 1) {
         NSLog(@"%lu-------------------%lu",indexPath.section,indexPath.row);
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[[SharePersonInfoViewController alloc]init] animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:[[MyWalletViewController alloc]init] animated:YES];
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 2) {
         NSLog(@"%lu-------------------%lu",indexPath.section,indexPath.row);
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[[MyOrdersViewController alloc]init] animated:YES];
                break;
            default:
                break;
    }
   
        
    
    
}
}

-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}

-(void)changePhoto
{
    UIAlertController *uac = [UIAlertController alertControllerWithTitle:@"亲" message:@"请选择更换头像方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            //设置类型
            self.upc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            //相机属性(图片是否可编辑)
            _upc.allowsEditing = YES;
            //调出相机
            [self presentViewController:_upc animated:YES completion:nil];
        }
    }];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            self.upc.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_upc animated:YES completion:nil];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [uac addAction:photoAction];
    [uac addAction:takePhotoAction];
    [uac addAction:cancelAction];
    [self presentViewController:uac animated:YES completion:nil];
}

#pragma  mark 返回
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [_imgBtn setImage:info[@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
}


-(void)goToLoad
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定退出登录吗" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"exitLogin" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertController addAction:ensureAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
