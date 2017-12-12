//
//  UserInforModel.m
//  hbbciphone
//
//  Created by Handbbc on 2017/8/1.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "UserInforModel.h"

@implementation UserInforModel


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
