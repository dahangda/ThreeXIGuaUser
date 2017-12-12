//
//  TheBillTableViewCell.m
//  hbbciphone
//
//  Created by Handbbc on 2017/11/23.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "TheBillTableViewCell.h"
#import "ThebillModel.h"

@implementation TheBillTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftView = [[UIImageView alloc]init];
        _leftView.image = [UIImage imageNamed:@"头像"];
        [self.contentView addSubview:_leftView];
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(self.mas_centerY);
            make.width.height.equalTo(50);
        }];
    
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_leftView.top).offset(5);
            make.left.equalTo(_leftView.right).offset(10);
        }];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor grayColor];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_leftView.bottom).offset(-5);
            make.left.equalTo(_leftView.right).offset(10);
        }];
        
        
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font = [UIFont systemFontOfSize:20];
        _moneyLabel.textColor = [UIColor redColor];
        [self addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_moneyLabel.left);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}

-(void)setValue:(id)object
{
    ThebillModel *obj = (ThebillModel *)object;
    _timeLabel.text = obj.billTime;
    if ([obj.billType isEqualToString:@"1"])
    {
        _titleLabel.text = @"订单支付";
        _moneyLabel.text =  [[@"-" stringByAppendingString:obj.billMoney] stringByAppendingString:@"元"];
    }
    else
    {
        _titleLabel.text = @"账户充值";
        _moneyLabel.text =  [[@"+" stringByAppendingString:obj.billMoney] stringByAppendingString:@"元"];
    }
}

@end
