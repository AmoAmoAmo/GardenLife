//
//  Top2Cell.h
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;
@interface Top2Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *numView;


@property (nonatomic, strong) HomeModel * model;
+(instancetype)cellWithTable:(UITableView*)table andModel:(HomeModel*)homeModel andIndexPath:(NSIndexPath*)indexPath;
@end
