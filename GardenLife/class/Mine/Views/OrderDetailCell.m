//
//  OrderDetailCell.m
//  LoveFresh
//
//  Created by Jane on 16/4/23.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "OrderDetailCell.h"

@implementation OrderDetailCell

- (void)awakeFromNib {
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;//去掉cell选中效果
}

+(instancetype)createCellWithTabel:(UITableView *)tabelView andData:(NSDictionary *)dic
{
    static NSString *idString = @"textCell";
    
    OrderDetailCell *cell = [tabelView dequeueReusableCellWithIdentifier:idString];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    }
    
    cell.nameLabel.text = dic[@"name"];
    cell.numLabel.text = [NSString stringWithFormat:@"x%@",dic[@"goods_nums"]];
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"real_price"]];
    
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
