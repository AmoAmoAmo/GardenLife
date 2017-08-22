//
//  BuyView.h
//  
//
//  Created by Jane on 16/4/29.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsHomeModel.h"


@protocol BuyViewDelegate <NSObject>

-(void)buyViewDidCilckAddBtn;

@end

@interface BuyView : UIView

/** 库存数量 */
@property (nonatomic,assign) NSInteger shouldByNum; // ****
/** label 该商品已加入购物车的数量 */
@property (nonatomic,strong) UILabel *buyCountLabel;

@property (nonatomic,strong) UIButton *addBtn;

@property (nonatomic,strong) UIButton *reduceBtn;
/** 数据源 */
@property (nonatomic,strong) NSDictionary *dataDic; // ****
@property (nonatomic,strong) GoodsHomeModel *model;



+(instancetype)createWithShouldBuyNum:(NSInteger)num andFrame:(CGRect)frame;

+(instancetype)createWithGoodsDataDic:(NSDictionary*)dic andFrame:(CGRect)frame;
@property (nonatomic,strong) NSDictionary *dataDictionary;


@property (nonatomic, assign) id<BuyViewDelegate> delegate;


@end
