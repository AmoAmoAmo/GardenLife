//
//  Top1Cell.h
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;
@interface Top1Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;



@property (nonatomic, strong) HomeModel * model;
+(instancetype)cellWithTable:(UITableView*)table andModel:(HomeModel*)homeModel andIndexPath:(NSIndexPath*)indexPath;
@end
