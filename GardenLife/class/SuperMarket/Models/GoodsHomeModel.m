//
//  GoodsHomeModel.m
//  LoveFresh
//
//  Created by Jane on 16/4/21.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "GoodsHomeModel.h"

@implementation GoodsHomeModel

-(void)setImgStr:(NSString *)imgStr
{
    _imgStr = [NSString stringWithFormat:IMGURL,imgStr];
}

-(void)setTagImgStr:(NSString *)tagImgStr
{
    _tagImgStr = [NSString stringWithFormat:IMGURL,tagImgStr];
}

@end
