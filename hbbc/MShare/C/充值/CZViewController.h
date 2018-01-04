//
//  CZViewController.h
//  hbbciphone
//
//  Created by YanHang on 2018/1/2.
//  Copyright © 2018年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^moneyBlock)(NSString *money);
typedef void(^timeBlock)(NSString *lockTime);
@interface CZViewController : UIViewController
@property (nonatomic,strong)id responsBody;
@property (nonatomic,strong)NSString *GoodsSNID;
@property (nonatomic,strong)NSString *money;
@property (nonatomic,strong)NSString *oldTime;

@property (nonatomic,copy)timeBlock lockTimeBlock;
@property (nonatomic,copy)moneyBlock getMoneyBlock;


@end
