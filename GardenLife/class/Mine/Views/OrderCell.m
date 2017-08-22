//
//  OrderCell.m
//  LoveFresh
//
//  Created by Jane on 16/4/21.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "OrderCell.h"
#import "OrdersModel.h"

@implementation OrderCell

- (void)awakeFromNib {
    // Initialization code
    
    self.detailLabel.clipsToBounds = YES;
    self.detailLabel.layer.cornerRadius = 5;
    self.detailLabel.layer.borderWidth = 1;
    self.detailLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.deleteLabel.clipsToBounds = YES;
    self.deleteLabel.layer.cornerRadius = 5;
    self.deleteLabel.layer.borderWidth = 1;
    self.deleteLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}


+(instancetype)cellWithTableView:(UITableView *)tableView andCellModel:(OrdersModel *)model
{
    static NSString *idString = @"textCell";
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    }
    
    cell.orderModel = model;
    return cell;
}

-(void)setOrderModel:(OrdersModel *)orderModel
{
    _orderModel = orderModel;
    self.countLabel.text = [NSString stringWithFormat:@"共%@件商品",orderModel.buy_num_Str];
    self.allPriceLabel.text =[NSString stringWithFormat:@"共计：￥%@",orderModel.real_amount_Str];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",orderModel.create_time_Str];
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:orderModel.imgs_Arr[0]]];
    CGFloat lastX = CGRectGetMaxX(self.imgView.frame)+5;
    CGFloat margin = 5;
    CGFloat Y = CGRectGetMinY(self.imgView.frame);
    CGFloat width = self.imgView.frame.size.width;
//    NSLog(@"arr.count+++++%ld",orderModel.imgs_Arr.count);
    for (int i = 1; i < orderModel.imgs_Arr.count; i++)// 4
    {
        if (i == 4) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(lastX + (i-1)*(margin+width), Y, 20, 20)];
            [imgView setImage:[UIImage imageNamed:orderModel.imgs_Arr[i]]];
            break;
        }
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(lastX + (i-1)*(margin+width), Y, width, width)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:orderModel.imgs_Arr[i]]];
        [self addSubview:imgView];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
