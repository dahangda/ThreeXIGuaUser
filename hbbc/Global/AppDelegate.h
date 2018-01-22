//
//  AppDelegate.h
//  hbbc
//
//  Created by mac on 2016/10/19.
//  Copyright © 2016年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeTuiSdk.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate, GeTuiSdkDelegate, UNUserNotificationCenterDelegate>
//@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>
@property (strong, nonatomic) UIWindow *window;


@end

