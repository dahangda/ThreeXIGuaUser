//
//  GlobalConfig.h
//  pgyniphone
//
//  Created by mac on 2016/10/19.
//  Copyright © 2016年 hbbc. All rights reserved.
//

#ifndef GlobalConfig_h
#define GlobalConfig_h

//--------------------------线上------------------------------
/**服务器根路径*/
//#define SEVERROOTPATH @"http://ppgyn.handbbc.com/pgynpi/mapp."



//--------------------------测试------------------------------
/**服务器根路径*/
//#define SEVERROOTPATHONLINE @"http://sdse.shidongvr.com/sdsepi/"
/**测试服务器根路径（亮亮）*/
//#define TESTSEVERROOTPATHONLINE @"http://192.168.1.134:8080/sdsepi/"
/**本地服务器根路径*/
//#define SEVERROOTPATHONLINE @"http://192.168.1.169:8080/sdsepi/"
/**测试服务器根路径*/
//#define SEVERROOTPATHONLINE @"http://home.handbbc.com:8680/sdsepi/"
/**测试服务器根路径*/
#define SEVERROOTPATHONLINE @"http://192.168.1.86/sdsepi/"



//--------------------------设置------------------------------
/**86服务器*/
#define ECID @"100123"
#define APPID  @"26"
/**线上服务器*/
//#define ECID @"100001"
//#define APPID  @"20"
#define OwnerECID @"100102"
#define GOODSSNID @"10000024"
#define kGtAppId           @"2gEoTK2fu69EY0QKn7Heu8"
#define kGtAppKey          @"EBJJBGE2gp57opfzjsW628"
#define kGtAppSecret       @"TKz8CD1aIo88JmK0Ca5512"
//车主端高德地图key
#define kGaoDeMap          @"8c14886b69c26f16e393437224fc2970"
//用户端高德地图key
#define gaodeKey           @"1a4d4290547ab065d020f0ea486de241"

//--------------------------属性宏-----------------------------
/**获取屏幕宽度*/
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/**获取屏幕高度*/
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/**系统颜色*/
#define SYSTERMCOLOR [ShellInfo shareShellInfo].themeColor
#define FAILUREPIC nil

#define PICTUREIP @""
/**获取当前版本号*/
#define APPVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/**获取LoginKey*/
#define LOGINKEY [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginKey"]
/**获取手机号*/
//#define PHONENUM @"15093337480"
/**从偏好设置中取出AppUserID*/
#define APPUSERID [[NSUserDefaults standardUserDefaults] objectForKey:@"AppUserID"]
/**根据ManagerID和MemberID判断返回userID*/
#define USERID [GlobalParameter sharepeopleInfo].ManagerID == nil || [[NSString stringWithFormat:@"%@", [GlobalParameter sharepeopleInfo].ManagerID] length] == 0 ? [GlobalParameter sharepeopleInfo].MemberID : [GlobalParameter sharepeopleInfo].ManagerID
/**获取用户注册后的手机密码*/
#define PhoneNum [[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneNumber"]
/**获取用户名*/
#define USERNAME [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"]
/**用户自动登录秘钥*/
#define UserAutoLoginKey [[NSUserDefaults standardUserDefaults] objectForKey:@"UserAutoLoginKey"]

//#define UserAutoLoginKey [[NSUserDefaults standardUserDefaults] objectForKey: [NSString stringWithFormat:@"%@%@",@"PhoneNumber",@"UserAutoLoginKey"]];
//--------------------------基础通用接口------------------------
/**用户注册登录接口*/
#define DOLOGIN [NSString stringWithFormat:@"%@mapp.MShare.doUserLogin.hf", SEVERROOTPATHONLINE]
///**实名认证接口*/
#define NAMECERTAIN [NSString stringWithFormat:@"%@mapp.MShare.UserRealNameAuthentication.hf", SEVERROOTPATHONLINE]
///**获取短信验证码接口*/
#define GETSMSVERIFYCODE [NSString stringWithFormat:@"%@mapp.MShare.getUserTempVerifyCode.hf", SEVERROOTPATHONLINE]
///**我的消息系统通知接口*/
#define SYSTEMNEWS [NSString stringWithFormat:@"%@mapp.MShare.getUserSystemNotification.hf", SEVERROOTPATHONLINE]
///**我的消息业务通知接口*/
#define BUSSINESSNEWS [NSString stringWithFormat:@"%@mapp.MShare.getUserServiceNotice.hf", SEVERROOTPATHONLINE]
///**用户提交建议接口*/
#define SUBMITUSERADVICE [NSString stringWithFormat:@"%@mapp.MShare.commitUserOpinion.hf", SEVERROOTPATHONLINE]
/**获取关于我们接口*/
#define ABOUTUS [NSString stringWithFormat:@"%@mapp.MShare.getAboutUSInfo.hf", SEVERROOTPATHONLINE]
/**支付定金接口*/
#define reservation [NSString stringWithFormat:@"%@mapp.MShare.reservation.hf", SEVERROOTPATHONLINE]
/**扫码开锁接口*/
#define openHouseLock [NSString stringWithFormat:@"%@mapp.MShare.openHouseLock.hf", SEVERROOTPATHONLINE]
/**充值开锁时间接口*/
#define rechargeUnlockTime [NSString stringWithFormat:@"%@mapp.MShare.rechargeUnlockTime.hf", SEVERROOTPATHONLINE]
/**获取附近物品信息接口*/
#define GETALLITEMS [NSString stringWithFormat:@"%@mapp.MShare.getUserGoodsList.hf", SEVERROOTPATHONLINE]
/**获取用户端物品详情信息接口*/
#define USERITEMDETAIL [NSString stringWithFormat:@"%@mapp.MShare.getHouseGoodsDetail.hf", SEVERROOTPATHONLINE]
/**用户交纳押金接口*/
#define UserPayDeposit [NSString stringWithFormat:@"%@mapp.MShare.UserPayDeposit.hf", SEVERROOTPATHONLINE]

/**获取我的物品接口*/
#define GETMYITEMS [NSString stringWithFormat:@"%@mapp.MShare.getSharerGoodsList.hf", SEVERROOTPATHONLINE]
/**获取物品类型接口*/
#define GETITEMTYPE [NSString stringWithFormat:@"%@mapp.MShare.getGoodsTypeInfo.hf", SEVERROOTPATHONLINE]
/**提交新增物品信息接口*/
#define COMMITNEWGOODS [NSString stringWithFormat:@"%@mapp.MShare.commitNewGoodsInfo.hf", SEVERROOTPATHONLINE]
/**获取车主端物品详情信息接口*/
#define OWNERITEMDETAIL [NSString stringWithFormat:@"%@mapp.MShare.getSharerGoodsDetail.hf", SEVERROOTPATHONLINE]
/**删除物品接口*/
#define DELETEITEM [NSString stringWithFormat:@"%@mapp.MShare.deleteGoods.hf", SEVERROOTPATHONLINE]
/**修改物品信息接口*/
#define UPDATEITEMINFO [NSString stringWithFormat:@"%@mapp.MShare.modifyGoodsInfo.hf", SEVERROOTPATHONLINE]
/**获取全部订单信息接口*/
#define MYORDERS [NSString stringWithFormat:@"%@mapp.MShare.getUserOrderList.hf", SEVERROOTPATHONLINE]
/**获取待支付订单信息接口*/
#define PendingpayORDERS [NSString stringWithFormat:@"%@mapp.MShare.getUserPendingpaymentOrderList.hf", SEVERROOTPATHONLINE]
/**获取已完成订单信息接口*/
#define CompletedORDERS [NSString stringWithFormat:@"%@mapp.MShare.getUserCompletedOrderList.hf", SEVERROOTPATHONLINE]
/**获取交易失败订单信息接口*/
#define NotDoneORDERS [NSString stringWithFormat:@"%@mapp.MShare.getUserNotDoneOrderList.hf", SEVERROOTPATHONLINE]
/**删除订单接口*/
#define DELETEORDER [NSString stringWithFormat:@"%@mapp.MShare.deleteOneCompleteOrder.hf", SEVERROOTPATHONLINE]
/**退房接口*/
#define CHECKOUT [NSString stringWithFormat:@"%@mapp.MShare.checkOut.hf", SEVERROOTPATHONLINE]
/**我的钱包接口*/
#define MYWALLET [NSString stringWithFormat:@"%@mapp.MShare.getUserWallet.hf", SEVERROOTPATHONLINE]
/**申请提现接口*/
#define APPLYFORCASH [NSString stringWithFormat:@"%@mapp.MShare.applyForCash.hf", SEVERROOTPATHONLINE]
/**充值接口*/
#define RECHARGEMoney [NSString stringWithFormat:@"%@mapp.MShare.rechargeMoney.hf", SEVERROOTPATHONLINE]
/**用户所有账单接口*/
#define LookAllBill [NSString stringWithFormat:@"%@mapp.MShare.LookAllBill.hf", SEVERROOTPATHONLINE]
/**用户支付账单接口*/
#define LookOrderPayBill [NSString stringWithFormat:@"%@mapp.MShare.LookOrderPayBill.hf", SEVERROOTPATHONLINE]
/**用户充值账单接口*/
#define LookRechargeBill [NSString stringWithFormat:@"%@mapp.MShare.LookRechargeBill.hf", SEVERROOTPATHONLINE]
/**交纳押金接口*/
#define SharerPayDeposit [NSString stringWithFormat:@"%@mapp.MShare.SharerPayDeposit.hf", SEVERROOTPATHONLINE]
/**请求支付结果接口*/
#define GetPayResultStatus [NSString stringWithFormat:@"%@mapp.MShare.getPayResultStatus.hf", SEVERROOTPATHONLINE]
/**异常支付状态接口*/
#define SetNOTPayResultStatus [NSString stringWithFormat:@"%@mapp.MShare.setExceptionPayStatus.hf", SEVERROOTPATHONLINE]
//--------------------------外壳接口----------------------------
///**获取外壳详情接口*/
//#define GETSHELLINFO [NSString stringWithFormat:@"%@MShell.getShellInfo.hf", SEVERROOTPATH]
///**获取轮播图接口*/
//#define GETCAROUSELLIST [NSString stringWithFormat:@"%@MShell.getCarouselList.hf", SEVERROOTPATH]
///**获取菜单列表接口*/
//#define GETSHELLITEMLIST [NSString stringWithFormat:@"%@MShell.getShellItemList.hf", SEVERROOTPATH]



//--------------------------消息推送接口--------------------------
///**获取推送消息模块详情接口*/
//#define GETPUSHPARAMETER [NSString stringWithFormat:@"%@MPush.getMPushParameter.hf", SEVERROOTPATH]
///**绑定用户身份标识*/
//#define BINDUSERCLIENTID [NSString stringWithFormat:@"%@MPush.bindUserClientID.hf", SEVERROOTPATH]
///**解除用户身份标识*/
//#define CLEARUSERCLIENTID [NSString stringWithFormat:@"%@MPush.clearUserClientID.hf", SEVERROOTPATH]
///**获取未读消息提示清单*/
//#define GETUNREADNOTICELIST [NSString stringWithFormat:@"%@MPush.getUnReadNoticeList.hf", SEVERROOTPATH]
///**读取消息列表*/
//#define GETMESSAGELIST [NSString stringWithFormat:@"%@MPush.getMessageList.hf", SEVERROOTPATH]
///**读取消息*/
//#define GETMESSAGEINFO [NSString stringWithFormat:@"%@MPush.getMessageInfo.hf", SEVERROOTPATH]
///**提交消息反馈状态*/
//#define SENDMESSAGESTATUS [NSString stringWithFormat:@"%@MPush.sendMessageStatus.hf", SEVERROOTPATH]
//
//
//
////--------------------------新闻接口----------------------------
///**获得新闻模块详情接口*/
//#define GETMNEWSPARAMETER [NSString stringWithFormat:@"%@MNews.getMNewsParameter.hf", SEVERROOTPATH]
///**获得新闻分类接口*/
//#define GETTYPELIST [NSString stringWithFormat:@"%@MNews.getTypeList.hf", SEVERROOTPATH]
///**获得新闻列表接口*/
//#define GETNEWSLIST [NSString stringWithFormat:@"%@MNews.getNewsList.hf", SEVERROOTPATH]
///**获得新闻详情接口*/
//#define GETNEWSINFO [NSString stringWithFormat:@"%@MNews.getNewsInfo.hf", SEVERROOTPATH]
//
//
//
////--------------------------文章接口----------------------------
///**获得文章列表接口*/
//#define MARTI_GETARTICLELIST [NSString stringWithFormat:@"%@MArti.getArticleList.hf", SEVERROOTPATH]
///**获得文章详情接口*/
//#define MARTI_GETARTICLEINFO [NSString stringWithFormat:@"%@MArti.getArticleInfo.hf", SEVERROOTPATH]
///**获得文章分类接口*/
//#define MARTI_GETTYPELIST [NSString stringWithFormat:@"%@MArti.getTypeList.hf", SEVERROOTPATH]
///**获取文章模块详情接口*/
//#define MARTI_GETMARTIPARAMETER [NSString stringWithFormat:@"%@MArti.getMArtiParameter.hf", SEVERROOTPATH]



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
//十六进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/**根据屏幕尺寸调整高度*/
#define HEIGHT(viewHeight) [BaseUtil fitScreenWithHeight:viewHeight] 

#endif /* GlobalConfig_h */
