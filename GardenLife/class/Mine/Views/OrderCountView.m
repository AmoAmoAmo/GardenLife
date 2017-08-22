//
//  OrderCountView.m
//  LoveFresh
//
//  Created by Jane on 16/4/23.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "OrderCountView.h"

@implementation OrderCountView
-(void)awakeFromNib
{
    self.frame = CGRectMake(0, 0, SCREENWIDTH, 135);
}


+(instancetype)createOrderCountViewWithData:(NSDictionary *)dic
{
    OrderCountView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    
    view.sendLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"taxes"]];
    view.seviseLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"service_fee"]];
    view.tickLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"promotions"]];
    view.totalLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"real_amount"]];
    
    
    return view;
}

@end
