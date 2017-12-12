//
//  PeopleInfo.h
//  pgyapp
//
//  Created by HBBC-IMacA on 16/5/23.
//  Copyright © 2016年 handbbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountInfo : NSObject
/**账户名*/
@property (strong, nonatomic) NSString *MemberID;
/**账户名*/
@property (strong, nonatomic) NSString *ManagerID;
/**昵称*/
@property (strong, nonatomic) NSString *Name;
/**头像*/
@property (strong, nonatomic) NSString *HeadPicFieldID;
/**身份标识,1.指导教师;2.学员*/
@property (assign, nonatomic) NSInteger PersonFlag;

+ (instancetype)sharepeopleInfo;
/**删除账户信息*/
+ (void)deleteAccountInfomation;
/**判断用户身份*/
+ (NSInteger)personFlag;

@end
