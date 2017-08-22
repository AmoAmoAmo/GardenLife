//
//  GoodsListCell.h
//  LoveFresh
//
//  Created by Jane on 16/5/1.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsHomeModel;

@interface GoodsListCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView andCellModel:(GoodsHomeModel *)model;

@end
