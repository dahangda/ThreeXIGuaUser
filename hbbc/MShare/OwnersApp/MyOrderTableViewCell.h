//
//  MyOrderTableViewCell.h
//  hbbciphone
//
//  Created by Handbbc on 2017/8/30.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"

typedef void(^orderBlock) (void);
typedef void(^deleteBlock) (void);

@interface MyOrderTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *itemNumber;
@property (nonatomic,strong)UILabel *orderNumber;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *phone;
@property (nonatomic,strong)UIImageView *rightImg;
@property (nonatomic,strong)UILabel *orderTime;
@property (nonatomic,strong)UILabel *orderState;
@property (nonatomic,strong)UILabel *money;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)NSString *states;

@property (nonatomic,copy)orderBlock theOrderBlock;
@property (nonatomic,copy)deleteBlock deleteOrderBlock;

-(void)setValues:(MyOrderModel *)obj;

@end
