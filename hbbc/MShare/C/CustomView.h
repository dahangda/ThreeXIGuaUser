//
//  CustomView.h
//  hbbciphone
//
//  Created by Handbbc on 2017/7/12.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^myblock) ();

@interface CustomView : UIView


@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *kindLabel;
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *payLabel;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UILabel *metreLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *registBtn;






@property (nonatomic,copy)myblock theBlock;


@end
