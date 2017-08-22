//
//  GoodsHomeModel.h
//  LoveFresh
//
//  Created by Jane on 16/4/21.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsHomeModel : NSObject

@property (nonatomic, copy) NSString *idStr;        //**

@property (nonatomic, copy) NSString *imgStr;

@property (nonatomic, copy) NSString *tagImgStr;

@property (nonatomic, copy) NSString *nameStr;      //**

@property (nonatomic, copy) NSString *subNameStr;

@property (nonatomic, copy) NSString *priceStr;     //**

@property (nonatomic, copy) NSString *oldPriceStr;
/** 库存个数 */
@property (nonatomic, copy) NSString *shouldBuyCount;//**
/** 加入购物车个数 */
@property (nonatomic, copy) NSString *buyNum;       //**
@end
