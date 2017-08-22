//
//  QuestionsModel.m
//  LoveFresh
//
//  Created by Jane on 16/4/12.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "QuestionsModel.h"

@implementation QuestionsModel

+(instancetype)setQuestionsModelWithDic:(NSDictionary *)dic
{
    QuestionsModel *model = [[self alloc] init];
    
    model.questionStr = dic[@"title"];
    model.textArr = dic[@"texts"];
//    model.answerStr = arr[0];
    
    CGSize maxSize = CGSizeMake(SCREENWIDTH-40, MAXFLOAT);
    
    for (int i = 0; i < model.textArr.count; i++) {
        
        CGFloat rowHeight = [model.textArr[i] boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height + 15;
        
        model.cellHeight += rowHeight;
        
        [model.everyRowHeightArr addObject:[NSString stringWithFormat:@"%f",rowHeight]];
//        NSLog(@"%@",model.everyRowHeightArr[i]);
    }

    return model;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.everyRowHeightArr = [NSMutableArray array];
    }
    return self;
}

@end
