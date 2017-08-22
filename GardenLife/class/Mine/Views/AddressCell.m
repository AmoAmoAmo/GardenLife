//
//  AddressCell.m
//  LoveFresh
//
//  Created by Jane on 16/4/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    // Initialization code
    
    self.nameLabel.highlightedTextColor = [UIColor redColor];
}


+(instancetype)createCellWithTabel:(UITableView *)tableView andDataDic:(NSDictionary *)dic
{
    static NSString *idString = @"cell";
    
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    }
    
    cell.nameLabel.text = dic[@"name"];
    cell.telLabel.text = dic[@"telphone"];
    cell.addressLabel.text = dic[@"address"];
    
    return cell;
}



//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//    [self addSubview:self.lineView];
//    self.lineView.hidden = !selected;
//    NSLog(@"select %d",!selected);
////    if (selected) {
////        self.nameLabel.highlightedTextColor = [UIColor redColor];
////    }
//}

@end
