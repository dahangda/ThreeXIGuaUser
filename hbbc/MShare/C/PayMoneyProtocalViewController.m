//
//  PayMoneyProtocalViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/13.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "PayMoneyProtocalViewController.h"

@interface PayMoneyProtocalViewController ()

@property(nonatomic,strong)UIScrollView *scroView;
@property (nonatomic,strong)UILabel *introText;


@end

@implementation PayMoneyProtocalViewController


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
    self.navigationItem.title = @"充值协议";
    
    _scroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scroView.alwaysBounceVertical = YES;
    _scroView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scroView];

    _scroView.contentSize = CGSizeMake(0, 500);
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"《充返活动协议》";
    [self.scroView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scroView.mas_centerX);
        make.top.equalTo(0);
    }];
    
    _introText = [[UILabel alloc]init];
    _introText.numberOfLines = 0;
    _introText.text = @"尊敬的用户，为保障您的合法权益，请您在参加充值活动前仔细阅读本规则，以免造成误解。当您点击“马上充值”按钮后，即视为您已阅读、理解本协议，并同意按本协议的规定参与充值。\n特别说明\n2.1余额构成：\n余额是指您实际支付的充值本金加上共享挖掘机的返现金额会构成您的账户余额（人民币）；\n2.2充值余额有效期：\n充值及返现金额有期限为自充值日起至用完即止；\n2.3余额使用规则：\n包含充值赠送余额在内的余额可用于支付共享挖掘机用物品订单费用，但不能用于支付押金或转赠。\n2.4余额花费及退款规则：\n用户使用期间会优先使用您实际充值支付的充值金额。当您未产生用物品费用时，可退还当期实际充值金额。若您已产生用物品费用，可退款扣除您在用物品费用中实际发生的用物品费用后的实际剩余充值金额（实际剩余充值金额=实际充值金额-实际用物品费用）。退款后，该笔充值金额所对应的共享挖掘机返现金额将全部失效。共享挖掘机会在您申请退款服务之日起10个工作日内为您办理退款。\n邀请好友充值活动退款说明：若用户同时参与充返活动及邀请好友活动，获得赠送金额可以累加。但是退款时需遵循充返余额退款规则。用户使用期间会优先使用您实际支付的充值金额。当您未产生用物品费用时，可退还当期实际充值金额。若您已产生用物品费用，可退款扣除您在用物品费用中实际发生的用物品费用后的实际剩余充值金额（实际剩余充值金额=实际充值金额-实际用物品费用）。共享挖掘机会在您申请退款服务之日起10个工作日内为您办理退款。\n2.5 提现规则：\n提现后会在1-5个工作日内到达账户绑定的支付宝或微信账户，如超过1-5个工作日未到账请联系共享挖掘机官方客服010-5537-7883。\n提现的金额不能用于支付共享挖掘机押金或转赠。\n每个用户每天只能提现一次。\n什么情况下会导致提现不成功？\n共享挖掘机官方会对所有提现申请进行审核，若发现您未正常、正当地参与提现活动，包括但不限于利用活动规则从事作弊行为以获取不正当经济利益的情形，共享挖掘机官方会拒绝为您提现。\n2.5正当性保证\n我们包含充值赠送在内的所有优惠推广活动仅面向正当、合法使用我们物品的用户。一旦您存在利用我们的规则漏洞进行任何形式的作弊行为（包括但不限于通过我们的活动获得不正当的经济利益），我们有权取消与作弊行为相关账户赠送金额、追回您作弊所得的不正当经济利益、关闭作弊账户或与您相关的所有账户，并保留取消您后续使用我们服务/物品辆的权利，及依据严重程度追究您的法律责任。\n2.6 特别说明                                                                             目前只支持微信，支付宝的退款。";
    [_scroView addSubview:_introText];
    [_introText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.top.equalTo(titleLabel.bottom);
    }];
    NSDictionary *attre = @{NSFontAttributeName:_introText.font};
    CGSize maxSize = CGSizeMake(SCREEN_WIDTH, MAXFLOAT);
    CGSize size = [_introText.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attre context:nil].size;
    _scroView.contentSize = CGSizeMake(0, size.height + 150);
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
