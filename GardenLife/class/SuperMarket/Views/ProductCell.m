//
//  ProductCell.m
//  GardenLife
//
//  Created by Jane on 16/5/4.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ProductCell.h"


@implementation ProductCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWithCollection:(UICollectionView *)collection andDataDic:(NSDictionary *)dic andIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idStr = @"cell";
    
    ProductCell *cell = [collection dequeueReusableCellWithReuseIdentifier:idStr forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    }
    
    // *** data ****
    NSDictionary *tempDic = dic[@"pGoods"];
    
    [cell.bgImgView sd_setImageWithURL:[NSURL URLWithString:tempDic[@"fnAttachmentSnap1"]] placeholderImage:PLACEIMAGE];
    
    cell.engLabel.text = tempDic[@"fnEnName"];
    cell.titleLabel.text = tempDic[@"fnName"];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@",tempDic[@"fnMarketPrice"]];
 
    return cell;
}



@end
