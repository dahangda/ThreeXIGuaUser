//
//  MyWalletTableViewCell.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/11.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "MyWalletTableViewCell.h"
#import "MyWalletModel.h"

@implementation MyWalletTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftView = [[UIImageView alloc]init];
        [self addSubview:_leftView];
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(self.mas_centerY);
            make.width.height.equalTo(25);
        }];
        
        
        
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(_leftView.right).offset(8);
        }];
        
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = [UIFont systemFontOfSize:15];
    
        [self addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-20);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
    }
    return self;
}



-(void)setValue:(id)object
{
    MyWalletModel *obj = (MyWalletModel *)object;
    _leftLabel.text = obj.leftLabel;
    _leftView.image = [UIImage imageNamed:obj.leftImg];
}

@end
