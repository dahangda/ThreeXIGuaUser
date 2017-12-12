//
//  MyMessageViewController.m
//  hbbciphone
//
//  Created by mac on 2016/11/15.
//  Copyright © 2016年 hbbc. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyMessageView.h"

@interface MyMessageViewController ()

@property (nonatomic, strong) MyMessageView *myMessageView;
@property (nonatomic, strong) UIImageView *navigationImageView;

@end

@implementation MyMessageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationImageView.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    [_myMessageView viewWillAppear];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _navigationImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    _myMessageView = [[MyMessageView alloc] initWithFrame:self.view.bounds withViewController:self];
    _myMessageView.messageTypeList = _messageTypeList;
    self.view = _myMessageView;
    
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationImageView.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    [_myMessageView viewWillDisappear];
}



/**找到UINavigationBar下部imageView*/
-(UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}



//获取未读消息提示清单
- (void)getMessageListMTID:(NSString *)MTID count:(NSInteger)count {
    if ([ShellInfo shareShellInfo].pushID) {
        NSDictionary *parameters = @{@"AppUserID" : APPUSERID,
                                     @"ECID" : ECID,
                                     @"MTID" : MTID,
                                     @"PushID" : [ShellInfo shareShellInfo].pushID,
                                     @"UserType" : @([GlobalParameter sharepeopleInfo].PersonFlag),
                                     @"UserID" : USERID,
                                     @"Count" : @(count)
                                     };
        [[NetworkSingleton shareManager] httpRequest:parameters url:GETMESSAGELIST success:^(id responseBody) {
            DHResponseBodyLog(responseBody);
            [GlobalParameter sharepeopleInfo].GWGTID = responseBody[@"GWGTID"];
        } failed:^(NSError *error) {
            DHErrorLog(error);
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
