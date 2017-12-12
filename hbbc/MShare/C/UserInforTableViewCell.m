//
//  UserInforTableViewCell.m
//  hbbciphone
//
//  Created by Handbbc on 2017/8/1.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "UserInforTableViewCell.h"
#import "UserInforModel.h"

@implementation UserInforTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftView = [[UIImageView alloc]init];
        [self.contentView addSubview:_leftView];
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(self.mas_centerY);
            make.width.height.equalTo(25);
        }];
        
        
        
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(_leftView.right).offset(8);
        }];
        
  
        
    }
    return self;
}



-(void)setValue:(id)object
{
    UserInforModel *obj = (UserInforModel *)object;
    _leftLabel.text = obj.leftLabel;
    _leftView.image = [UIImage imageNamed:obj.leftImg];
}
@end
