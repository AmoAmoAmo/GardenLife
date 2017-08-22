//
//  MyHomeCell.m
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "MyHomeCell.h"
#import "HomeModel.h"
#import "LikeView.h"
#import "FMDBmanager.h"

@interface MyHomeCell()

@property (nonatomic,strong) LikeView *likeView;

@end

@implementation MyHomeCell

- (void)awakeFromNib {
    // Initialization code
    self.iconImgView.clipsToBounds = YES;
    self.iconImgView.layer.cornerRadius = self.iconImgView.frame.size.width*0.5;
    
    self.iconImgView.layer.borderWidth = .8f;
    self.iconImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
// ***** likeBtn ****
    _likeView = [LikeView createLikeViewWithIsLike:0 andNum:0];
    _likeView.frame = CGRectMake(CGRectGetMaxX(self.liulangLabel.frame)+10, CGRectGetMinY(self.liulangLabel.frame), 120, 20);
//    [_likeView.likeBtn addTarget:self action:@selector(clickLikeBtn) forControlEvents:UIControlEventTouchUpInside];
    _likeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLikeBtn)];
    [_likeView addGestureRecognizer:tap];
    [self addSubview:_likeView];
}


+(instancetype)cellWithTable:(UITableView *)table andModel:(HomeModel *)homeModel andDataDic:(NSDictionary *)dic
{
    static NSString *idStr = @"homeCell";
    
    MyHomeCell *cell = [table dequeueReusableCellWithIdentifier:idStr];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = homeModel;
    
    if (!dic) {// dic == nil
        cell.likeView.model = homeModel;
//        NSLog(@"homeModel.idStr---------%@",homeModel.idStr);
    }else{
        cell.likeView.dataDic = dic;
    }
    
    // **** 从数据库读取 设置likeBtn的选中状态 ****
    FMDBmanager *manager = [FMDBmanager shareInstance];
    NSString *sqlStr = [NSString stringWithFormat:@"select * from Like where idStr = '%@'",homeModel.idStr];
//    NSLog(@"sqlStr ==== %@",sqlStr);
    FMResultSet *rs = [manager.dataBase executeQuery:sqlStr];
    while ([rs next]) {
        cell.likeView.likeBtn.selected = YES;
        cell.likeView.numLabel.text = [NSString stringWithFormat:@"%ld",[[rs stringForColumn:@"likeNum"] integerValue]];
    }
    
    return cell;
}


-(void)setModel:(HomeModel *)model
{
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrlStr] placeholderImage:PLACEIMAGE];
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.iconImgStr] placeholderImage:PLACEIMAGE];
    
    self.nameLabel.text = model.nameStr;
    self.rzLabel.text = model.rzStr;
    self.catgoryLabel.text = model.categoryStr;
    self.titleLabel.text = model.titleStr;
    self.desLabel.text = model.desStr;
    
    self.liulangLabel.text = model.liulangStr;
    self.huifuLabel.text = model.huifuStr;
//    _likeView.likeBtn.selected =
    _likeView.numLabel.text = [NSString stringWithFormat:@"%@",model.collectedNum];
    
}


#pragma mark - 点击like按钮
-(void)clickLikeBtn
{
    if (_likeView.likeBtn.selected) { // 点击前是selected状态
        [_likeView canselLike];
    }else{              // 点击前是未选中状态
        [_likeView isLike];
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
