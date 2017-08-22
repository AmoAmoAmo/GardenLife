//
//  HomeModel.h
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic,copy) NSString *idStr;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *imgUrlStr;
@property (nonatomic, copy) NSString *iconImgStr;
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *rzStr;
@property (nonatomic, copy) NSString *categoryStr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *desStr;

@property (nonatomic, copy) NSString *liulangStr;
@property (nonatomic, copy) NSString *collectedNum;
@property (nonatomic, copy) NSString *huifuStr;

@property (nonatomic, assign) BOOL isCollectioned;
/** 
imgView;
 
iconImgView;
nameLabel;
rzLabel;
catgoryLabel;
titleLabel;
desLabel;
 
liulangLabel;
likeBtn;
huifuLabel;
 */
@property (nonatomic,copy) NSString *createDateStr;


+(instancetype)buildModelWithDataDic:(NSDictionary *)dic;
+(instancetype)buildTOP10ModelWithDataDic:(NSDictionary *)dic;
+(instancetype)buildModelFromDateBase;

@end
