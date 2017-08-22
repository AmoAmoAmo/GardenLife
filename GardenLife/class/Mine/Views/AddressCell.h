//
//  AddressCell.h
//  LoveFresh
//
//  Created by Jane on 16/4/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UIView *lineView;


+(instancetype)createCellWithTabel:(UITableView *)tableView andDataDic:(NSDictionary *)dic;

@end
