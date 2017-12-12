//
//  NewItemSelectTableViewCell.m
//  hbbciphone
//
//  Created by Handbbc on 2017/9/4.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "NewItemSelectTableViewCell.h"

@implementation NewItemSelectTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _label = [[UILabel alloc]init];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(30);
        }];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_btn];
        [_btn setImage:[UIImage imageNamed:@"gray_circle"]forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"gray_blue_circle"]forState:UIControlStateSelected];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(-20);
            make.width.height.equalTo(15);
        }];
    }
    return self;
}

@end
