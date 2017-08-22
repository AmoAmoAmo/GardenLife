//
//  FMDBmanager.m
//  Weekend
//
//  Created by Jane on 16/4/15.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "FMDBmanager.h"

@implementation FMDBmanager

+(instancetype)shareInstance
{
    static FMDBmanager *manager;    // manager 为单例对象本身
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[FMDBmanager alloc] init];
    });
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 数据库的沙盒路径
        NSString *dbPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/myData.db"];
//        NSLog(@"%@",dbPath);
        
        // 创建数据库对象
        self.dataBase = [FMDatabase databaseWithPath:dbPath];
        
        // 打开数据库
        if (![self.dataBase open]) {
            NSLog(@"数据库打开失败...");
        }
        
        
        // 如果不存在表 创建表
        //   (idStr以商品detail的id为准)
        //   (即http://ec.htxq.net/rest/htxq/goods/detail/34358b05-03e9-4d59-a998-90fc128f061b?customerId= )
        NSString *sqlString = [NSString stringWithFormat:@"create table if not exists Car (id integer primary key,idStr text,name text,price text, shouldBuyCount text ,buyNum integer)"];
        if(![self.dataBase executeUpdate:sqlString])
        {
            NSLog(@"创建表格失败");
        }
        
        
//        收藏列表
        NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists Like (id integer primary key,idStr text,icon text,name text, rzStr text ,lookNum text,imgUrl text,title text,category text, commentNum text, desStr text, likeNum text, createDate text)"];
        if(![self.dataBase executeUpdate:sqlStr])
        {
            NSLog(@"创建表格失败");
        }
    }
    return self;
}

@end
