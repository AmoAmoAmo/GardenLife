//
//  MineCell.m
//  GardenLife
//
//  Created by Jane on 16/5/5.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "MineCell.h"

@interface MineCell()

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation MineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//cell右侧提示图标
        self.selectionStyle = UITableViewCellSelectionStyleNone;//去掉cell选中效果
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10+3, 24, 24)];
        [self addSubview:self.imgView];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 30)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView andDataDic:(NSDictionary *)dic
{
    static NSString *CellIdentifier = @"cell";
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    [cell.imgView setImage:[UIImage imageNamed:dic[@"iconName"]]];
    [cell.titleLabel setText:dic[@"title"]];
    
    return cell;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
