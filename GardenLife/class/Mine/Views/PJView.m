//
//  PJView.m
//  LoveFresh
//
//  Created by Jane on 16/4/22.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "PJView.h"

@implementation PJView





+(instancetype)createFootViewWithData:(NSDictionary *)dic
{
    PJView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    
    view.commentLabel.text = dic[@"comment"];
    
    NSInteger starNum = [dic[@"star"] intValue];
    
    for (int i = 0; i < starNum; i++)
    {
        switch (i) {
            case 0:
                view.starBtn1.selected = YES;
                break;
            case 1:
                view.starBtn2.selected = YES;
                break;
            case 2:
                view.starBtn3.selected = YES;
                break;
            case 3:
                view.starBtn4.selected = YES;
                break;
            case 4:
                view.starBtn5.selected = YES;
                break;
                
            default:
                break;
        }
    }
//    view.starBtn1.selected = YES;
//    view.starBtn2.selected = YES;
//    view.starBtn3.selected = YES;
//    view.starBtn4.selected = YES;
//    view.starBtn5.selected = YES;
    
    return view;
}

@end
