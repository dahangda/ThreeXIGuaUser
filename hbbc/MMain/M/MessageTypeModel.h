//
//  MessageTypeModel.h
//  hbbciphone
//
//  Created by mac on 2016/11/19.
//  Copyright © 2016年 hbbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageTypeModel : NSObject

@property (nonatomic, strong) NSString *TypeName;   //类型名称
@property (nonatomic, strong) NSString *PicFileID;  //图片地址
@property (nonatomic, strong) NSString *MTID;       //消息类型ID
@property (nonatomic, assign) NSInteger UnReadNum;  //未读数

@end
