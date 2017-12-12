//
//  NewItemsTableViewCell.m
//  hbbciphone
//
//  Created by Handbbc on 2017/9/1.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "NewItemsTableViewCell.h"

@implementation NewItemsTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftImg = [[UIImageView alloc]init];
        [self addSubview:_leftImg];
        [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(20);
            make.width.height.equalTo(15);
        }];
        
        _leftLabel = [[UILabel alloc]init];
        [self addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_leftImg.mas_centerY);
            make.left.equalTo(_leftImg.right).offset(5);
        }];
        
        _rightImg = [[UIImageView alloc]init];
        [self addSubview: _rightImg];
        [_rightImg setImage:[UIImage imageNamed:@"gray_blue_circle"]];
        [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(-20);
            make.width.height.equalTo(15);
        }];
        
        _rightLabel = [[UILabel alloc]init];
        [self addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightImg.left).offset(-5);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}





@end
