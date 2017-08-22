//
//  JingCell.h
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickAddWithImgViewBlock)(UIImageView *imgView);





@interface JingCell : UITableViewCell

@property (nonatomic, copy) ClickAddWithImgViewBlock clickAddBlock;
-(void)clickAddBtnandReturnImgView:(ClickAddWithImgViewBlock)block;




@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *engLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (weak, nonatomic) IBOutlet UIView *tagView;

+(instancetype)cellWithTable:(UITableView*)table andDataDic:(NSDictionary*)dic;

@end
