//
//  HJTabBar.m
//  GardenLife
//
//  Created by Jane on 16/5/6.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "HJTabBar.h"
#import "RedView.h"
#import "FMDBmanager.h"


@interface HJTabBar()

@property (nonatomic,strong) RedView *redView;

@end

@implementation HJTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.redView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addRedToTabBar) name:@"redViewNeedToReset" object:nil];
    }
    return self;
}

-(void)addRedToTabBar
{
    [self addSubview:self.redView];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(RedView *)redView
{
    if (!_redView) {
        
        _redView = [RedView shareRedView];
        _redView.frame = CGRectMake(SCREENWIDTH -SCREENWIDTH/4 -25 , -3, 20, 20);
        //**** 初始化 购物车总数 ****
        //**** 初始化 购物车总数 ****
        //    **** loadDataFromDB ****
        FMDBmanager *manager = [FMDBmanager shareInstance];
        NSString *sqlString = [NSString stringWithFormat:@"select buyNum from Car"];
        FMResultSet *rs = [manager.dataBase executeQuery:sqlString];
        NSInteger num = 0;
        while ([rs next]) {
            num = num + [rs intForColumn:@"buyNum"];
        }
        if (num) {
            //            vc3.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",num];
            self.redView.buyNum = num;
        }
    }
    return _redView;
}
@end
