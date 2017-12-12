//
//  ShareAnnotation.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/17.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "ShareAnnotation.h"
#import "ShareListViewController.h"
#define kWidth  50.f
#define kHeight 50.f


#define kPortraitWidth  50.f
#define kPortraitHeight 50.f


@interface ShareAnnotation ()


@property (nonatomic, strong) UILabel *nameLabel;

@end



@implementation ShareAnnotation
@synthesize image;
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{


    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
            }
    else
    {
//        [self.calloutView removeFromSuperview];
    }
    [super setSelected:selected animated:animated];

}


-(UIImage *)imageV
{

    return self.portraitImageView.image;
}

-(void)setImageV:(UIImage *)imageV{

    self.portraitImageView.image=imageV;

}


-(id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    
    self =[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    
    
    if (self) {
        self.bounds = CGRectMake(0, 0, kWidth, kHeight);
        
        self.portraitImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kPortraitWidth, kPortraitHeight)];
        _portraitImageView.layer.masksToBounds = YES;
        _portraitImageView.layer.cornerRadius = 25;
     
        [self addSubview:self.portraitImageView];
        
//        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,10,20,20)];
//        
//        self.nameLabel.backgroundColor  = [UIColor clearColor];
//        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
//        self.nameLabel.textColor        = [UIColor grayColor];
//    
//        [self addSubview:self.nameLabel];
    }
    
    return self;
    
}


@end
