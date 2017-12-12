//
//  MyMessageView.m
//  hbbciphone
//
#import "MyMessageView.h"
#import "MyMessageCollectionViewCell.h"
#import "TopScroll.h"
#import "MessageTypeModel.h"

/**collectionView的重用标识符*/
static NSString *reuseIdentifier = @"UICollectionViewCell";
static CGFloat topScrollHeight = 75.0;

@interface MyMessageView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) MyMessageViewController *viewController;            //页面视图控制器
@property (nonatomic, strong) UICollectionView *mainView;                       //collectionView
@property (nonatomic, weak) TopScroll *topScrollView;                         //顶部标签滚动视图
@property (nonatomic, weak) NSMutableArray *dataArray;                        //数据源

@end

@implementation MyMessageView

- (instancetype)initWithFrame:(CGRect)frame withViewController:(MyMessageViewController *)viewController {
    self = [super initWithFrame:frame];
    if (self) {
        _viewController = viewController;
    }
    
    [self initComponents];
    
    return self;
}



//加载显示的控件
- (void)initComponents {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    
    [self createNaviUI];
    
    //创建配置主控件
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    //设置为水平方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, topScrollHeight, self.width, SCREEN_HEIGHT - topScrollHeight) collectionViewLayout:layout];
    mainView.backgroundColor = [UIColor cyanColor];
    _mainView = mainView;
    layout.itemSize = mainView.bounds.size;
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.pagingEnabled = YES;
    mainView.scrollsToTop = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    [mainView registerClass:[MyMessageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self addSubview:mainView];
    
    //categoryView
    TopScroll *topScroll = [[TopScroll alloc] initWithFrame:CGRectMake(0, 0, self.width, topScrollHeight)];
    topScroll.backgroundColor = SYSTERMCOLOR;
    
    _dataArray = [NSMutableArray array];
    
    for (NSDictionary *dic in _messageTypeList) {
        MessageTypeModel *model = [MessageTypeModel mj_objectWithKeyValues:dic];
        [_dataArray addObject:model];
    }
//    topScroll.titlesArray = self.titles;
    [topScroll setMainView:_mainView];
    self.topScrollView = topScroll;
    [self addSubview:self.topScrollView];
    
}



/**创建导航栏视图*/
- (void)createNaviUI{
    self.viewController.title = @"我的消息";
    self.viewController.navigationController.navigationBar.layer.borderWidth = 0;
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 22)];
    [backButton setImage:[UIImage imageNamed:@"shell_btn_leftbg_p.png"]forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.viewController.navigationItem.leftBarButtonItem = backItem;
}



/**页面即将出现*/
- (void)viewWillAppear {
    NSLog(@"%@", _messageTypeList);
    for (NSDictionary *dic in _messageTypeList) {
        MessageTypeModel *model = [MessageTypeModel mj_objectWithKeyValues:dic];
        [_dataArray addObject:model];
    }
    [_mainView reloadData];
}



/**页面即将消失*/
- (void)viewWillDisappear {
    [_mainView removeObserver:_topScrollView forKeyPath:@"contentOffset"];
}



#pragma mark - CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyMessageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}



#pragma mark - 按钮点击事件
//返回按钮点击事件
- (void)backAction:(UIButton *)button {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}


@end
