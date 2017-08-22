//
//  BuyView.m
//  LoveFresh
//
//  Created by Jane on 16/4/29.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "BuyView.h"
#import "RedView.h"
#import "FMDBmanager.h"

@interface BuyView()


@property (nonatomic,strong) FMDBmanager *manager;

@end





@implementation BuyView


+(instancetype)createWithShouldBuyNum:(NSInteger)num andFrame:(CGRect)frame
{
    BuyView *view = [[BuyView alloc] initWithFrame:frame];
    
    view.shouldByNum = num;
//    NSLog(@"库存数量 == %ld",view.shouldByNum);
    
    [view addSubview:view.buyCountLabel];
    
    [view addSubview:view.addBtn];
    
    [view addSubview:view.reduceBtn];
    

//    NSLog(@"buyview 库存 %ld",view.shouldByNum);
    
    if (view.shouldByNum == 0) {// 如果 已售罄
        
        view.addBtn.hidden = YES;
        view.reduceBtn.hidden = YES;
        view.buyCountLabel.text = @"已售罄";
        view.buyCountLabel.textColor = [UIColor redColor];
    }
    
    return view;
}


/** goods */
+(instancetype)createWithGoodsDataDic:(NSDictionary *)dic andFrame:(CGRect)frame
{
    BuyView *view = [[BuyView alloc] initWithFrame:frame];
    view.dataDictionary = dic;
    
    [view addSubview:view.buyCountLabel];
    
    [view addSubview:view.addBtn];
    
    [view addSubview:view.reduceBtn];
    
//    [view loadDataFromDB];
    
   
    return view;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
   
        self.userInteractionEnabled = YES;

    }
    return self;
}



/** 从数据库更新 */
-(void)loadDataFromDB
{
    NSString *idStr = self.dataDictionary[@"fnId"];
    
    NSString *sqlStr = [NSString stringWithFormat:@"select shouldBuyCount from Car where idStr = '%@'",idStr];
    FMResultSet *rs = [self.manager.dataBase executeQuery:sqlStr];
    while ([rs next]) {
        self.shouldByNum = [[rs stringForColumn:@"shouldBuyCount"] integerValue];
        NSLog(@"self.shouldByNum == %ld",self.shouldByNum);
    }
    
    if (self.shouldByNum == 0) {// 如果 已售罄
        
        self.addBtn.hidden = YES;
        self.reduceBtn.hidden = YES;
        self.buyCountLabel.text = @"已售罄";
        self.buyCountLabel.textColor = [UIColor redColor];
    }
    
}




#pragma mark - 点击+、-   数据库
-(void)addGoodsButtonClick
{
    // *** delegate **** //(有库存才走代理，库存不足则不走)
    if ([_delegate respondsToSelector:@selector(buyViewDidCilckAddBtn)]) {
        
        [_delegate buyViewDidCilckAddBtn];
    }
    
    
    
    NSInteger addNum = [self.buyCountLabel.text intValue];
//    NSLog(@"addNum == %ld,   self.shouldByNum == %ld",addNum,self.shouldByNum);
    
    // 库存
    
    
    
    
    if (addNum < self.shouldByNum)
    {
        
        addNum++;
        

        self.buyCountLabel.text = [NSString stringWithFormat:@"%ld",addNum];
        [[RedView shareRedView] addProductToRedDotView];
        
        if (addNum == 1) {
            // ***** 加入购物车数据库 *****
            NSString *sqlString = nil;
            if (self.dataDic) {
                sqlString = [NSString stringWithFormat:@"insert into Car (idStr,name,price, shouldBuyCount ,buyNum ) values('%@','%@','%@','%@',%ld)",self.dataDic[@"fnId"],self.dataDic[@"fnName"],self.dataDic[@"fnMarketPrice"],self.dataDic[@"fnSaleNum"],addNum];
            }else{
                sqlString = [NSString stringWithFormat:@"insert into Car (idStr,name,price, shouldBuyCount ,buyNum ) values('%@','%@','%@','%@',%ld)",self.model.idStr,self.model.nameStr,self.model.priceStr,self.model.shouldBuyCount,addNum];
            }
            if (![self.manager.dataBase executeUpdate:sqlString]) {
                NSLog(@"insert 失败");
            }
//            // ****** 发送购物车数据不再为空的信息 *****
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"shoppingCar_is_not_empty" object:self];
        }else{
            // 更新数据库
            NSString *sqlString = nil;
            if (self.dataDic) {
                sqlString = [NSString stringWithFormat:@"update Car set buyNum = %ld where idStr = '%@'",addNum,self.dataDic[@"fnId"]];
//                NSLog(@"sqlString === %@",sqlString);
            }else{
                sqlString = [NSString stringWithFormat:@"update Car set buyNum = %ld where idStr = '%@'",addNum,self.model.idStr];
//                NSLog(@"idStr==%@",self.model.idStr);
            }
            if (![self.manager.dataBase executeUpdate:sqlString]) {
                NSLog(@"add update 失败");
            }
        }
      
        /** 发送buyNum */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buyNum_isChanged" object:self userInfo:@{@"buyNum":@(addNum)}];
        
        
        
        
        
    }else   // 库存不足
    {
        // **** 提示 ***
        [[NSNotificationCenter defaultCenter] postNotificationName:@"no_more_product" object:self];
    }
}

-(void)reduceGoodsButtonClick
{
    NSInteger reduceNum = [self.buyCountLabel.text intValue];

    if (reduceNum > 0) {

        reduceNum--;
        

        self.buyCountLabel.text = [NSString stringWithFormat:@"%ld",reduceNum];
        [[RedView shareRedView] reduceProductToRedDotView];
        
        
        
        if (reduceNum == 0) {
            // ***** 从购物车数据库删除 *****
            NSString *sqlString = nil;
            if (self.dataDic) {
                sqlString = [NSString stringWithFormat:@"delete from Car where idStr = '%@'",self.dataDic[@"fnId"]];
            }else{
                sqlString = [NSString stringWithFormat:@"delete from Car where idStr = '%@'",self.model.idStr];
            }
            if (![self.manager.dataBase executeUpdate:sqlString]) {
                NSLog(@"reduce 删除 失败,    %@",sqlString);
            }
        }else{
            // ***** 更新购物车数据库 *****
            NSString *sqlString = nil;
            if (self.dataDic) {
                sqlString = [NSString stringWithFormat:@"update Car set buyNum = %ld where idStr = '%@'",reduceNum,self.dataDic[@"fnId"]];
            }else{
                sqlString = [NSString stringWithFormat:@"update Car set buyNum = %ld where idStr = '%@'",reduceNum,self.model.idStr];
            }
            
            if (![self.manager.dataBase executeUpdate:sqlString]) {
                NSLog(@"reduce- update 失败,    %@",sqlString);
            }
        }
        
        /** 发送buyNum */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buyNum_isChanged" object:self userInfo:@{@"buyNum":@(reduceNum)}];
        
    }
}








#pragma mark - getter

-(UILabel *)buyCountLabel
{
    if (!_buyCountLabel) {
        
        _buyCountLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _buyCountLabel.textAlignment = NSTextAlignmentCenter;
        _buyCountLabel.text = @"0";
        _buyCountLabel.textColor = [UIColor blackColor];
        _buyCountLabel.font = [UIFont systemFontOfSize:14];
    }
    return _buyCountLabel;
}

-(UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(80-25, 0, 25, 25);
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addGoodsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(UIButton *)reduceBtn
{
    if (!_reduceBtn) {
        _reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reduceBtn.frame = CGRectMake(0, 0, 25, 25);
        [_reduceBtn setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
        [_reduceBtn addTarget:self action:@selector(reduceGoodsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reduceBtn;
}

-(FMDBmanager *)manager
{
    if (!_manager) {
        _manager = [FMDBmanager shareInstance];
    }
    return _manager;
}

#pragma mark - setter
-(void)setDataDictionary:(NSDictionary *)dataDictionary
{
    _dataDictionary = dataDictionary;
}

@end
