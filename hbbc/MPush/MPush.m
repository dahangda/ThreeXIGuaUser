//
//  MPush.m
//  hbbciphone
//
//  Created by mac on 2016/11/17.
//  Copyright © 2016年 hbbc. All rights reserved.
//

#import "MPush.h"

@implementation MPush

+ (void)getMPushParameter {
    NSDictionary *parameters = @{@"AppUserID" : APPUSERID,
                                 @"ECID" : ECID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:GETPUSHPARAMETER success:^(id responseBody) {
        DHResponseBodyLog(responseBody);
        [ShellInfo shareShellInfo].pushID = responseBody[@"PushID"];
    } failed:^(NSError *error) {
        DHErrorLog(error);
    }];
}



+ (void)bindUserClientID {
    
    if ([ShellInfo shareShellInfo].pushID) {
        NSDictionary *parameters = @{@"AppUserID" : APPUSERID,
                                     @"ECID" : ECID,
                                     @"PushID" : [ShellInfo shareShellInfo].pushID,
                                     @"UserType" : @([GlobalParameter sharepeopleInfo].PersonFlag),
                                     @"UserID" : USERID,
                                     @"UserName" : [GlobalParameter sharepeopleInfo].Name,
                                     @"PhoneNum" : PHONENUM,
                                     @"GTClientID" : CLIENTID,
                                     @"DeviceType" : @"ios"
                                     };
        [[NetworkSingleton shareManager] httpRequest:parameters url:BINDUSERCLIENTID success:^(id responseBody) {
            DHResponseBodyLog(responseBody);
            [GlobalParameter sharepeopleInfo].GWGTID = responseBody[@"GWGTID"];
        } failed:^(NSError *error) {
            DHErrorLog(error);
        }];
    }
}



+ (void)clearUserClientID {
    if ([ShellInfo shareShellInfo].pushID && [GlobalParameter sharepeopleInfo].GWGTID) {
        NSDictionary *parameters = @{@"AppUserID" : APPUSERID,
                                     @"ECID" : ECID,
                                     @"PushID" : [ShellInfo shareShellInfo].pushID,
                                     @"GWGTID" : [GlobalParameter sharepeopleInfo].GWGTID
                                     };
        [[NetworkSingleton shareManager] httpRequest:parameters url:CLEARUSERCLIENTID success:^(id responseBody) {
            DHResponseBodyLog(responseBody);
        } failed:^(NSError *error) {
            DHErrorLog(error);
        }];
    }
}


@end
