//
//  ShareSearchViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/12.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "ShareSearchViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface ShareSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate>{
    
    
    UITableView* atableView;
    // 保存原始表格数据的NSArray对象。
    NSMutableArray* searchData;
    // 是否搜索变量
    bool isSearch;
}

@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UITableViewCell *acell;
@property(nonatomic,strong)AMapSearchAPI *search;

@end

@implementation ShareSearchViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 默认没有开始搜索
    isSearch = NO;
    searchData = [NSMutableArray arrayWithCapacity:1];
    // 创建UISearchBar对象
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, 35)];
    UIBarButtonItem * searchButton = [[UIBarButtonItem alloc]initWithCustomView:_searchBar];
    self.navigationItem.leftBarButtonItem = searchButton;
    [_searchBar becomeFirstResponder];
    //     设置搜索背景色
    _searchBar.barTintColor = RGBCOLOR(66, 165, 234);
    // 显示右侧Cancel按钮并将其自定义为”取消“，注意这个按钮颜色设置必须放在前面这个bartintcolor后面，不然颜色会被覆盖
    _searchBar.showsCancelButton = true;
    UIButton *cancelbtn = [_searchBar valueForKey:@"cancelButton"];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 设置没有输入时的提示占位符
    _searchBar.placeholder = @"请输入关键字";
    //    设置输入文字颜色
    _searchBar.tintColor = [UIColor blackColor];
    
    //    设置左侧搜索图片
    [_searchBar setImage:[UIImage imageNamed:@"mshare_search_icon_green.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    // 设置代理
    _searchBar.delegate = self;
    
    // 创建UITableView
    atableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 设置代理
    atableView.dataSource = self;
    atableView.delegate = self;

    atableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [atableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    //    设置头部视图
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *labelLeft = [[UILabel alloc]init];
    labelLeft.text = @"我的位置";
    [headerView addSubview:labelLeft];
    [labelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.bottom.equalTo(-5);
    }];
    UILabel *labelRight = [[UILabel alloc]init];
    labelRight.textColor = [UIColor grayColor];
    labelRight.font = [UIFont systemFontOfSize:13];
    labelRight.text = _myLocation;
    [headerView addSubview:labelRight];
    [labelRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelLeft.right).offset(5);
        make.bottom.equalTo(labelLeft.bottom);
    }];
    UIImageView *lineView = [[UIImageView alloc]init];
    lineView.backgroundColor = RGBCOLOR(245, 245, 245);
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    atableView.tableHeaderView = headerView;
    // 添加UITableView
    [self.view addSubview:atableView];
    
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
//    atableView.contentSize = CGSizeMake(0, 1000);
}

#pragma mark - UITableViewDataSource

// 返回表格分区数，默认返回1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    //    NSInteger rowNumber;
    // 如果处于搜索状态
    //    if(isSearch)
    //    {
    // 使用searchData作为表格显示的数据
    //        rowNumber = searchData.count;
    //    }
    //    else
    //    {
    //        // 否则使用原始的tableData座位表格显示的数据
    //        rowNumber = tableData.count;
    //    }
    //    return rowNumber;
    NSLog(@"%@",searchData);
    return searchData.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString* cellId = @"cellId";
    // 从可重用的表格行队列中获取表格行
    _acell = [tableView  dequeueReusableCellWithIdentifier:@"cellId"];
    // 如果表格行为nil
//    if(!_acell)
//    {
//        // 创建表格行
//        _acell = [[UITableViewCell alloc] initWithStyle:
//                  UITableViewCellStyleDefault
//                                        reuseIdentifier:cellId];
//    }
    // 获取当前正在处理的表格行的行号
    NSInteger rowNo = indexPath.row;
    // 如果处于搜索状态
    //    if(isSearch)
    //    {
    // 使用searchData作为表格显示的数据
    NSString *cellName = [[searchData objectAtIndex:rowNo] valueForKey:@"name"];
    _acell.textLabel.text = cellName;
    //    }
    //    else{
    // 否则使用原始的tableData作为表格显示的数据
    //        _acell.textLabel.text = [tableData objectAtIndex:rowNo];
    //    }
    return _acell;
}


#pragma mark -UItableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _acell = [atableView cellForRowAtIndexPath:indexPath];
    _searchBar.text = [_acell valueForKey:@"text"];
    if (self.aBlock)
    {
        self.aBlock(_searchBar.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchBarDelegate

// UISearchBarDelegate定义的方法，用户单击取消按钮时激发该方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searchBar.text = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

// UISearchBarDelegate定义的方法，当搜索文本框内文本改变时激发该方法
- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
    if([_searchBar.text  isEqual: @""] )
    {
        isSearch = NO;
        [atableView reloadData];
    }
    else
    {
        // 调用filterBySubstring:方法执行搜索
        [self filterBySubstring:searchText];
    }
    
}

// UISearchBarDelegate定义的方法，用户单击虚拟键盘上Search按键时激发该方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:searchBar.text];
    if (self.aBlock)
    {
        self.aBlock(_searchBar.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) filterBySubstring:(NSString*) subStr
{
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    //关键字
    tipsRequest.keywords = _searchBar.text;
    tipsRequest.city = @"北京";
    //执行搜索
    [_search AMapInputTipsSearch: tipsRequest];
    
}

-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [searchData removeAllObjects];
    searchData = [NSMutableArray arrayWithArray:response.tips];
    [atableView reloadData];
}



@end
