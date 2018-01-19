//
//  CustomView.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/12.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "CustomView.h"


@implementation CustomView

-(id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc]init];
        [imgView setImage:[UIImage imageNamed:@"coding"]];
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(5);
            make.width.equalTo(22);
            make.height.equalTo(23);
        }];
        
        _label = [[UILabel alloc]init];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = [UIColor blackColor];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imgView.mas_centerY);
            make.left.equalTo(imgView.right).offset(0);
            make.right.equalTo(0);
        }];
        
        UIImageView *lineView = [[UIImageView alloc]init];
        lineView.backgroundColor = RGBCOLOR(220, 221, 221);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView.bottom).offset(2);
            make.left.equalTo(0);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(1);
        }];
        
        _imgView = [[UIImageView alloc]init];
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.bottom).offset(5);
            make.left.equalTo(5);
            make.width.equalTo(45);
            make.height.equalTo(45);
        }];
        
        UILabel *ltLabel = [[UILabel alloc]init];
        ltLabel.text = @"物品编号:";
        ltLabel.font = [UIFont systemFontOfSize:12.0];
        ltLabel.textColor = RGBCOLOR(30, 30, 30);
        [self addSubview:ltLabel];
        [ltLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.bottom).offset(5);
            make.left.equalTo(_imgView.right).offset(20);
            make.width.equalTo(60);
        }];
        
        UIImageView *bottonView =[[UIImageView alloc]init];
        bottonView.image = [UIImage imageNamed:@"home1.jpg"];
        [self addSubview:bottonView];
        [bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.bottom).offset(5+ltLabel.height/2);
            make.right.equalTo(ltLabel.left).offset(-2);
            make.width.height.equalTo(10);
        }];
        
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont systemFontOfSize:13];
        _numberLabel.textColor = RGBCOLOR(30, 30, 30);
        [self addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ltLabel.top);
            make.left.equalTo(ltLabel.right);
        }];
        
        UILabel *rtLabel = [[UILabel alloc]init];
        rtLabel.text = @"物品名称:";
        rtLabel.font = [UIFont systemFontOfSize:12.0];
        rtLabel.textColor = RGBCOLOR(30, 30, 30);
        [self addSubview:rtLabel];
        [rtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.bottom).offset(5);
            make.left.equalTo(SCREEN_WIDTH / 2 + 50);
            make.width.equalTo(60);
        }];
        
        UIImageView *bottonView1 =[[UIImageView alloc]init];
        bottonView1.image = [UIImage imageNamed:@"home2.jpg"];
        [self addSubview:bottonView1];
        [bottonView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.bottom).offset(5+ltLabel.height/2);
            make.right.equalTo(rtLabel.left).offset(-2);
            make.width.height.equalTo(10);
        }];
        
        
        _kindLabel = [[UILabel alloc]init];
        _kindLabel.font = [UIFont systemFontOfSize:13];
        _kindLabel.textColor = RGBCOLOR(30, 30, 30);
        [self addSubview:_kindLabel];
        [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rtLabel.top);
            make.left.equalTo(rtLabel.right);
        }];
        
        UILabel *rlLabel = [[UILabel alloc]init];
        rlLabel.text = @"业务类型:";
        rlLabel.font = [UIFont systemFontOfSize:12.0];
        rlLabel.textColor = RGBCOLOR(30, 30, 30);
        [self addSubview:rlLabel];
        [rlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ltLabel.bottom).offset(10);
            make.left.equalTo(_imgView.right).offset(20);
            make.width.equalTo(60);
        }];
        UIImageView *bottonView2 =[[UIImageView alloc]init];
        bottonView2.image = [UIImage imageNamed:@"home3.jpg"];
        [self addSubview:bottonView2];
        [bottonView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ltLabel.bottom).offset(10+ltLabel.height/2);
            make.right.equalTo(rlLabel.left).offset(-2);
            make.width.height.equalTo(10);
        }];
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.font = [UIFont systemFontOfSize:13];
        _typeLabel.textColor = RGBCOLOR(30, 30, 30);
        [self addSubview:_typeLabel];
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ltLabel.bottom).offset(10);
            make.left.equalTo(ltLabel.right);
        }];
        
        UILabel *rbLabel = [[UILabel alloc]init];
        rbLabel.text = @"预约定金:";
        rbLabel.font = [UIFont systemFontOfSize:12.0];
        rbLabel.textColor = RGBCOLOR(30, 30, 30);
        [self addSubview:rbLabel];
        [rbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rtLabel.bottom).offset(10);
            make.left.equalTo(SCREEN_WIDTH / 2 + 50);
            make.width.equalTo(60);
        }];
        UIImageView *bottonView3 =[[UIImageView alloc]init];
        bottonView3.image = [UIImage imageNamed:@"home4.jpg"];
        [self addSubview:bottonView3];
        [bottonView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rtLabel.bottom).offset(10+ltLabel.height/2);
            make.right.equalTo(rtLabel.left).offset(-2);
            make.width.height.equalTo(10);
        }];
        _payLabel = [[UILabel alloc]init];
        _payLabel.font = [UIFont systemFontOfSize:13];
        _payLabel.textColor = [UIColor redColor];
        [self addSubview:_payLabel];
        [_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rbLabel.top);
            make.left.equalTo(rbLabel.right);
        }];
        
        UIImageView *twolineView = [[UIImageView alloc]init];
        twolineView.backgroundColor = RGBCOLOR(220, 221, 221);
        [self addSubview:twolineView];
        [twolineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rlLabel.bottom).offset(10);
            make.left.equalTo(0);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(1);
        }];



        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twolineView.bottom).offset(5);
            make.left.equalTo(20);
        }];
        
        UILabel *mlabel = [[UILabel alloc]init];
        mlabel.font = [UIFont systemFontOfSize:12];
        mlabel.text = @"元/次";
        mlabel.textColor = [UIColor grayColor];
        [self addSubview:mlabel];
        [mlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_moneyLabel.mas_centerY);
            make.left.equalTo(_moneyLabel.right);
            make.width.equalTo(50);
        }];

        _metreLabel = [[UILabel alloc]init];
        _metreLabel.textColor = [UIColor redColor];
        _metreLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_metreLabel];
        [_metreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twolineView.bottom).offset(5);
            make.left.equalTo(SCREEN_WIDTH/2 - 20);
        }];
        
        UILabel *melabel = [[UILabel alloc]init];
        melabel.text = @"米";
        melabel.font = [UIFont systemFontOfSize:12];
        melabel.textColor = [UIColor grayColor];
        [self addSubview:melabel];
        [melabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_moneyLabel.mas_centerY);
            make.left.equalTo(_metreLabel.right);
            make.width.equalTo(20);
        }];
        
        UILabel *tlabel = [[UILabel alloc]init];
        tlabel.text = @"分钟";
        tlabel.font = [UIFont systemFontOfSize:12];
        tlabel.textColor = [UIColor grayColor];
        [self addSubview:tlabel];
        [tlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_moneyLabel.mas_centerY);
            make.right.equalTo(-20);
            make.width.equalTo(40);
        }];

        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor redColor];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twolineView.bottom).offset(5);
            make.right.equalTo(tlabel.left);
        }];
        
        
        

        UILabel *leftLabel = [[UILabel alloc]init];
        leftLabel.text = @"使用价格";
        leftLabel.font = [UIFont systemFontOfSize:14];
        leftLabel.textColor = [UIColor grayColor];
        [self addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mlabel.bottom).offset(5);
            make.left.equalTo(20);
            make.width.equalTo(100);
        }];
#pragma mark ********************中1xian

        UIView *midView = [[UIView alloc]init];
        midView.backgroundColor = RGBCOLOR(220, 221, 221);
        [self addSubview:midView];
        [midView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twolineView.bottom).offset(5);
            make.left.equalTo(leftLabel.right).offset(-30);
            make.height.equalTo(40);
            make.width.equalTo(1);
        }];
        
        UILabel *midLabel = [[UILabel alloc]init];
        midLabel.text = @"距离起始位置";
        midLabel.font = [UIFont systemFontOfSize:14];
        midLabel.textAlignment = NSTextAlignmentCenter;
        midLabel.textColor = [UIColor grayColor];
        [self addSubview:midLabel];
        [midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mlabel.bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(100);
        }];
        
        UILabel *rightLabel = [[UILabel alloc]init];
        rightLabel.text = @"步行可到达";
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.textColor = [UIColor grayColor];
        [self addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mlabel.bottom).offset(5);
            make.right.equalTo(-20);
            make.width.equalTo(100);
        }];
        
#pragma mark ********************中1xian
        
        UIView *midView1 = [[UIView alloc]init];
        midView1.backgroundColor = RGBCOLOR(220, 221, 221);
        [self addSubview:midView1];
        [midView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twolineView.bottom).offset(5);
            make.right.equalTo(rightLabel.left).offset(20);
            make.height.equalTo(40);
            make.width.equalTo(1);
        }];
        
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registBtn.layer.cornerRadius = 20;
        [_registBtn setTitle:@"完成注册即可开始租赁" forState:UIControlStateNormal];
        _registBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _registBtn.backgroundColor = RGBCOLOR(66, 165, 234);
        [self addSubview:_registBtn];
        [_registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(40);
            make.bottom.equalTo(self.bottom).offset(-10);
            make.left.equalTo(10);
            make.right.equalTo(-10);
        }];
        [_registBtn addTarget:self action:@selector(goToRegist) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


-(void)goToRegist
{
    if (_theBlock)
    {
        _theBlock();
    }
}


@end
