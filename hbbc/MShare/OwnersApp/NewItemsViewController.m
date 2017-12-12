//
//  NewItemsViewController.m
//  sdsjOwnerApp
//
//  Created by Handbbc on 2017/8/22.
//  Copyright © 2017年 xushaodong. All rights reserved.
//

#import "NewItemsViewController.h"
#import "HXPhotoView.h"
#import "HXPhotoViewController.h"
#import "NewItemsTableViewCell.h"
#import "NewItemSelectTableViewCell.h"
#import "textFieldView.h"
#import "HXPhotoTools.h"


@interface NewItemsViewController ()<HXPhotoViewDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>



@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *introImg;
@property (nonatomic,strong) UILabel *placeholderLabel;
@property (nonatomic,strong) UITextView *textView;
//主页面的tableview
@property (nonatomic,strong) UITableView *aTableView;
@property (nonatomic,strong)NewItemsTableViewCell *cell;
//左边label数组
@property (nonatomic,strong)NSMutableArray *itemInfoArr;
//左边图像数组
@property (nonatomic,strong)NSArray *itemImgArr;
//右边lable数组
@property (nonatomic,strong)NSMutableArray *rightLabelArr;
//点击cell时的蒙版效果
@property (nonatomic,strong)UIView *mengbanView;

//选择框的cell
@property (nonatomic,strong)NewItemSelectTableViewCell *selectCell;

//物品类型可选数组及对应ID
@property (nonatomic,strong)NSMutableArray *typeArr;
@property (nonatomic,strong)NSMutableArray *typeIDArr;
@property (nonatomic,strong)UITableView *typeTableView;
//业务模式可选数组
@property (nonatomic,strong)NSArray *businessModelArr;
@property (nonatomic,strong)UITableView *businessModelTableView;
//使用价格
@property (nonatomic,strong)textFieldView *priceFieldView;
//定金金额
@property (nonatomic,strong)textFieldView *textFieldView;
//标签数组
@property (nonatomic,strong)NSArray *typeList;
//标签可选数组
@property (nonatomic,strong)NSMutableArray *labelOptionArr;

@property (nonatomic,strong)NSArray *firstLabelArr;
@property (nonatomic,strong)NSArray *secondLabelArr;
@property (nonatomic,strong)NSArray *thirdLabelArr;
//第一个标签
@property (nonatomic,strong)UITableView *firstTableView;
//第二个标签
@property (nonatomic,strong)UITableView *secondTableView;
//第三个标签
@property (nonatomic,strong)UITableView *thirdTableView;

@property (nonatomic,strong)NSArray *photos;
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,strong)NSMutableArray *imagesArr;
@property (nonatomic,strong)NSString *GoodsTypeID;
@property (nonatomic,strong)NSString *BusinessType;
@property (nonatomic,strong)NSString *GoodsUsePrice;
@property (nonatomic,strong)NSString *GoodsDeposit;
@property (nonatomic,strong)NSString *LabelContent;

@end

@implementation NewItemsViewController

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.openCamera = YES;
        _manager.cacheAlbum = YES;
        _manager.lookLivePhoto = YES;
        _manager.outerCamera = YES;
        _manager.lookGifPhoto = NO;
        _manager.open3DTouchPreview = YES;
        _manager.cameraType = HXPhotoManagerCameraTypeSystem;
        _manager.photoMaxNum = 9;
        //        _manager.videoMaxNum = 0;
        _manager.maxNum = 9;
        _manager.saveSystemAblum = NO;
        _manager.selectTogether = NO;
        //        _manager.rowCount = 3;
    }
    return _manager;
}

- (NSMutableArray *)imagesArr
{
    if (!_imagesArr)
    {
        _imagesArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _imagesArr;
}

- (NSMutableArray *)typeArr
{
    if (!_typeArr)
    {
        _typeArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _typeArr;
}

- (NSMutableArray *)typeIDArr
{
    if (!_typeIDArr)
    {
        _typeIDArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _typeIDArr;
}

- (NSArray *)typeList
{
    if (!_typeList)
    {
        _typeList = [NSArray array];
    }
    return _typeList;
}


- (NSMutableArray *)labelOptionArr
{
    if (!_labelOptionArr)
    {
        _labelOptionArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _labelOptionArr;
}


- (NSMutableArray *)itemInfoArr
{
    if (!_itemInfoArr)
    {
        _itemInfoArr = [NSMutableArray arrayWithCapacity:1];
        [_itemInfoArr addObjectsFromArray: @[@"物品类型",@"业务模式",@"使用价格",@"定金"]];
    }
    return _itemInfoArr;
}

- (NSMutableArray *)rightLabelArr
{
    if (!_rightLabelArr)
    {
        _rightLabelArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _rightLabelArr;
}

- (NSArray *)firstLabelArr
{
    if (!_firstLabelArr)
    {
        _firstLabelArr = [NSArray array];
    }
    return _firstLabelArr;
}

- (NSArray *)secondLabelArr
{
    if (!_secondLabelArr)
    {
        _secondLabelArr = [NSArray array];
    }
    return _secondLabelArr;
}

- (NSArray *)thirdLabelArr
{
    if (!_thirdLabelArr)
    {
        _thirdLabelArr = [NSArray array];
    }
    return _thirdLabelArr;
}

-(UITableView *)aTableView
{
    if(!_aTableView)
    {
        _aTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _aTableView.dataSource = self;
        _aTableView.delegate = self;
        _aTableView.scrollEnabled = NO;
        [_aTableView setSeparatorInset:UIEdgeInsetsZero];
        [_aTableView setLayoutMargins:UIEdgeInsetsZero];
        [_aTableView registerClass:[NewItemsTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
        [_scrollView addSubview:_aTableView];
        [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_textView.bottom).offset(15);
            make.left.equalTo(0);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(38 * 7);
        }];
    }
    return _aTableView;
}

-(UITableView *)typeTableView
{
    if(!_typeTableView)
    {
        _typeTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _typeTableView.dataSource = self;
        _typeTableView.delegate = self;
        _typeTableView.scrollEnabled = NO;
        _typeTableView.layer.cornerRadius = 5;
        [_typeTableView setSeparatorInset:UIEdgeInsetsZero];
        [_typeTableView setLayoutMargins:UIEdgeInsetsZero];
        [_typeTableView registerClass:[NewItemSelectTableViewCell class] forCellReuseIdentifier:@"typeTableViewCell"];
        [self.view addSubview:_typeTableView];
        [_typeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_centerY);
            make.left.equalTo(50);
            make.right.equalTo(-50);
            make.height.equalTo( _typeArr.count * 38);
        }];
    }
    return _typeTableView;
}

-(UITableView *)businessModelTableView
{
    if(!_businessModelTableView)
    {
        _businessModelTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _businessModelTableView.dataSource = self;
        _businessModelTableView.delegate = self;
        _businessModelTableView.scrollEnabled = NO;
        _businessModelTableView.layer.cornerRadius = 5;
        [_businessModelTableView setSeparatorInset:UIEdgeInsetsZero];
        [_businessModelTableView setLayoutMargins:UIEdgeInsetsZero];
        [_businessModelTableView registerClass:[NewItemSelectTableViewCell class] forCellReuseIdentifier:@"typeTableViewCell"];
        [self.view addSubview:_businessModelTableView];
        [_businessModelTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_centerY);
            make.left.equalTo(50);
            make.right.equalTo(-50);
            make.height.equalTo(38 * 2);
        }];
    }
    return _businessModelTableView;
}

-(UITableView *)firstTableView
{
    if(!_firstTableView)
    {
        _firstTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _firstTableView.dataSource = self;
        _firstTableView.delegate = self;
        _firstTableView.scrollEnabled = NO;
        _firstTableView.layer.cornerRadius = 5;
        [_firstTableView setSeparatorInset:UIEdgeInsetsZero];
        [_firstTableView setLayoutMargins:UIEdgeInsetsZero];
        [_firstTableView registerClass:[NewItemSelectTableViewCell class] forCellReuseIdentifier:@"typeTableViewCell"];
        [self.view addSubview:_firstTableView
         ];
        [_firstTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_centerY);
            make.left.equalTo(50);
            make.right.equalTo(-50);
            make.height.equalTo(38 * _firstLabelArr.count);
        }];
    }
    return _firstTableView;
}

-(UITableView *)secondTableView
{
    if(!_secondTableView)
    {
        _secondTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _secondTableView.dataSource = self;
        _secondTableView.delegate = self;
        _secondTableView.scrollEnabled = NO;
        _secondTableView.layer.cornerRadius = 5;
        [_secondTableView setSeparatorInset:UIEdgeInsetsZero];
        [_secondTableView setLayoutMargins:UIEdgeInsetsZero];
        [_secondTableView registerClass:[NewItemSelectTableViewCell class] forCellReuseIdentifier:@"typeTableViewCell"];
        [self.view addSubview:_secondTableView
         ];
        [_secondTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_centerY);
            make.left.equalTo(50);
            make.right.equalTo(-50);
            make.height.equalTo(38 * _thirdLabelArr.count);
        }];
    }
    return _secondTableView;
}

-(UITableView *)thirdTableView
{
    if(!_thirdTableView)
    {
        _thirdTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _thirdTableView.dataSource = self;
        _thirdTableView.delegate = self;
        _thirdTableView.scrollEnabled = NO;
        _thirdTableView.layer.cornerRadius = 5;
        [_thirdTableView setSeparatorInset:UIEdgeInsetsZero];
        [_thirdTableView setLayoutMargins:UIEdgeInsetsZero];
        [_thirdTableView registerClass:[NewItemSelectTableViewCell class] forCellReuseIdentifier:@"typeTableViewCell"];
        [self.view addSubview:_thirdTableView
         ];
        [_thirdTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_centerY);
            make.left.equalTo(50);
            make.right.equalTo(-50);
            make.height.equalTo(38 * _secondLabelArr.count);
        }];
    }
    return _thirdTableView;
}

-(UIView *)mengbanView
{
    if (!_mengbanView)
    {
        _mengbanView = [[UIView alloc]initWithFrame:self.view.frame];
        _mengbanView.backgroundColor = [UIColor blackColor];
        _mengbanView.alpha = 0.5;
    }
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMengbanView:)];
    //将触摸事件添加到当前view
    [_mengbanView addGestureRecognizer:tapGestureRecognizer];
    return _mengbanView;
}

-(void)hideMengbanView:(UITapGestureRecognizer*)tap
{
    _mengbanView.hidden = YES;
    self.typeTableView.hidden = YES;
    self.businessModelTableView.hidden = YES;
    self.priceFieldView.hidden = YES;
    self.textFieldView.hidden = YES;
    self.firstTableView.hidden = YES;
    self.secondTableView.hidden = YES;
    self.thirdTableView.hidden = YES;
}
-(textFieldView *)textFieldView
{
    if (!_textFieldView)
    {
        _textFieldView = [[textFieldView alloc]init];
        _textFieldView.textField.placeholder = @"请输入定金金额";
        [self.view addSubview:_textFieldView];
        [_textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_centerY);
            make.height.equalTo(100);
            make.left.equalTo(50);
            make.right.equalTo(-50);
        }];
        [_textFieldView.btn addTarget:self action:@selector(ensureDeposit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _textFieldView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonClass showMBProgressHUD:nil andWhereView:self.view];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"新增物品";
    UIButton *btnLeft =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [btnLeft setImage:[UIImage imageNamed:@"sharenavigation_back"] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btnLeft];
    [self getGoodsTypeInfo];
    
}

-(void)getGoodsTypeInfo
{
    NSDictionary *parameters = @{
                                 @"ECID":OwnerECID,
                                 @"PhoneNumber":@"15093337480",
                                 @"AppType":@"1"
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:GETITEMTYPE success:^(id responseBody){DHResponseBodyLog(responseBody);
        NSLog(@"%@",responseBody[@"Notice"]);
        NSArray *typeArr = responseBody[@"GoodsTypeList"];
        for (int i = 0; i < typeArr.count; i++)
        {
            NSString *type = [typeArr[i] objectForKey:@"GoodsTypeName"];
            [self.typeArr addObject:type];
            NSString *typeID = [NSString stringWithFormat:@"%@",[typeArr[i] objectForKey:@"GoodsTypeID"]];
            [self.typeIDArr addObject:typeID];
        }
        
        self.typeList = responseBody[@"TypeLabelList"];

        NSString *goodsTypeID = _typeIDArr[0];
        for (int i = 0; i < _typeList.count; i++)
        {
            
                        NSString * typeId =  [NSString stringWithFormat:@"%@",[_typeList[i] objectForKey:@"GoodsTypeID"]];
                        if ([typeId isEqualToString:goodsTypeID])
                        {
                            NSString *type = [_typeList[i] objectForKey:@"LabelName"];
                            [self.itemInfoArr addObject:type];//添加标签到cell数组
                        }

            NSString *labelOption = [NSString stringWithFormat:@"%@",[_typeList[i] objectForKey:@"LabelOption"]];
            [self.labelOptionArr addObject:labelOption];
        }
        _firstLabelArr = [_labelOptionArr[0] componentsSeparatedByString:@","];
        _thirdLabelArr = [_labelOptionArr[1] componentsSeparatedByString:@","];
        _secondLabelArr = [_labelOptionArr[2] componentsSeparatedByString:@","];
        [self.rightLabelArr addObjectsFromArray:@[_typeArr[0],@"扫码使用",@"0元/次",@"0元",_firstLabelArr[0],_thirdLabelArr[0],_secondLabelArr[0]]];
        [self initUI];
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
    
}
-(void)initUI
{
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _scrollView.backgroundColor = RGBCOLOR(245, 245, 245);
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _photoView = [HXPhotoView photoManager:self.manager];
    _photoView.frame = CGRectMake(0, 69, SCREEN_WIDTH, 0);
    _photoView.delegate = self;
    _photoView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_photoView];
    
    _introImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introLabel"]];
    [_scrollView addSubview:_introImg];
    [_introImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_photoView.bottom).offset(12);
        make.left.equalTo(25);
        make.width.height.equalTo(18);
    }];
    
    UILabel *introLabel = [[UILabel alloc]init];
    [_scrollView addSubview:introLabel];
    introLabel.text = @"物品介绍";
    introLabel.font = [UIFont systemFontOfSize:16];
    [introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_introImg.mas_centerY);
        make.left.equalTo(_introImg.right).offset(3);
    }];
    
    _textView = [[UITextView alloc]init];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.textColor = [UIColor grayColor];
    _textView.delegate = self;
    [_scrollView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introImg.bottom).offset(12);
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(130);
    }];
    
    
    _placeholderLabel = [[UILabel alloc]init];
    _placeholderLabel.text = @"请输入物品介绍...";
    _placeholderLabel.textColor = [UIColor grayColor];
    _placeholderLabel.font = [UIFont systemFontOfSize:16];
    [_textView addSubview:_placeholderLabel];
    [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(_introImg.left);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    
    _itemImgArr = @[@"sharer_red_circle",@"sharer_yellow_circle",@"sharer__cyan_circle",@"sharer_light_blue_circle",@"sharer_pink_circle",@"sharer_blue_circle",@"sharer_orange_circle"];
    _businessModelArr = @[@"扫码使用",@"付定金使用"];
    [_scrollView addSubview:self.aTableView];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.backgroundColor = RGBCOLOR(66, 165, 234);
    submit.layer.cornerRadius = 5;
    [submit setTitle:@"提交审核" forState:UIControlStateNormal];
    [self.view addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(50);
        make.bottom.equalTo(-15);
    }];
    [submit addTarget:self action:@selector(commitJson) forControlEvents:UIControlEventTouchUpInside];
    
    [CommonClass hideMBprogressHUD:self.view];
}
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal
{
    [HXPhotoTools getImageForSelectedPhoto:photos type:HXPhotoToolsFetchHDImageType completion:^(NSArray *images)
     {
         _images = images;
         //        for (UIImage *image in images)
         //        {
         //            if (image.images.count > 0)
         //            {
         //                // 到这里了说明这个image  是个gif图
         //            }
         //        }
     }];
}
// 根据选择图片的数量重新计算scrollview的滚动范围
- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(frame) + 42 + 130+15+38*7 + 60);
    
}

// 提交审核，调取接口信息
-(void)commitJson
{
    NewItemsTableViewCell *cell1 = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    for (int i = 0; i < _typeArr.count; i++)
    {
        if([cell1.rightLabel.text isEqualToString:_typeArr[i]])
        {
            _GoodsTypeID = _typeIDArr[i];
        }
    }
    
    NewItemsTableViewCell *cell2 = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if ([cell2.rightLabel.text isEqualToString:@"扫码使用"])
    {
        _BusinessType = @"1";
    }
    else
    {
        _BusinessType = @"2";
        
    }
    NewItemsTableViewCell *cell3 = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSRange range =  [cell3.rightLabel.text rangeOfString:@"元"];
    _GoodsUsePrice = [cell3.rightLabel.text substringToIndex:range.location];
    NewItemsTableViewCell *cell4 = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    _GoodsDeposit = [cell4.rightLabel.text substringToIndex:range.location];
    [self.imagesArr removeAllObjects];
    //将图片进行base64加密
    for (int i = 0; i < _images.count; i++)
    {
        NSData *data = UIImageJPEGRepresentation(_images[i], 0.5);
        NSString *theImgStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self.imagesArr addObject:theImgStr];
    }
    _LabelContent = @"";
    for (int i = 4; i < _itemInfoArr.count; i++)
    {
        NewItemsTableViewCell *cell = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i  inSection:0]];
        
        NSString *labelContent =  [[[_itemInfoArr[i] stringByAppendingString:@","] stringByAppendingString:cell.rightLabel.text] stringByAppendingString:@";"];
        _LabelContent = [_LabelContent stringByAppendingString:labelContent];
    }
    if (_imagesArr.count < 3)
    {
        [CommonClass showAlertWithMessage:@"请上传最少3张图片"];
    }
    else
    {
    NSDictionary *parameters = @{
                                 @"ECID":OwnerECID,
                                 @"PhoneNumber":@"15093337480",
                                 @"PicList":self.imagesArr,
                                 @"GoodsIntroduceText":_textView.text,
                                 @"GoodsTypeID":_GoodsTypeID,
                                 @"BusinessType":_BusinessType,
                                 @"GoodsUsePrice":_GoodsUsePrice,
                                 @"GoodsDeposit":_GoodsDeposit,
                                 @"LabelContent":_LabelContent,
                                 @"GoodsSNID":@""
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:COMMITNEWGOODS success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        [CommonClass showAlertWithMessage:@"已提交,等待审核中"];
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_aTableView])
    {
        return _itemInfoArr.count;
    }
    else if ([tableView isEqual:_typeTableView])
    {
        return _typeArr.count;
    }
    else if ([tableView isEqual:_businessModelTableView])
    {
        return _businessModelArr.count;
    }
    
    else if ([tableView isEqual:_firstTableView])
    {
        return _firstLabelArr.count;
    }
    else if ([tableView isEqual:_secondTableView])
    {
        return _thirdLabelArr.count;
    }
    else if ([tableView isEqual:_thirdTableView])
    {
        return _secondLabelArr.count;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_aTableView])
    {
        _cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
        [_cell.leftImg setImage:[UIImage imageNamed:_itemImgArr[indexPath.row]]];
        _cell.leftLabel.text = _itemInfoArr[indexPath.row];
        _cell.rightLabel.text =  _rightLabelArr[indexPath.row];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 2 || indexPath.row == 3)
        {
            _cell.rightImg.hidden = YES;
        }
        return _cell;
    }
    else if ([tableView isEqual:_typeTableView])
    {
        _selectCell = [tableView dequeueReusableCellWithIdentifier:@"typeTableViewCell"];
        _selectCell.label.text = _typeArr[indexPath.row];
        _selectCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0)
        {
            _selectCell.btn.selected = YES;
        }
        return _selectCell;
    }
    else if ([tableView isEqual:_businessModelTableView])
    {
        _selectCell = [tableView dequeueReusableCellWithIdentifier:@"typeTableViewCell"];
        _selectCell.label.text = _businessModelArr[indexPath.row];
        _selectCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0)
        {
            _selectCell.btn.selected = YES;
        }
        return _selectCell;
    }
    else if ([tableView isEqual:_firstTableView])
    {
        _selectCell = [tableView dequeueReusableCellWithIdentifier:@"typeTableViewCell"];
        _selectCell.label.text = _firstLabelArr[indexPath.row];
        _selectCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0)
        {
            _selectCell.btn.selected = YES;
        }
        return _selectCell;
    }
    else if ([tableView isEqual:_secondTableView])
    {
        _selectCell = [tableView dequeueReusableCellWithIdentifier:@"typeTableViewCell"];
        _selectCell.label.text = _thirdLabelArr[indexPath.row];
        _selectCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0)
        {
            _selectCell.btn.selected = YES;
        }
        return _selectCell;
    }
    else if ([tableView isEqual:_thirdTableView])
    {
        _selectCell = [tableView dequeueReusableCellWithIdentifier:@"typeTableViewCell"];
        _selectCell.label.text = _secondLabelArr[indexPath.row];
        _selectCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0)
        {
            _selectCell.btn.selected = YES;
        }
        return _selectCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_aTableView])
    {
        [self.view addSubview:self.mengbanView];
        _mengbanView.hidden = NO;
        switch (indexPath.row) {
            case 0:
                [self.view addSubview:self.typeTableView];
                _typeTableView.hidden = NO;
                break;
            case 1:
                [self.view addSubview:self.businessModelTableView];
                _businessModelTableView.hidden = NO;
                break;
            case 2:
            {
                _priceFieldView = [[textFieldView alloc]init];
                _priceFieldView.textField.placeholder = @"请输入使用价格";
                [self.view addSubview:_priceFieldView];
                [_priceFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(50);
                    make.right.equalTo(-50);
                    make.height.equalTo(100);
                    make.centerY.equalTo(self.view.mas_centerY);
                }];
                [_priceFieldView.btn addTarget:self action:@selector(ensurePrice) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 3:
                [self.view addSubview:self.textFieldView];
                self.textFieldView.hidden = NO;
                break;
            case 4:
            {
                [self.view addSubview:self.firstTableView];
                _firstTableView.hidden = NO;
            }
                break;
            case 5:
            {
                [self.view addSubview:self.secondTableView];
                _secondTableView.hidden = NO;
            }
                break;
            case 6:
            {
                [self.view addSubview:self.thirdTableView];
                _thirdTableView.hidden = NO;
            }
                break;
            default:
                break;
        }
    }
    else if ([tableView isEqual:_typeTableView])
    {
        _typeTableView.hidden = YES;
        _mengbanView.hidden = YES;
        NSString *goodsTypeID = _typeIDArr[indexPath.row];
        [_itemInfoArr removeAllObjects];
        [_itemInfoArr addObjectsFromArray: @[@"物品类型",@"业务模式",@"使用价格",@"定金"]];
        [_labelOptionArr removeAllObjects];
        for (int i = 0; i < _typeList.count; i++)
        {
            NewItemSelectTableViewCell *cell = [self.typeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.btn.selected = NO;
            if (i == indexPath.row)
            {
                cell.btn.selected = YES;
            }
            NSString * typeId =  [NSString stringWithFormat:@"%@",[_typeList[i] objectForKey:@"GoodsTypeID"]];
            if ([typeId isEqualToString:goodsTypeID])
            {
                NSString *type = [_typeList[i] objectForKey:@"LabelName"];
                [self.itemInfoArr addObject:type];//添加标签到cell数组
                NSString *labelOption = [NSString stringWithFormat:@"%@",[_typeList[i] objectForKey:@"LabelOption"]];
                [self.labelOptionArr addObject:labelOption];
            }
        }
        _firstLabelArr = [_labelOptionArr[0] componentsSeparatedByString:@","];
        _thirdLabelArr = [_labelOptionArr[1] componentsSeparatedByString:@","];
        _secondLabelArr = [_labelOptionArr[2] componentsSeparatedByString:@","];
        
        
        if ([self.rightLabelArr[0] isEqualToString:_typeArr[indexPath.row]])
        {
        }
        else
        {
            for (int i = 0; i < _firstLabelArr.count; i++)
            {
                NewItemSelectTableViewCell *cell = [self.firstTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                cell.btn.selected = NO;
                if (i == 0)
                {
                    cell.btn.selected = YES;
                }
            }
            for (int i = 0; i <  _secondLabelArr.count; i++)
            {
                NewItemSelectTableViewCell *cell = [self.secondTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                cell.btn.selected = NO;
                if (i == 0)
                {
                    cell.btn.selected = YES;
                }
            }
            for (int i = 0; i < _thirdLabelArr.count; i++)
            {
                NewItemSelectTableViewCell *cell = [self.thirdTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                cell.btn.selected = NO;
                if (i == 0)
                {
                    cell.btn.selected = YES;
                }
            }
            //改变大tableview右边label的数据
            [self.rightLabelArr replaceObjectAtIndex:0 withObject:_typeArr[indexPath.row]];
            [self.rightLabelArr replaceObjectAtIndex:4 withObject:_firstLabelArr[0]];
            [self.rightLabelArr replaceObjectAtIndex:5 withObject:_thirdLabelArr[0]];
            [self.rightLabelArr replaceObjectAtIndex:6 withObject:_secondLabelArr[0]];
            
            [_aTableView reloadData];
            [self.firstTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(_firstLabelArr.count * 38);
            }];
            self.firstTableView.hidden = YES;
            [_firstTableView reloadData];
            
            [self.secondTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(_thirdLabelArr.count * 38);
            }];
            self.secondTableView.hidden = YES;
            [_secondTableView reloadData];
            
            [self.thirdTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(_secondLabelArr.count * 38);
            }];
            self.thirdTableView.hidden = YES;
            [_thirdTableView reloadData];
        }
    }
    else if ([tableView isEqual:_businessModelTableView])
    {
        _businessModelTableView.hidden = YES;
        _cell = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        _cell.rightLabel.text = _businessModelArr[indexPath.row];
        for (int i = 0; i < _businessModelArr.count; i++)
        {
            NewItemSelectTableViewCell *cell = [_businessModelTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.btn.selected = NO;
            if (i == indexPath.row)
            {
                cell.btn.selected = YES;
            }
        }
        switch (indexPath.row)
        {
            case 0:
                self.mengbanView.hidden = YES;
                break;
            case 1:
                self.mengbanView.hidden = YES;
                self.textFieldView.hidden = NO;
                break;
            default:
                break;
        }
    }
    else if ([tableView isEqual:_firstTableView])
    {
        _firstTableView.hidden = YES;
        self.mengbanView.hidden = YES;
        _cell = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        _cell.rightLabel.text = _firstLabelArr[indexPath.row];
        for (int i = 0; i < _firstLabelArr.count; i++)
        {
            NewItemSelectTableViewCell *cell = [_firstTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.btn.selected = NO;
            if (i == indexPath.row)
            {
                cell.btn.selected = YES;
            }
        }
    }
    else if ([tableView isEqual:_secondTableView])
    {
        _secondTableView.hidden = YES;
        self.mengbanView.hidden = YES;
        _cell = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        _cell.rightLabel.text = _thirdLabelArr[indexPath.row];
        for (int i = 0; i < _thirdLabelArr.count; i++)
        {
            NewItemSelectTableViewCell *cell = [_secondTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.btn.selected = NO;
            if (i == indexPath.row)
            {
                cell.btn.selected = YES;
            }
        }
    }
    
    else if ([tableView isEqual:_thirdTableView])
    {
        _thirdTableView.hidden = YES;
        self.mengbanView.hidden = YES;
        _cell = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
        _cell.rightLabel.text = _secondLabelArr[indexPath.row];
        for (int i = 0; i < _secondLabelArr.count; i++)
        {
            NewItemSelectTableViewCell *cell = [_thirdTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.btn.selected = NO;
            if (i == indexPath.row)
            {
                cell.btn.selected = YES;
            }
        }
    }
    
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ensurePrice
{
    [_priceFieldView.textField resignFirstResponder];
    _priceFieldView.hidden = YES;
    _cell = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    _cell.rightLabel.text = [NSString stringWithFormat:@"%@元/次",_priceFieldView.textField.text];
    _mengbanView.hidden = YES;
}

-(void)ensureDeposit
{
    [_textFieldView.textField resignFirstResponder];
    _textFieldView.hidden = YES;
    _cell = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    _cell.rightLabel.text = [NSString stringWithFormat:@"%@元",_textFieldView.textField.text];
    _mengbanView.hidden = YES;
}





#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _placeholderLabel.hidden = YES;
    _textView.text = @"\t";
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [_textView resignFirstResponder];
    self.textFieldView.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
