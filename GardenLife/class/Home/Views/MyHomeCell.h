//
//  MyHomeCell.h
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModel;

@interface MyHomeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rzLabel;
@property (weak, nonatomic) IBOutlet UILabel *catgoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@property (weak, nonatomic) IBOutlet UILabel *liulangLabel;
@property (weak, nonatomic) IBOutlet UILabel *huifuLabel;

@property (nonatomic, strong) HomeModel * model;
+(instancetype)cellWithTable:(UITableView*)table andModel:(HomeModel*)homeModel andDataDic:(NSDictionary*)dic;

@end
