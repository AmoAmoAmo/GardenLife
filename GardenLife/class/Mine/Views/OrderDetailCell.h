//
//  OrderDetailCell.h
//  LoveFresh
//
//  Created by Jane on 16/4/23.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

+(instancetype)createCellWithTabel:(UITableView *)tabelView andData:(NSDictionary *)dic;

@end
