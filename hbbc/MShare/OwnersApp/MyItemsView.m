//
//  MyItemsView.m
//  hbbciphone
//
//  Created by Handbbc on 2017/8/30.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "MyItemsView.h"

@implementation MyItemsView

-(id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc]init];
        [self addSubview:imgView];
        [imgView setImage:[UIImage imageNamed:@"bianhao"]];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(15);
            make.left.equalTo(20);
            make.width.height.equalTo(22);
        }];
        
        
        UILabel *bianHaoLabel = [[UILabel alloc]init];
        bianHaoLabel.text = @"物品编号:";
        [self addSubview:bianHaoLabel];
        [bianHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imgView.mas_centerY);
            make.left.equalTo(imgView.right).offset(5);
        }];
        
       _alabel = [[UILabel alloc]init];
        [self addSubview:_alabel];
        [_alabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imgView.mas_centerY);
            make.left.equalTo(bianHaoLabel.right);
        }];
        
        UIImageView *lineView = [[UIImageView alloc]init];
        lineView.backgroundColor = RGBCOLOR(245, 245, 245);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView.bottom).offset(15);
            make.left.equalTo(0);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(1);
        }];
        
        _imgView = [[UIImageView alloc]init];
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.bottom).offset(5);
            make.left.equalTo(20);
            make.height.width.equalTo(57);
        }];
        
        UIImageView *useNumberImg = [[UIImageView alloc]init];
        [useNumberImg setImage:[UIImage imageNamed:@"useNumbers"]];
        [self addSubview:useNumberImg];
        [useNumberImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgView.top).offset(3);
            make.left.equalTo(_imgView.right).offset(2);
            make.width.height.equalTo(22);
        }];
        
        UILabel *leftLabel = [[UILabel alloc]init];
        leftLabel.textColor = [UIColor grayColor];
        leftLabel.font = [UIFont systemFontOfSize:13];
        leftLabel.text = @"使用次数:";
        [self addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(useNumberImg.mas_centerY);
            make.left.equalTo(useNumberImg.right).offset(2);
        }];
        
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = [UIColor grayColor];
        _numberLabel.font = [UIFont systemFontOfSize:13];
        _numberLabel.text = @"10";
        [self addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftLabel.mas_centerY);
            make.left.equalTo(leftLabel.right).offset(5);
        }];
        
        UILabel *danwei = [[UILabel alloc]init];
        danwei.text = @"元";
        danwei.font = [UIFont systemFontOfSize:13];
        [self addSubview:danwei];
        [danwei mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftLabel.mas_centerY);
            make.right.equalTo(-20);
        }];
        
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = [UIColor redColor];
        [self addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(danwei.mas_centerY);
            make.right.equalTo(danwei.left).offset(-5);
        }];
        
        UILabel *rightLabel = [[UILabel alloc]init];
        rightLabel.textColor = [UIColor grayColor];
        rightLabel.font = [UIFont systemFontOfSize:13];
        rightLabel.text = @"累计收益";
        [self addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftLabel.mas_centerY);
            make.right.equalTo(_moneyLabel.left).offset(-5);
        }];
        
        UIImageView *shouyiImg = [[UIImageView alloc]init];
        [shouyiImg setImage:[UIImage imageNamed:@"shouyi"]];
        [self addSubview:shouyiImg];
        [shouyiImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(useNumberImg.mas_centerY);
            make.right.equalTo(rightLabel.left).offset(-2);
            make.width.height.equalTo(22);
        }];

        UIImageView *priceImg = [[UIImageView alloc]init];
        [priceImg setImage:[UIImage imageNamed:@"usePrice"]];
        [self addSubview:priceImg];
        [priceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgView.right).offset(2);
            make.top.equalTo(useNumberImg.bottom).offset(10);
            make.width.height.equalTo(22);
        }];

        UILabel *bleftLabel = [[UILabel alloc]init];
        bleftLabel.textColor = [UIColor grayColor];
        bleftLabel.font = [UIFont systemFontOfSize:13];
        bleftLabel.text = @"收费(元/分钟):";
        [self addSubview:bleftLabel];
        [bleftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(priceImg.mas_centerY);
            make.left.equalTo(priceImg.right).offset(2);
        }];

        _payLabel = [[UILabel alloc]init];
        _payLabel.textColor = [UIColor grayColor];
        _payLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_payLabel];
        [_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bleftLabel.mas_centerY);
            make.left.equalTo(bleftLabel.right).offset(5);
        }];
        
        
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.textColor = [UIColor redColor];
        _stateLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_stateLabel];
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bleftLabel.mas_centerY);
            make.right.equalTo(danwei.right);
        }];

    }
    return self;
}

@end
