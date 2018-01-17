//
//  AbourtUsView.h
//  hbbciphone
//
//  Created by YanHang on 2018/1/17.
//  Copyright © 2018年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharePersonInfoModel.h"
@interface AbourtUsView : UIView
-(void)setValues:(SharePersonInfoModel *)obj;
+ (instancetype)AbourtUsView ;
- (void)mask;
@end
