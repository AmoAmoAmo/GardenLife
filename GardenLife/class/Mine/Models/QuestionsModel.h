//
//  QuestionsModel.h
//  LoveFresh
//
//  Created by Jane on 16/4/12.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionsModel : NSObject

@property(nonatomic,assign) CGFloat cellHeight;
/** 装每个labelheight的数组arr,装进数组的字符串，使用时记得转换回来 */
@property (nonatomic,strong) NSMutableArray *everyRowHeightArr;

@property (nonatomic,strong) NSMutableArray *textArr;

@property (nonatomic,copy) NSString *questionStr;

//@property (nonatomic,copy) NSString *answerStr;

+(instancetype)setQuestionsModelWithDic:(NSDictionary *)dic;

@end
