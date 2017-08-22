//
//  SortCell.h
//  GardenLife
//
//  Created by Jane on 16/5/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *engLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


+(instancetype)cellWithCollectionView:(UICollectionView*)collection andDataDic:(NSDictionary *)dic andIndexPath:(NSIndexPath*)indexPath;

@end
