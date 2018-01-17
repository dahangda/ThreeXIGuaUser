//
//  SharePersonInforView.m
//  hbbciphone
//
//  Created by Handbbc on 2017/8/28.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "SharePersonInforView.h"

@implementation SharePersonInforView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        topImg.backgroundColor = RGBCOLOR(245, 245, 245);
        [self addSubview:topImg];

        _appLogo = [[UIImageView alloc]init];
        [self addSubview:_appLogo];
        [_appLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(74);
            make.width.equalTo(136);
            make.height.equalTo(124);
        }];
    
        
        UILabel *logoLabel = [[UILabel alloc]init];
        logoLabel.text = @"客户端";
        
        logoLabel.font = [UIFont systemFontOfSize:25];
        [self addSubview:logoLabel];
        [logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_appLogo.bottom).offset(10);
            make.centerX.equalTo(_appLogo.mas_centerX);
        }];
        
        UILabel *edition = [[UILabel alloc]init];
        edition.text = @"v1.0.0";
        [self addSubview:edition];
        [edition mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logoLabel.bottom).offset(5);
            make.centerX.equalTo(_appLogo.mas_centerX);
        }];
        
        UIImageView *weiXinImg = [[UIImageView alloc]init];
        [weiXinImg setImage:[UIImage imageNamed:@"person1"]];
        [self addSubview:weiXinImg];
        [weiXinImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(topImg.bottom).offset(5);
            make.width.height.equalTo(28);
        }];
        
        UILabel *weiXinLabel = [[UILabel alloc]init];
        weiXinLabel.text = @"微信公众号";
        [self addSubview:weiXinLabel];
        [weiXinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weiXinImg.right).offset(5);
            make.centerY.equalTo(weiXinImg.mas_centerY);
        }];
        
        _weiXinLabel = [[UILabel alloc]init];
        _weiXinLabel.textAlignment = NSTextAlignmentRight;
        _weiXinLabel.textColor = [UIColor grayColor];
        _weiXinLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_weiXinLabel];
        [_weiXinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-5);
            make.centerY.equalTo(weiXinLabel.mas_centerY);
        }];
        _weiXinLabel.text = @"sdsjweixin";
        
        UIImageView *phoneImg = [[UIImageView alloc]init];
        [phoneImg setImage:[UIImage imageNamed:@"person2"]];
        [self addSubview:phoneImg];
        [phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(weiXinImg.bottom).offset(15);
            make.width.height.equalTo(28);
        }];
        
        UILabel *phoneLabel = [[UILabel alloc]init];
        phoneLabel.text = @"联系电话";
        [self addSubview:phoneLabel];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneImg.right).offset(5);
            make.centerY.equalTo(phoneImg.mas_centerY);
        }];
        
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        _phoneLabel.textColor = [UIColor grayColor];
        _phoneLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-5);
            make.centerY.equalTo(phoneLabel.mas_centerY);
        }];
         _phoneLabel.text = @"15711459781";
        
        UIImageView *mailImg = [[UIImageView alloc]init];
        [mailImg setImage:[UIImage imageNamed:@"person3"]];
        [self addSubview:mailImg];
        [mailImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(phoneImg.bottom).offset(15);
            make.width.height.equalTo(28);
        }];
        
        UILabel *mailLabel = [[UILabel alloc]init];
        mailLabel.text = @"电子邮箱";
        [self addSubview:mailLabel];
        [mailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(mailImg.right).offset(5);
            make.centerY.equalTo(mailImg.mas_centerY);
        }];
        
        _mailLabel = [[UILabel alloc]init];
        _mailLabel.font = [UIFont systemFontOfSize:15.0];
        _mailLabel.textAlignment = NSTextAlignmentRight;
        _mailLabel.textColor = [UIColor grayColor];
        [self addSubview:_mailLabel];
        [_mailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-5);
            make.centerY.equalTo(mailLabel.mas_centerY);
        }];
        _mailLabel.text = @"1029327376@qq.com";
        
        UIImageView *officeImg = [[UIImageView alloc]init];
        [officeImg setImage:[UIImage imageNamed:@"person4"]];
        [self addSubview:officeImg];
        [officeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(mailImg.bottom).offset(15);
            make.width.height.equalTo(28);
        }];
        
        UILabel *officeLabel = [[UILabel alloc]init];
        officeLabel.text = @"官方网站";
        [self addSubview:officeLabel];
        [officeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(officeImg.right).offset(5);
            make.centerY.equalTo(officeImg.mas_centerY);
        }];
        
        _officeLabel = [[UILabel alloc]init];
        _officeLabel.textAlignment = NSTextAlignmentRight;
        _officeLabel.textColor = [UIColor grayColor];
        _officeLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_officeLabel];
        [_officeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-5);
            make.centerY.equalTo(officeLabel.mas_centerY);
        }];
        _officeLabel.text = @"www.sdsjShare.com";
        
        UIImageView *bottomImg = [[UIImageView alloc]init];
        bottomImg.backgroundColor = RGBCOLOR(245, 245, 245);
        [self addSubview:bottomImg];
        [bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(officeImg.bottom).offset(5);
            make.left.right.equalTo(0);
            make.bottom.equalTo(0);
        }];
        
        UILabel *companyLabel = [[UILabel alloc]init];
        companyLabel.text = @"视动世纪(北京)科技有限公司";
        companyLabel.textColor = [UIColor grayColor];
        [self addSubview:companyLabel];
        [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-30);
            make.centerX.equalTo(self.mas_centerX);
        }];


    }
    return self;
}


-(void)setValues:(SharePersonInfoModel *)obj
{
    NSURL *logoImg = [NSURL URLWithString:obj.APPLogoPicFileID];
    [_appLogo sd_setImageWithURL:logoImg];
    _weiXinLabel.text = obj.WXNumber;
    _phoneLabel.text = obj.ContactNumber;
    _mailLabel.text = obj.MailAddress;
    _officeLabel.text = obj.OfficeAddress;
}

@end
