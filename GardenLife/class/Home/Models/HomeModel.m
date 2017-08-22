//
//  HomeModel.m
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+(instancetype)buildModelWithDataDic:(NSDictionary *)dic
{
    HomeModel *model = [[HomeModel alloc] init];
    
    model.idStr = [NSString stringWithFormat:@"%@",dic[@"id"]];//
    
    model.imgUrlStr = dic[@"smallIcon"];
    
    model.iconImgStr = dic[@"author"][@"headImg"];
    model.nameStr = dic[@"author"][@"userName"];
    model.rzStr = dic[@"author"][@"identity"];
    model.categoryStr = dic[@"category"][@"name"];
    model.titleStr = dic[@"title"];
    model.desStr = dic[@"desc"];
    
    model.liulangStr = [NSString stringWithFormat:@"%@",dic[@"newRead"]];//
    model.collectedNum = [NSString stringWithFormat:@"%@",dic[@"newFavo"]];
    model.huifuStr = [NSString stringWithFormat:@"%@",dic[@"fnCommentNum"]];
    
    model.createDateStr= dic[@"createDate"];
    
    return model;
}

+(instancetype)buildTOP10ModelWithDataDic:(NSDictionary *)dic
{
    HomeModel *model = [[HomeModel alloc] init];
    
    model.idStr = [NSString stringWithFormat:@"%@",dic[@"id"]];//
    
    model.imgUrlStr = dic[@"smallIcon"];
    
    model.iconImgStr = @"http://static.htxq.net/UploadFiles/headimg/20160422164405309.jpg";
    model.nameStr = @"花田小憩";
    model.rzStr = @"官方认证";
    model.desStr = @"花田小憩";
    model.categoryStr = @"家居庭院";
    model.titleStr = dic[@"title"];

    
    model.liulangStr = [NSString stringWithFormat:@"%@",dic[@"read"]];//
    model.collectedNum = [NSString stringWithFormat:@"%@",dic[@"favo"]];
    model.huifuStr = [NSString stringWithFormat:@"%@",dic[@"fnCommentNum"]];
    
    model.createDateStr = dic[@"createDate"];
    
    return model;
}
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
+(instancetype)buildModelFromDateBase
{
    HomeModel *model = [[HomeModel alloc] init];
    
    
    
    
    
    return model;
}

@end
