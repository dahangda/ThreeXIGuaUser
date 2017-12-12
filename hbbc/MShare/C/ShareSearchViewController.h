//
//  ShareSearchViewController.h
//  hbbciphone
//
//  Created by Handbbc on 2017/7/12.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^addressBlock)(NSString *address);

@interface ShareSearchViewController : UIViewController

@property (nonatomic,strong)NSString *myLocation;


@property (nonatomic,copy)addressBlock aBlock;




@end
