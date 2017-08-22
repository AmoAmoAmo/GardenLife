//
//  LikeView.h
//  GardenLife
//
//  Created by Jane on 16/5/9.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModel;

@interface LikeView : UIView

@property (nonatomic,strong) UIButton *likeBtn;
@property (nonatomic,strong) UILabel *numLabel;
/** 把dataDic 传过来 */
@property (nonatomic,strong) NSDictionary *dataDic;
/** 把数据库的model传过来 */
@property (nonatomic,strong) HomeModel *model;


+(instancetype)createLikeViewWithIsLike:(BOOL)isLike andNum:(NSInteger)num;

-(void)isLike;
-(void)canselLike;

@end
