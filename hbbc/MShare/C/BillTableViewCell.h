//
//  BillTableViewCell.h
//  hbbciphone
//
//  Created by Handbbc on 2017/10/12.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillTableViewCell : UITableViewCell



@property (nonatomic,strong)UIImageView *leftView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;


@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UILabel *moneyLabel;

-(void)setValue:(id)object;

@end
