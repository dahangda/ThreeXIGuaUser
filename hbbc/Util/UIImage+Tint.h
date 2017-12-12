//
//  UIImage+Tint.h
//  pgyniphone
//
//  Created by mac on 2016/10/31.
//  Copyright © 2016年 hbbc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

/**渲染图片颜色*/
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;



/**按通道梯度渲染图片颜色*/
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

@end
