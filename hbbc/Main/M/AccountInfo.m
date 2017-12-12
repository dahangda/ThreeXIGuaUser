//
//  PeopleInfo.m
//  pgyapp
//
//  Created by HBBC-IMacA on 16/5/23.
//  Copyright © 2016年 handbbc. All rights reserved.
//

#import "AccountInfo.h"

@implementation AccountInfo

+ (instancetype)sharepeopleInfo{
    static AccountInfo *peopleInfo = nil;
    if(peopleInfo == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            peopleInfo = [[AccountInfo alloc] init];
        });
    }
    return peopleInfo;
}

+ (NSInteger)personFlag {
    
    if ([AccountInfo sharepeopleInfo].MemberID == nil && [AccountInfo sharepeopleInfo].ManagerID == nil) {
        return [AccountInfo sharepeopleInfo].PersonFlag = 0;
    } else if ([AccountInfo sharepeopleInfo].MemberID != nil && [AccountInfo sharepeopleInfo].ManagerID == nil) {
        return [AccountInfo sharepeopleInfo].PersonFlag = 2;
    } else if ([AccountInfo sharepeopleInfo].MemberID == nil && [AccountInfo sharepeopleInfo].ManagerID != nil) {
        return [AccountInfo sharepeopleInfo].PersonFlag = 1;
    }
    
    return 0;
    
}

+ (void)deleteAccountInfomation {
    [AccountInfo sharepeopleInfo].MemberID = nil;
    [AccountInfo sharepeopleInfo].ManagerID = nil;
    [AccountInfo sharepeopleInfo].Name = nil;
    [AccountInfo sharepeopleInfo].HeadPicFieldID = nil;
    [AccountInfo sharepeopleInfo].PersonFlag = 0;
}

@end
