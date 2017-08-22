//
//  Top1Cell.m
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "Top1Cell.h"
#import "HomeModel.h"

@implementation Top1Cell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWithTable:(UITableView *)table andModel:(HomeModel *)homeModel andIndexPath:(NSIndexPath*)indexPath
{
    static NSString *idStr = @"homeCell";
    
    Top1Cell *cell = [table dequeueReusableCellWithIdentifier:idStr];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.numLabel.text = [NSString stringWithFormat:@"TOP %ld",indexPath.row+1];
    cell.model = homeModel;
    return cell;
}


-(void)setModel:(HomeModel *)model
{
    _model = model;
    
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrlStr] placeholderImage:PLACEIMAGE];
    
    self.nameLabel.text = model.titleStr;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
