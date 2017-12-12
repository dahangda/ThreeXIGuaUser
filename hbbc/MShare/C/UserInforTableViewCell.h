//
//  UserInforTableViewCell.h
//  hbbciphone
//
//  Created by Handbbc on 2017/8/1.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInforTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UIImageView *leftView;



-(void)setValue:(id)object;

@end
