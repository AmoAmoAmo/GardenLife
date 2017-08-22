//
//  ProductCell.h
//  GardenLife
//
//  Created by Jane on 16/5/4.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ProductCell : UICollectionViewCell




@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *engLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

+(instancetype)cellWithCollection:(UICollectionView*)collection andDataDic:(NSDictionary*)dic andIndexPath:(NSIndexPath*)indexPath;

@end
