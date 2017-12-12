//
//  BillHeaderView.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/11.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "BillHeaderView.h"

@implementation BillHeaderView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGBCOLOR(241, 242, 243);
        _alabel = [[UILabel alloc]init];
        [self addSubview:_alabel];
        [_alabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(20);
        }];
        
        _abtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_abtn setImage:[UIImage imageNamed:@"向下箭头"] forState:UIControlStateNormal];
        [_abtn setImage:[UIImage imageNamed:@"向上箭头"] forState:UIControlStateSelected];
        [self addSubview:_abtn];
        [_abtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(-20);
            make.height.width.equalTo(25);
        }];
    }
    return self;
}



@end
