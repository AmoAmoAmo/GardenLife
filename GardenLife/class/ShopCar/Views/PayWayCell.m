//
//  PayWayCell.m
//  LoveFresh
//
//  Created by Jane on 16/5/1.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "PayWayCell.h"

@interface PayWayCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImgView;

@property (nonatomic, strong) NSArray *iconArr;
@property (nonatomic, strong) NSArray *nameArr;

@end

@implementation PayWayCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+(instancetype)createPayWayCellWithTable:(UITableView *)tableView andRow:(NSInteger)row
{
    static NSString *idString = @"picCell";
    
    PayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    }
    
    [cell.iconImgView setImage:[UIImage imageNamed:cell.iconArr[row]]];
    cell.nameLabel.text = cell.nameArr[row];

    return cell;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectImgView.highlighted = selected;
}



-(NSArray *)iconArr
{
    if (!_iconArr) {
        _iconArr = @[@"v2_weixin",@"icon_qq",@"zhifubaoA",@"v2_dao"];
    }
    return _iconArr;
}

-(NSArray *)nameArr
{
    if (!_nameArr) {
        _nameArr = @[@"微信支付",@"QQ钱包",@"支付宝支付",@"货到付款"];
    }
    return _nameArr;
}

@end
