//
//  GoodsListCell.m
//  LoveFresh
//
//  Created by Jane on 16/5/1.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "GoodsListCell.h"
#import "GoodsHomeModel.h"

@interface GoodsListCell()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *numLabel;

@end

@implementation GoodsListCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;//去掉cell选中效果
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREENWIDTH-110, self.frame.size.height)];
        self.nameLabel.textColor = [UIColor blackColor];
        //    nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.nameLabel];
        
        
        // ** x2
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-100, 0, 50, self.frame.size.height)];
        self.numLabel.textColor = [UIColor blackColor];
        self.numLabel.font = [UIFont systemFontOfSize:14];
        self.numLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.numLabel];
        
        
        
        //
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-80, 0, 60, self.frame.size.height)];
        self.priceLabel.textColor = [UIColor blackColor];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.priceLabel];
        
    }
    return self;
}


+(instancetype)cellWithTableView:(UITableView *)tableView andCellModel:(GoodsHomeModel *)model
{
    static NSString *CellIdentifier = @"cell";
    
    GoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GoodsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.nameLabel.text = model.nameStr;
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.priceStr];
    cell.numLabel.text = [NSString stringWithFormat:@"x%@",model.buyNum];
    
    return cell;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
