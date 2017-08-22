//
//  NSString+CoutDate.h
//  GardenLife
//
//  Created by Jane on 16/5/9.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CoutDate)

/** 根据服务器返回的字符串"2016-05-02 15:07:41.0"，计算距现在的时间差是几天 */
-(NSString *)countDateString;

@end
