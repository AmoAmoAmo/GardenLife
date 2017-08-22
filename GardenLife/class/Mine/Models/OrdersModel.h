//
//  OrdersModel.h
//  LoveFresh
//
//  Created by Jane on 16/4/21.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrdersModel : NSObject

/** 交易时间 */
@property (nonatomic, copy) NSString *create_time_Str;

@property (nonatomic, copy) NSString *pay_status_Str;

@property (nonatomic, copy) NSString *real_amount_Str;

@property (nonatomic, copy) NSString *buy_num_Str;

@property (nonatomic, strong) NSArray *order_goods_Arr;
/** 订单预览的图片数组 */
@property (nonatomic, strong) NSMutableArray *imgs_Arr;


@end
