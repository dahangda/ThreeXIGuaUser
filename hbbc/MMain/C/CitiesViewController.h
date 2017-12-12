//
//  CitiesViewController.h
//  pgyapp
//
//  Created by HBBC-IMacA on 16/5/28.
//  Copyright © 2016年 handbbc. All rights reserved.
//

#import <UIKit/UIKit.h>
//修改信息代理
@protocol CitiesViewDelegate <NSObject>
- (void)changeCities:(NSString *)cityName andcityCode:(NSString *)cityCode andIndexPath:(NSIndexPath *)indexPath;
@end
@interface CitiesViewController : UIViewController
@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSIndexPath *indexPath;//上一级页面点击的位置
@property (weak, nonatomic) id<CitiesViewDelegate> delegate;
@end
