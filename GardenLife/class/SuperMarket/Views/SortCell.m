//
//  SortCell.m
//  GardenLife
//
//  Created by Jane on 16/5/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "SortCell.h"

@implementation SortCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWithCollectionView:(UICollectionView *)collection andDataDic:(NSDictionary *)dic andIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    SortCell *cell = [collection dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
    }
    
    NSString *imgStr = nil;
    NSString *nameStr = nil;
    NSString *engStr = nil;
    NSString *priceStr = nil;
    if (!dic[@"pGoods"]) { // 从下拉里面的界面传过来的
        imgStr = dic[@"fnAttachmentSnap1"];
        nameStr = dic[@"fnName"];
        engStr = dic[@"fnEnName"];
        priceStr = [NSString stringWithFormat:@"￥%@",dic[@"fnMarketPrice"]];
    }else{                 // 从sectionHead 点击传过来的数据
        NSDictionary *Dic = dic[@"pGoods"];
        imgStr = Dic[@"fnAttachmentSnap1"];
        nameStr = Dic[@"fnName"];
        engStr = Dic[@"fnEnName"];
        priceStr = [NSString stringWithFormat:@"￥%@",Dic[@"fnMarketPrice"]];
        
    }
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:PLACEIMAGE];
    [cell.nameLabel setText:nameStr];
    cell.engLabel.text = engStr;
    cell.priceLabel.text = priceStr;
    
    return cell;
}


@end
