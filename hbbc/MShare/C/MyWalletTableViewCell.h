//
//  MyWalletTableViewCell.h
//  hbbciphone
//
//  Created by Handbbc on 2017/10/11.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWalletTableViewCell : UITableViewCell


@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UIImageView *leftView;

@property (nonatomic,strong)UILabel *rightLabel;

-(void)setValue:(id)object;

@end
