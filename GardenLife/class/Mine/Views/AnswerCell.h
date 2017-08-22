//
//  AnswerCell.h
//  GardenLife
//
//  Created by Jane on 16/5/5.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuestionsModel;

@interface AnswerCell : UITableViewCell



@property (nonatomic,strong) QuestionsModel *model;


+(instancetype)cellWithTableView:(UITableView *)tableView andDatamodel:(QuestionsModel*)model;

@end
