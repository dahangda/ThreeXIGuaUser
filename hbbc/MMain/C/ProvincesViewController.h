//
//  LocationViewController.h
//  pgyapp
//
//  Created by HBBC-IMacA on 16/5/28.
//  Copyright © 2016年 handbbc. All rights reserved.
//

#import <UIKit/UIKit.h>
//修改信息代理
@protocol ProvincesViewDelegate <NSObject>
- (void)changeInfoDelegate:(NSString *)changeString andIndex:(NSIndexPath *)currentIndexPath;
@end
@interface ProvincesViewController : UIViewController
@property (strong, nonatomic) NSString *locationString;
@property (strong, nonatomic) NSArray *provinces;
@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (weak, nonatomic) id<ProvincesViewDelegate> delegate;
@end
