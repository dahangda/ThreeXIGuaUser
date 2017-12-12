//
//  BillModel.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/12.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "BillModel.h"

@implementation BillModel

-(id)initWithLeftImg:(NSString *)lef andTitleLabel:(NSString *)ta andTimeLabel:(NSString *)tl andRightLable:(NSString *)rl andMoneyLabel:(NSString *)ml
{
    if (self = [super init])
    {
        self.leftImg = lef;
        self.titleLabel = ta;
        self.timeLabel = tl;
        self.rightLabel = rl;
        self.moneyLabel = ml;
    }
    return self;
}

@end
