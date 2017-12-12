//
//  PayResultViewController.h
//  hbbciphone
//
//  Created by Handbbc on 2017/12/6.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^moneyBlock)(NSString *money);

@interface PayResultViewController : UIViewController

@property (nonatomic,strong)NSString *carNumber;
@property (nonatomic,strong)NSString *lockResult;
@property (nonatomic,strong)NSString *money;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *resultLabel;
@property (nonatomic,strong)NSString *endTime;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *btmBtn;

@property (nonatomic,copy)moneyBlock getMoneyBlock;

@end
