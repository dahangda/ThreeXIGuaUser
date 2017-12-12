//
//  MyWalletModel.h
//  hbbciphone
//
//  Created by Handbbc on 2017/10/11.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWalletModel : NSObject

@property (nonatomic,strong)NSString *leftImg;
@property (nonatomic,strong)NSString *leftLabel;

-(id)initWithLeftImg:(NSString *)lef andLeftLabel:(NSString *)la;

@end
