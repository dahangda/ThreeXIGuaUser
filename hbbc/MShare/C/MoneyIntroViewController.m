//
//  MoneyIntroViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/13.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "MoneyIntroViewController.h"

@interface MoneyIntroViewController ()

@property(nonatomic,strong)UIScrollView *scroView;
@property (nonatomic,strong)UILabel *introText;

@end

@implementation MoneyIntroViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
    [backImg setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.title = @"押金说明";
    _scroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scroView.alwaysBounceVertical = YES;
    _scroView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scroView];
    
    _scroView.contentSize = CGSizeMake(0, 500);
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"《押金退款》";
    [self.scroView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scroView.mas_centerX);
        make.top.equalTo(0);
    }];
    
    _introText = [[UILabel alloc]init];
    _introText.numberOfLines = 0;
    _introText.text = @"退押金请点击APP左上角的标志，“我的钱包”->屏幕下方“查看”->“退回押金”。\n正常情况下您随时可以申请退还押金，共享挖掘机收到退款申请后会立即为您办理退款手续。\n押金通常在2-7个工作日退回到您的原支付账户，但具体到账时间会根据不同支付方式而有所差别。\n押金是您使用共享挖掘机服务的前提之一，对于已经缴纳押金的用户，一旦退款您将无法使用物品，账户内优惠券也将在押金退款成功后自动清零。\n一下情况用户无法申请退还押金：物品使用中，欠费，信用分为负值。\n用户在补交费用欠费/信用分重回正值后，即可通过上述方式退还押金。\n如押金超过7个工作日未到账，请联系共享挖掘机客服：010-5537-7883.";
    [_scroView addSubview:_introText];
    [_introText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.top.equalTo(titleLabel.bottom);
    }];

}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
