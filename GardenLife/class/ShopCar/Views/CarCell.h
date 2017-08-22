//
//  CarCell.h
//  LoveFresh
//
//  Created by Jane on 16/5/1.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsHomeModel.h"
#import "BuyView.h"

@interface CarCell : UITableViewCell

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) BuyView *buyView;


+(instancetype)cellWithTableView:(UITableView *)tableView andCellModel:(GoodsHomeModel *)model;

@end
