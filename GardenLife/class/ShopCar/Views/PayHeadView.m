//
//  PayHeadView.m
//  LoveFresh
//
//  Created by Jane on 16/5/1.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "PayHeadView.h"

@implementation PayHeadView

+(instancetype)createPayHeadViewWithDataDic:(NSDictionary *)dic
{
    PayHeadView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
    
    view.nameLabel.text = dic[@"name"];
    view.phoneLabel.text = dic[@"telphone"];
    view.addrLabel.text = dic[@"address"];
    
    return view;
}

@end
