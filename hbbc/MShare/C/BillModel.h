//
//  BillModel.h
//  hbbciphone
//
//  Created by Handbbc on 2017/10/12.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillModel : NSObject



@property (nonatomic,strong)NSString *leftImg;
@property (nonatomic,strong)NSString *titleLabel;
@property (nonatomic,strong)NSString *timeLabel;
@property (nonatomic,strong)NSString *rightLabel;
@property (nonatomic,strong)NSString *moneyLabel;

-(id)initWithLeftImg:(NSString *)lef andTitleLabel:(NSString *)ta andTimeLabel:(NSString *)tl andRightLable:(NSString *)rl andMoneyLabel:(NSString *)ml;

@end
