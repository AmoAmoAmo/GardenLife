//
//  JingCell.m
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "JingCell.h"
#import "BuyView.h"
#import "FMDBmanager.h"


@interface JingCell()<BuyViewDelegate>

/** 库存数量 */
@property (nonatomic,assign) NSInteger shouldByNum;

/** +、-按钮和label的view */
@property (nonatomic,strong) BuyView *buyView;
/** 记录上一次购物车的数量 */
@property (nonatomic,assign) NSInteger lastBuyNum;

@end


@implementation JingCell

- (void)awakeFromNib {
    // Initialization code
    
    self.tagView.clipsToBounds = YES;
    self.tagView.layer.cornerRadius = self.tagView.frame.size.height*0.5;
}



+(instancetype)cellWithTable:(UITableView *)table andDataDic:(NSDictionary *)dic
{
    static NSString *idStr = @"homeCell";
    
    JingCell *cell = [table dequeueReusableCellWithIdentifier:idStr];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"fnAttachment"]] placeholderImage:PLACEIMAGE];
    
    cell.engLabel.text = dic[@"fnEnName"];
    cell.titleLabel.text = dic[@"fnName"];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@",dic[@"fnMarketPrice"]];
    
    NSInteger index = [dic[@"fnJian"] intValue];
//    NSLog(@"%ld",index);
    switch (index) {
        case 1:
        {
            cell.tagLabel.text = @"推荐";
            cell.tagView.backgroundColor = [UIColor colorWithRed:209/255.0 green:66/255.0 blue:76/255.0 alpha:1];
        }
            break;
        case 2:
        {
            cell.tagLabel.text = @"最热";
            cell.tagView.backgroundColor = [UIColor colorWithRed:212/255.0 green:185/255.0 blue:72/255.0 alpha:1];
        }
            break;
        case 3:
        {
            cell.tagLabel.text = @"预售";
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
    
    
    //    --> 防止复用出现问题
    [cell.buyView removeFromSuperview];
    
    
    // 库存
    cell.shouldByNum = [dic[@"fnSaleNum"] integerValue];
//    cell.shouldByNum = 5;  // *** 暂时 ***
    cell.buyView = [BuyView createWithShouldBuyNum:[dic[@"fnSaleNum"] integerValue] andFrame:CGRectMake(cell.frame.size.width-80-20, cell.frame.size.height-30-10, 80, 25)];
    cell.buyView.delegate = cell;
    [cell addSubview:cell.buyView];
    cell.buyView.dataDic = dic;
    
    
    // 从数据库读取数据
    FMDBmanager *manager = [FMDBmanager shareInstance];
//    NSString *idStr = [NSString stringWithFormat:@"%@",dic[@"fnId"]];
    NSString *sqlStr = [NSString stringWithFormat:@"select * from Car where idStr = '%@'",dic[@"fnId"]];
//    NSLog(@"sqlString === %@",sqlStr);
    FMResultSet *rs = [manager.dataBase executeQuery:sqlStr];
    
    
    if ([rs next]) {// 如果数据库存在该数据   此处select结果只有一条
        
        cell.lastBuyNum = [[rs stringForColumn:@"buyNum"] intValue];
        //        NSLog(@"lastBuyNum ******%ld",cell.lastBuyNum);
        cell.buyView.buyCountLabel.text = [NSString stringWithFormat:@"%ld",cell.lastBuyNum];
//        NSLog(@"lastBuyNum ===== %ld",cell.lastBuyNum);
    }else           // 如果数据库不存在该数据
    {
        
        if ([dic[@"fnSaleNum"] integerValue]) { // 有库存
            cell.buyView.buyCountLabel.text = @"0";
        }else                           // 已售罄
        {
            cell.buyView.addBtn.hidden = YES;
            cell.buyView.reduceBtn.hidden = YES;
            cell.buyView.buyCountLabel.text = @"已售罄";
            cell.buyView.buyCountLabel.textColor = [UIColor redColor];
        }
    }

    
    
    return cell;
}



#pragma mark - BuyViewDelegate -> 点击 '+' 回调
-(void)buyViewDidCilckAddBtn  // buyView -> cell -> HomeVC
{
    //    block ***
    
    NSInteger buyCount = [self.buyView.buyCountLabel.text intValue];/** 该商品已加入购物车的数量 */
    //    更新 ******
//        NSLog(@"buyCount == %ld, self.shouldByNum ====== %ld",buyCount,self.shouldByNum);
    
    
    if (buyCount == self.shouldByNum && buyCount == self.lastBuyNum) {
        // 加入购物车数量已达到上限，不再走回调  -- > 即不再做动画
        self.lastBuyNum = 0;
    }else{
        self.clickAddBlock(self.imgView);// 回调
    }
    self.lastBuyNum = buyCount;
}


-(void)clickAddBtnandReturnImgView:(ClickAddWithImgViewBlock)block
{
    self.clickAddBlock = block;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
