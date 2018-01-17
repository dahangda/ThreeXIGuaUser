//
//  AbourtUsView.m
//  hbbciphone
//
//  Created by YanHang on 2018/1/17.
//  Copyright © 2018年 hbbc. All rights reserved.
//

#import "AbourtUsView.h"
@interface AbourtUsView()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *winxinLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLable;
@property (weak, nonatomic) IBOutlet UILabel *emailLable;
@property (weak, nonatomic) IBOutlet UILabel *networkLable;

@end
@implementation AbourtUsView

-(void)setValues:(SharePersonInfoModel *)obj
{
    NSURL *logoImg = [NSURL URLWithString:obj.APPLogoPicFileID];
    [_logoImageView sd_setImageWithURL:logoImg];
    _winxinLable.text = obj.WXNumber;
    _phoneNumberLable.text = obj.ContactNumber;
    _emailLable.text = obj.MailAddress;
    _networkLable.text = obj.OfficeAddress;
  
}
+ (instancetype)AbourtUsView {
    NSString *className = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
 
    return [nib instantiateWithOwner:nil options:nil].firstObject;
    
}
- (void)mask{
    
    self.logoImageView.layer.masksToBounds = YES;
    self.logoImageView.layer.cornerRadius = 0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
