//
//  MyMessageView.h
//  hbbciphone
//
//  Created by mac on 2016/11/15.
//  Copyright © 2016年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMessageViewController.h"

@interface MyMessageView : UIView

/**消息种类列表  传往消息页面*/
@property (nonatomic, strong) NSArray *messageTypeList;

/**用frame和viewController初始化页面*/
- (instancetype)initWithFrame:(CGRect)frame withViewController:(MyMessageViewController *)viewController;



/**页面即将出现*/
- (void)viewWillAppear;



/**页面即将消失*/
- (void)viewWillDisappear;

@end
