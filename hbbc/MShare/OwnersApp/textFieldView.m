//
//  textFieldView.m
//  hbbciphone
//
//  Created by Handbbc on 2017/9/4.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "textFieldView.h"

@implementation textFieldView

-(id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.layer.masksToBounds = YES;
//        self.clipsToBounds
        self.layer.cornerRadius = 5;
        _textField = [[UITextField alloc]init];
        _textField.backgroundColor = RGBCOLOR(245, 245, 245);
        _textField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.height.equalTo(50);
        }];
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = RGBCOLOR(66, 165, 234);
        [_btn setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(0);
            make.top.equalTo(_textField.bottom);
            make.bottom.equalTo(0);
        }];

    }
    return self;
}

@end
