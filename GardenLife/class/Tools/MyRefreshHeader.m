//
//  MyRefreshHeader.m
//  Weekend
//
//  Created by Jane on 16/4/15.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "MyRefreshHeader.h"
#import "UIImage+Size.h"

@implementation MyRefreshHeader

#pragma mark - 重写方法
#pragma mark 基本设置
-(void)prepare
{
    [super prepare];
    
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i<=3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"loading-%d", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *newImage = [image imageByScalingToSize:CGSizeMake(30, 30)];
        [idleImages addObject:newImage];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 3; i<=3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"loading-%d", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *newImage = [image imageByScalingToSize:CGSizeMake(30, 30)];
        [refreshingImages addObject:newImage];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    NSMutableArray *startImages = [NSMutableArray array];
    //    for (NSUInteger i = 50; i<= 75; i++) {
    //        NSString *imageName = [NSString stringWithFormat:@"loading_0%02zd", i];
    //        UIImage *image = [UIImage imageNamed:imageName];
    //        UIImage *newImage = [image imageByScalingToSize:CGSizeMake(40, 40)];
    //        [startImages addObject:newImage];
    //    }
    for (int i = 3; i<= 24; i++) {
        NSString *imageName = [NSString stringWithFormat:@"loading-%d", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *newImage = [image imageByScalingToSize:CGSizeMake(30, 30)];
        [startImages addObject:newImage];
    }
    // 设置正在刷新状态的动画图片
    [self setImages:startImages forState:MJRefreshStateRefreshing];
}

@end
