//
//  OrderCell.h
//  LoveFresh
//
//  Created by Jane on 16/4/21.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrdersModel;

@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *deleteLabel;

@property (nonatomic,strong) OrdersModel *orderModel;

+(instancetype)cellWithTableView:(UITableView *)tableView andCellModel:(OrdersModel *)model;

@end
