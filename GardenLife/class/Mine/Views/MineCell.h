//
//  MineCell.h
//  GardenLife
//
//  Created by Jane on 16/5/5.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView andDataDic:(NSDictionary*)dic;

@end