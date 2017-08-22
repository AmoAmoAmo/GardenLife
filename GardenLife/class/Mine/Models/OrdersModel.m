//
//  OrdersModel.m
//  LoveFresh
//
//  Created by Jane on 16/4/21.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "OrdersModel.h"

@implementation OrdersModel

-(void)setOrder_goods_Arr:(NSArray *)order_goods_Arr
{
    _order_goods_Arr = order_goods_Arr;
    
    NSMutableArray *Arr = [NSMutableArray array];
//    NSLog(@"sanmu*****%ld",order_goods_Arr.count < 5 ? order_goods_Arr.count : 5);
    for (int i = 0; i < (order_goods_Arr.count < 5 ? order_goods_Arr.count : 5); i++)
    {
        NSString *imgStr;
        if (i == 4) {
            imgStr = @"more";
        }else{
            NSArray *arr = order_goods_Arr[i];
            NSDictionary *dic= arr[0];
            imgStr = dic[@"img"];
        }
//        NSLog(@"imgStr ------ %@",imgStr);
        [Arr addObject:imgStr];
    }
    _imgs_Arr = Arr;
}

@end
