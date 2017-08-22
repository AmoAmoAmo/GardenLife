//
//  OrderHeadView.m
//  LoveFresh
//
//  Created by Jane on 16/4/22.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "OrderHeadView.h"

@implementation OrderHeadView

-(void)awakeFromNib
{
    self.label.clipsToBounds = YES;
    self.label.layer.cornerRadius = 5;
}

+(instancetype)createHeadViewWithData:(NSDictionary *)dataDic
{
    OrderHeadView *headView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    
    headView.orderNumLabel.text = dataDic[@"order_no"];
    headView.numLabel.text = dataDic[@"checknum"];
    headView.timeLabel.text = dataDic[@"create_time"];
    headView.sendLabel.text = dataDic[@"accept_time"];
    
    headView.nameLabel.text = dataDic[@"accept_name"];
    headView.telLabel.text = dataDic[@"telphone"];
    headView.addrLabel.text = dataDic[@"address"];
    headView.storeLabel.text = dataDic[@"dealer_name"];
    
    return headView;
}

@end
