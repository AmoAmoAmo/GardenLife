//
//  NSString+CoutDate.m
//  GardenLife
//
//  Created by Jane on 16/5/9.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "NSString+CoutDate.h"

@implementation NSString (CoutDate)

-(NSString *)countDateString
{
    // 当前时间
    NSDate *senddate=[NSDate date];// senddate === 2016-05-09 09:08:32 +0000
//    NSLog(@"senddate === %@",senddate);
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
//    NSLog(@"locationString:%@",locationString);
    
    
    // 处理服务器传过来的字符串  "2016-05-02 15:07:41.0"
    
    //字符串的长度 9
    NSString *str1 = [self substringToIndex:10];// 0 到index 10，但不包括10  //str1 === 2016-05-02
//    NSLog(@"str1 === %@",str1);
    // 字符串分隔后的集合
    NSArray *resultArr = [str1 componentsSeparatedByString:@"-"];
    
    
    NSString *str = [resultArr componentsJoinedByString:@""];//str  ***** 20160502
//    NSLog(@"str  ***** %@",str);

//    计算
    NSInteger createIndex = [str intValue];
    NSInteger nowIndex = [locationString intValue];
    
    NSInteger resultIndex = nowIndex - createIndex;
    
    // 最后返回的字符串
    NSString *resultStr = nil;
    
    if (resultIndex < 30) {
        resultStr = [NSString stringWithFormat:@"%ld天前",resultIndex];
    }else{
        resultStr = [NSString stringWithFormat:@"一个月前"];
    }
    
    return resultStr;
}

@end
