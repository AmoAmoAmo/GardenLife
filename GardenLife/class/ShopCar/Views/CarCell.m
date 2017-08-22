//
//  CarCell.m
//  LoveFresh
//
//  Created by Jane on 16/5/1.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "CarCell.h"
#import "BuyView.h"

@implementation CarCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;//去掉cell选中效果
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH-100, self.frame.size.height)];
        self.nameLabel.textColor = [UIColor blackColor];
        //    nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.nameLabel];
        
        
        //
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-100-50, 0, 50, self.frame.size.height)];
        self.priceLabel.textColor = [UIColor blackColor];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.priceLabel];
        
        
        
        // buyView
        self.buyView = [BuyView createWithShouldBuyNum:1 andFrame:CGRectMake(SCREENWIDTH-100, (self.frame.size.height-25)*0.5, 80, 25)];
        [self addSubview:self.buyView];
        
        
    }
    return self;
}




+(instancetype)cellWithTableView:(UITableView *)tableView andCellModel:(GoodsHomeModel *)model
{
    static NSString *CellIdentifier = @"cell";
    
    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.nameLabel.text = model.nameStr;
    cell.priceLabel.text = model.priceStr;
    
    cell.buyView.addBtn.hidden = NO;
    cell.buyView.reduceBtn.hidden = NO;
    cell.buyView.buyCountLabel.textColor = [UIColor blackColor];
    cell.buyView.buyCountLabel.text = [NSString stringWithFormat:@"%@",model.buyNum];
    cell.buyView.shouldByNum = [model.shouldBuyCount intValue];
    cell.buyView.model = model;
//    NSLog(@"id = %@",model.idStr);
    
    
    return cell;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
