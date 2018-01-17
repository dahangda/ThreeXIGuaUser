//
//  MyOrderTableViewCell.m
//  hbbciphone
//
//  Created by Handbbc on 2017/8/30.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {  //订单编号字体
        self.backgroundColor = RGBCOLOR(245, 245, 245);
        UILabel *orderNumber = [[UILabel alloc]init];
        orderNumber.font = [UIFont systemFontOfSize:14];
        orderNumber.text = @"订单编号:";
        orderNumber.textColor = [UIColor lightGrayColor];
        [self addSubview:orderNumber];
        [orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.left.equalTo(20);
        }];
        
        
        _orderNumber = [[UILabel alloc]init];
        _orderNumber.font = [UIFont systemFontOfSize:14];
        _orderNumber.text = @"i am test";
        [self addSubview:_orderNumber];
        [_orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orderNumber.right);
            make.top.equalTo(10);
        }];
        
        UIImageView *cellBackView = [[UIImageView alloc]init];
        cellBackView.backgroundColor = [UIColor grayColor];
        [self addSubview:cellBackView];
        [cellBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(32);
            make.height.equalTo(92);
        }];
        
        _imgView = [[UIImageView alloc]init];
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(40);
            make.left.equalTo(20);
            make.width.height.equalTo(75);
        }];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text = @"下单人:";
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(37);
            make.left.equalTo(_imgView.right).offset(10);
        }];
        
        _name = [[UILabel alloc]init];
        _name.font = [UIFont systemFontOfSize:14];
        [self addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameLabel.mas_centerY);
            make.left.equalTo(nameLabel.right).offset(5);
        }];
        
        UILabel *itemNumber = [[UILabel alloc]init];
        itemNumber.font = [UIFont systemFontOfSize:14];
        itemNumber.text = @"物品编号:";
        [self addSubview:itemNumber];
        [itemNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.bottom).offset(5);
            make.left.equalTo(_imgView.right).offset(10);
        }];
        
        _itemNumber = [[UILabel alloc]init];
        _itemNumber.font = [UIFont systemFontOfSize:14];
        _itemNumber.text = @"i am test";
        [self addSubview:_itemNumber];
        [_itemNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(itemNumber.right).offset(5);
            make.centerY.equalTo(itemNumber.mas_centerY);
        }];
        UILabel *phoneLabel = [[UILabel alloc]init];
        phoneLabel.font = [UIFont systemFontOfSize:14];
        phoneLabel.text = @"联系方式:";
        [self addSubview:phoneLabel];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(itemNumber.bottom).offset(5);
            make.left.equalTo(_imgView.right).offset(10);
        }];
        
        _phone = [[UILabel alloc]init];
        _phone.font = [UIFont systemFontOfSize:14];
        [self addSubview:_phone];
        [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(phoneLabel.mas_centerY);
            make.left.equalTo(phoneLabel.right).offset(5);
        }];
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.text = @"订单时间:";
        [self addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(phoneLabel.bottom).offset(5);
            make.left.equalTo(_imgView.right).offset(10);
        }];
        
        _orderTime = [[UILabel alloc]init];
        _orderTime.font = [UIFont systemFontOfSize:14];
        [self addSubview:_orderTime];
        [_orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(timeLabel.mas_centerY);
            make.left.equalTo(timeLabel.right).offset(5);
        }];
        
        _rightImg = [[UIImageView alloc]init];
        _rightImg.alpha = 0.8;
        [self addSubview:_rightImg];
        [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(32);
            make.height.equalTo(92);
            make.right.equalTo(-15);
            make.width.equalTo(30);
        }];
        
        _orderState = [[UILabel alloc]init];
        _orderState.textColor = [UIColor whiteColor];
        _orderState.textAlignment = NSTextAlignmentCenter;
        [_rightImg addSubview:_orderState];
        _orderState.numberOfLines = 0;
        _orderState.font = [UIFont systemFontOfSize:18];
        [_orderState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        UILabel *btmLabel = [[UILabel alloc]init];
        btmLabel.text = @"共一件商品 实付款:";
        btmLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:btmLabel];
        [btmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cellBackView.bottom).offset(10);
            make.left.equalTo(10);
        }];
        
        _money = [[UILabel alloc]init];
        [self addSubview:_money];
        [_money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(btmLabel.right);
            make.top.equalTo(btmLabel.top);
        }];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"" forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"wq"] forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _deleteBtn.layer.masksToBounds = YES;
//        _deleteBtn.layer.cornerRadius = 5;
//        _deleteBtn.layer.borderColor = [UIColor orangeColor].CGColor;
//        _deleteBtn.layer.borderWidth = 1;
        [self addSubview:_deleteBtn];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(5);
            make.right.equalTo(-10);
            make.width.equalTo(20);
            make.height.equalTo(20);
        }];
        [_deleteBtn addTarget:self action:@selector(deleteOrder) forControlEvents:UIControlEventTouchUpInside];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"退房" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftBtn.layer.masksToBounds = YES;
        _leftBtn.layer.cornerRadius = 5;
        _leftBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _leftBtn.layer.borderWidth = 1;
        [self addSubview:_leftBtn];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.top.equalTo(-100);
            make.width.equalTo(60);
            make.height.equalTo(25);
        }];
        [_leftBtn addTarget:self action:@selector(checkOut) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *btmView = [[UIView alloc]init];
        btmView.backgroundColor = RGBCOLOR(218, 219, 220);
        [self addSubview:btmView];
        [btmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(200);
            make.bottom.equalTo(0);
        }];
    }
    return self;
}

//退房
-(void)checkOut
{
    if (self.theOrderBlock)
    {
        self.theOrderBlock();
    }
}

//删除订单
-(void)deleteOrder
{
    if ([_states isEqual:@"10"])
    {
        if (_deleteOrderBlock)
        {
            _deleteOrderBlock();
        }
    }
    else
    {
        UIAlertView *aaaa = [[UIAlertView alloc]initWithTitle:@"亲" message:@"只有已完成订单方可删除哟" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [aaaa show];
    }
}

-(void)setValues:(MyOrderModel *)obj
{
    NSURL *goodsPic = [NSURL URLWithString:obj.GoodsPic];
    [_imgView sd_setImageWithURL:goodsPic];
    _name.text = obj.UserName;
    _phone.text = obj.PhoneNumber;
    _orderTime.text = obj.OrderTime;
    NSString *stringForColor = obj.GoodsUsePrice;
   
    NSString *string = [NSString stringWithFormat:@"￥%@",stringForColor];
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, string.length)];
    _money.attributedText = mAttStri;
    _itemNumber.text = [NSString stringWithFormat:@"%@",obj.GoodsSNID];
    NSArray *arry =  [ obj.OrderPayOrderID componentsSeparatedByString:@"_" ];
    _orderNumber.text = [NSString stringWithFormat:@"  %@",arry.lastObject];
     _orderNumber.textColor = [UIColor lightGrayColor];
    _states = [NSString stringWithFormat:@"%@",obj.Status];
    if ([_states  isEqual: @"8"])
    {
        _orderState.text = @"预定成功";
        _rightImg.backgroundColor = RGBCOLOR(252, 102, 33);
        _leftBtn.hidden = NO;
    }
    else if ([_states isEqual:@"10"])
    {
        _orderState.text = @"订单完成";
        _rightImg.backgroundColor = RGBCOLOR(58, 200, 39);
        _leftBtn.hidden = YES;
    }
    else if([_states isEqual:@"7"])
    {
        _orderState.text = @"支付失败";
        _rightImg.backgroundColor = [UIColor redColor];
        _leftBtn.hidden = YES;
    }
    else
    {
        _orderState.text = @"支付取消";
        _rightImg.backgroundColor = [UIColor redColor];
        _leftBtn.hidden = YES;
    }

    
}
@end
