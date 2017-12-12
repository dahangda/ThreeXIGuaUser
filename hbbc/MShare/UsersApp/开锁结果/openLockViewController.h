//
//  openLockViewController.h
//  hbbciphone
//
//  Created by Handbbc on 2017/11/20.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^moneyBlock)(NSString *money);

@interface openLockViewController : UIViewController

@property (nonatomic,strong)id  resPonsbody;
@property (nonatomic,strong)NSString *result;

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
