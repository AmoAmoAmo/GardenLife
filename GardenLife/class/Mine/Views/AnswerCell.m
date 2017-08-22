//
//  AnswerCell.m
//  GardenLife
//
//  Created by Jane on 16/5/5.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "AnswerCell.h"
#import "QuestionsModel.h"

@interface AnswerCell()

@property (nonatomic,strong) NSMutableArray *dataArr;

@end


@implementation AnswerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;//去掉cell选中效果
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(20, 0, SCREENWIDTH-40, 1)];
        lineV.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineV];

    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView andDatamodel:(QuestionsModel *)model
{
    
    static NSString *CellIdentifier = @"cell";
    
//    AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
    
        AnswerCell *cell = [[AnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.model = model;
//    }
    

    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(20, 0, SCREENWIDTH-40, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:lineV];

    for (int i = 0; i < cell.model.textArr.count; i++) {
        
        CGFloat textY = 0;
        for (int j = 0; j < i; j++) {
            textY += [cell.model.everyRowHeightArr[j] floatValue];
        }
//        NSLog(@"textY === %f",[model.everyRowHeightArr[i] floatValue]);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, textY, SCREENWIDTH-20, [model.everyRowHeightArr[i] floatValue])];
        label.text = [NSString stringWithFormat:@"%@",model.textArr[i]];
//        NSLog(@"textArr   %@",cell.model.textArr[i]);
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        
        [cell addSubview:label];
    }
    
    
    
    
    
    return cell;
}


@end
