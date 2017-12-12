//
//  MPush.h
//  hbbciphone
//
//  Created by mac on 2016/11/17.
//  Copyright © 2016年 hbbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPush : NSObject

/**获取推送消息模块详情*/
+ (void)getMPushParameter;



/**绑定用户身份标识*/
+ (void)bindUserClientID;



/**解除用户身份标识*/
+ (void)clearUserClientID;


@end
