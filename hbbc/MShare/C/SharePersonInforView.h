//
//  SharePersonInforView.h
//  hbbciphone
//
//  Created by Handbbc on 2017/8/28.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharePersonInfoModel.h"

@interface SharePersonInforView : UIView


@property (nonatomic,strong)UIImageView *appLogo;
@property (nonatomic,strong)UILabel *weiXinLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *mailLabel;
@property (nonatomic,strong)UILabel *officeLabel;


-(void)setValues:(SharePersonInfoModel *)obj;

@end
