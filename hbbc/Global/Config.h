//
//  Config.h
//  pgyniphone
//
//  Created by mac on 2016/10/19.
//  Copyright © 2016年 hbbc. All rights reserved.
//

#ifndef Config_h
#define Config_h

//--------------------------线上------------------------------
/**服务器根路径*/
//#define SEVERIP @"http://ppgyn.handbbc.com/pgynpi/mapp."



//--------------------------测试------------------------------
/**服务器根路径*/
#define SEVERROOTPATH @"http://192.168.1.176/pgynpi/mapp."



//--------------------------设置------------------------------
/**ECID*/
#define ECID @"100101"



//--------------------------基础通用接口------------------------
/**用户登录接口*/
#define DOLOGIN [NSString stringWithFormat:@"%@MAppMain.doLogin.hf", SEVERROOTPATH]
/**自动登录接口*/
#define AUTOLOGIN [NSString stringWithFormat:@"%@MAppMain.autoLogin.hf", SEVERROOTPATH]
/**会员注册接口*/
#define DOREGISTER [NSString stringWithFormat:@"%@MAppMain.doRegister.hf", SEVERROOTPATH]
/**设备注册接口*/
#define DEVICEREGISTER [NSString stringWithFormat:@"%@MAppMain.deviceRegister.hf", SEVERROOTPATH]
/**修改用户个人信息接口*/
#define SETUSERINFO [NSString stringWithFormat:@"%@MAppMain.setUserInfo.hf", SEVERROOTPATH]
/**获取用户个人信息接口*/
#define GETUSERINFO [NSString stringWithFormat:@"%@MAppMain.getUserInfo.hf", SEVERROOTPATH]
/**获取短信验证码接口*/
#define GETSMSVERIFYCODE [NSString stringWithFormat:@"%@MAppMain.getSMSVerifyCode.hf", SEVERROOTPATH]
/**用户提交建议接口*/
#define SUBMITUSERADVICE [NSString stringWithFormat:@"%@MAppMain.submitUserAdvice.hf", SEVERROOTPATH]
/**检查更新接口*/
#define CHECKAPPUPDATE [NSString stringWithFormat:@"%@MAppMain.checkAppUpdate.hf", SEVERROOTPATH]
/**获取应用基础信息*/
#define GETAPPINFO [NSString stringWithFormat:@"%@MAppMain.getAppInfo.hf", SEVERROOTPATH]



//--------------------------外壳接口----------------------------
/**获取外壳详情接口*/
#define GETSHELLINFO [NSString stringWithFormat:@"%@MShell.getShellInfo.hf", SEVERROOTPATH]
/**获取轮播图接口*/
#define GETCAROUSELLIST [NSString stringWithFormat:@"%@MShell.getCarouselList.hf", SEVERROOTPATH]
/**获取菜单列表接口*/
#define GETSHELLITEMLIST [NSString stringWithFormat:@"%@MShell.getShellItemList.hf", SEVERROOTPATH]



//--------------------------属性宏-----------------------------
/**获取屏幕宽度*/
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/**获取屏幕高度*/
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/**系统颜色*/
#define SYSTERMCOLOR [ShellInfo shareShellInfo].themeColor

#define PICTUREIP @""
/**获取当前版本号*/
#define APPVERSION [[[NSBundle mainBundle ] infoDictionary] objectForKey:@"CFBundleVersion"]
/**获取LoginKey*/
#define LOGINKEY [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginKey"]
/**获取手机号*/
#define PHONENUM [[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneNum"]
/**从偏好设置中取出AppUserID*/
#define APPUSERID [[NSUserDefaults standardUserDefaults] objectForKey:@"AppUserID"]



//-------------------------工具宏-------------------------------
/**控制台输出宏*/
#ifdef DEBUG
//DLog
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//专门输出error的宏
#define DHErrorLog(error) DLog(@"\nerror:%@", error)
//专门输出请求返回值的宏
#define DHResponseBodyLog(responseBody) DLog(@"\nresponseBody:%@", responseBody)
#else
#define DLog(...)
#define DHErrorLog(...)
#define DHResponseBodyLog(...)
#endif
/**RGB颜色宏*/
#define RGBCOLOR(r,g,b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]


#endif /* Config_h */
