//
//  ShopCarViewController.m
//  Demo－1
//
//  Created by Jane on 16/3/12.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ShopCarViewController.h"
#import "JGProgressHUD+MyHUD.h"
#import "FMDBmanager.h"
#import "GoodsHomeModel.h"
#import "BuyView.h"
#import "TipView.h"
#import "CarCell.h"
#import "PayOrderViewController.h"
#import "PayHeadView.h"
#import "MyAddressViewController.h"

@interface ShopCarViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) JGProgressHUD *hud;

@property (nonatomic,strong) FMDBmanager *manager;

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray *dataArr;
/** 购物车为空时的背景提示 */
@property (nonatomic, strong) UIView *emptyView;

@property (nonatomic, strong) UILabel *allCountLabel;
@property (nonatomic, assign) CGFloat allCount;

@property (nonatomic, assign) NSInteger loadCount;

@end

@implementation ShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购物车";

    [self setUI];
    [self getDataFromDB];
    [self addNotification];
    
    
    self.loadCount++;
    if (self.loadCount==1) {
        // 第一次加载，发送默认的地址
//        NSLog(@"***** %ld", self.loadCount);
        [self sendFirstDataDicToShopCar];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)setUI
{
    [self setTableView];
    [self setBottomView];
}

-(void)sendFirstDataDicToShopCar
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MyAddressData" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:plistPath];
    
    //    NSLog(@"***** arr = %@", arr[0]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"get_receiver_massage" object:self userInfo:arr[0]];// 默认选中第一个
}


-(void)setBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49-40, SCREENWIDTH, 40)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.6;
    [bottomView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, bottomView.frame.size.height-1, SCREENWIDTH, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    lineView1.alpha = 0.6;
    [bottomView addSubview:lineView1];
    
    
    // ****
    _allCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 140, bottomView.frame.size.height)];
    _allCountLabel.text = [NSString stringWithFormat:@"合计：￥0"];
    _allCountLabel.textAlignment = NSTextAlignmentCenter;
    _allCountLabel.textColor = [UIColor redColor];
    _allCountLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:_allCountLabel];
    
    
    
    
    
    // ****
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBtn.frame = CGRectMake(SCREENWIDTH-80, 0, 80, CGRectGetHeight(bottomView.frame));
    [goBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    goBtn.backgroundColor = [UIColor darkGrayColor];
    [goBtn addTarget:self action:@selector(goPayVC) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:goBtn];
    
    
    
    [self.view addSubview:bottomView];
}

-(void)getDataFromDB
{
    // 清空数据源
    [self.dataArr removeAllObjects];
    
    // 1. loadDataFromDB
    NSString *selectString = [NSString stringWithFormat:@"select * from Car"];
    FMResultSet *rs = [self.manager.dataBase executeQuery:selectString];
    
    
    NSInteger num = 0;
    _allCount = 0;// 合计
    while ([rs next])
    {
        num++;
        GoodsHomeModel *model = [[GoodsHomeModel alloc] init];
        model.nameStr = [rs stringForColumn:@"name"];
        model.priceStr = [rs stringForColumn:@"price"];
        model.shouldBuyCount = [rs stringForColumn:@"shouldBuyCount"];
        model.buyNum = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"buyNum"]];
        model.idStr = [rs stringForColumn:@"idStr"];
        
        [self.dataArr addObject:model];
        
        
        // 合计
        _allCount += [model.priceStr floatValue] * [model.buyNum floatValue];
    }
    _allCountLabel.text = [NSString stringWithFormat:@"合计：￥%.2f",_allCount];// 更新合计label
    if (num == 0) { // 空 发送购物车为空提醒?
        [self showEmptyCarImgView];
    }else
        [self.emptyView removeFromSuperview];
    
//    [self showHUD];
    [self.table reloadData];
  
}

-(void)showHUD
{
    self.hud = [JGProgressHUD showMessage:@"正在加载商品信息" inViewController:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.hud hides];
    });
}

-(void)showEmptyCarImgView
{
    [self.view addSubview:self.emptyView];
}


#pragma mark - Notification
-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotice) name:@"no_more_product" object:nil];  /** 库存不足时的提醒view */
    
    
    /** 购物车数据变化时提醒 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDataFromDB) name:@"buyNum_isChanged" object:nil];
    
    
    /** 收到 收货人信息  --- "管理收货地址 点击 cell后 返回的通知" --- */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buildHeadWithReceiverMassage:) name:@"get_receiver_massage" object:nil];
}



-(void)showNotice
{
    //        NSLog(@"该商品库存不足啦~请选购其他商品吧");
    [self.view addSubview:[TipView showTheTipView]];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - 前往支付页面
-(void)goPayVC
{
    PayOrderViewController *vc = [[PayOrderViewController alloc] init];
    // 点击时 将data传过去
    vc.dataGoodsArr = self.dataArr;
    // 点击时 将allCount传过去
    vc.allCountStr = [NSString stringWithFormat:@"%.2f",_allCount];
    
    [self.navigationController pushViewController:vc animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}




-(void)setTableView
{
    [self.view addSubview:self.table];
    
//    // head...
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
//    headView.backgroundColor = [UIColor whiteColor];
//    self.table.tableHeaderView = headView;
    
}



#pragma mark - 地址View
-(void)buildHeadWithReceiverMassage:(NSNotification*)noti
{
    NSDictionary *dataDic = noti.userInfo;
//    NSLog(@"dic==== %@",dataDic);
    self.table.tableHeaderView = [PayHeadView createPayHeadViewWithDataDic:dataDic];
    
    self.table.tableHeaderView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAddrView)];
    [self.table.tableHeaderView addGestureRecognizer:tap];
}

    
#pragma mark - UITableViewDataSource
// 返回段头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
// 返回段头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (40-25)*0.5, 25, 25)];
    [imgView setImage:[UIImage imageNamed:@"store_2"]];
    [backView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+20, (40-20)*0.5, 100, 20)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"花田官方超市";
    [backView addSubview:label];
    
    return backView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsHomeModel *model = self.dataArr[indexPath.row];

    CarCell *cell = [CarCell cellWithTableView:tableView andCellModel:model];
 
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.tabBarController.tabBar.hidden = NO;
}




#pragma mark - 点击table的Head
-(void)clickAddrView
{
    MyAddressViewController *vc = [[MyAddressViewController alloc] init];
    vc.flagStr = @"car";
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - setter and getter
//懒加载
-(UITableView *)table
{
    if (_table == nil)
    {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];//style:UITableViewStylePlain(默认 设置分组有悬浮)
        //        _table.separatorStyle = UITableViewCellSeparatorStyleNone;//把table的线去掉
        _table.backgroundColor = AUTOCOLOR;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;

}


-(FMDBmanager *)manager
{
    if (!_manager) {
        
        _manager = [FMDBmanager shareInstance];
    }
    return _manager;
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UIView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:self.view.frame];
        _emptyView.backgroundColor = [UIColor whiteColor];
        
        CGFloat margin = 30;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 50, SCREENWIDTH-margin*2, (SCREENWIDTH-margin*2)*1.26)];
        [imgView setImage:[UIImage imageNamed:@"111111111"]];
        [_emptyView addSubview:imgView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame), SCREENWIDTH, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"购物车空空如也，去逛逛吧~";
        [_emptyView addSubview:label];
    }
    return _emptyView;
}

@end
