//
//  RedView.h
//  
//
//  Created by Jane on 16/4/26.
//  Copyright © 2016年 Jane. All rights reserved.
//
//  小红点和数字

#import <UIKit/UIKit.h>

@interface RedView : UIView

/** 购物车的总数 */
@property (nonatomic, assign) NSInteger buyNum;

/** 单例 */
+(instancetype)shareRedView;

-(void)addProductToRedDotView;
-(void)reduceProductToRedDotView;

@end
