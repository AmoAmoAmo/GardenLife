//
//  DetailViewController.h
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModel;

@interface DetailViewController : UIViewController

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, copy) NSString *idStr;
/** 专题->top    商品-> goods   收藏->db */
@property (nonatomic, copy) NSString *flagStr;


/** 把dataDic 传过来 */
@property (nonatomic,strong) NSDictionary *dataDic;
/** 没有dataDic的 传model */
@property (nonatomic,strong) HomeModel *myModel;

/** 把goods的图片传过来 */
@property (nonatomic,copy) NSString *imageStr;
/** fnMarketPrice */
@property (nonatomic,copy) NSString *priceStr;

@end
