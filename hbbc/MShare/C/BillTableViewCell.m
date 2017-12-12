//
//  BillTableViewCell.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/12.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "BillTableViewCell.h"
#import "BillModel.h"

@implementation BillTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftView = [[UIImageView alloc]init];
        [self.contentView addSubview:_leftView];
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(self.mas_centerY);
            make.width.height.equalTo(50);
        }];
        
        
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_leftView.top).offset(5);
            make.left.equalTo(_leftView.right).offset(10);
        }];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:15];
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
    BillModel *obj = (BillModel *)object;
    _leftView.image = [UIImage imageNamed:obj.leftImg];
    _titleLabel.text = obj.titleLabel;
    _timeLabel.text = obj.timeLabel;
    _rightLabel.text = obj.rightLabel;
    _moneyLabel.text = obj.moneyLabel;
}

@end
