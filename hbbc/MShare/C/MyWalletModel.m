//
//  MyWalletModel.m
//  hbbciphone
//
//  Created by Handbbc on 2017/10/11.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "MyWalletModel.h"

@implementation MyWalletModel

-(id)initWithLeftImg:(NSString *)lef andLeftLabel:(NSString *)la
{
    if (self = [super init])
    {
        self.leftImg = lef;
        self.leftLabel = la;
    }
    return self;
}

@end
