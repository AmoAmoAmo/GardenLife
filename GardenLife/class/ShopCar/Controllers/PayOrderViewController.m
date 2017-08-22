//
//  PayOrderViewController.m
//  LoveFresh
//
//  Created by Jane on 16/5/1.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "PayOrderViewController.h"
#import "GoodsHomeModel.h"
#import "PayWayCell.h"
#import "GoodsListCell.h"
#import "OrderCountView.h"


@interface PayOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;

@end

@implementation PayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"订单确认";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    [self setTableView];
    [self setBottomView];
}

#pragma mark - methord


-(void)setTableView
{
    [self.view addSubview:self.table];

    
//    // head...
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    headView.backgroundColor = [UIColor blackColor];
//    self.table.tableHeaderView = headView;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)setBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-40, SCREENWIDTH, 40)];
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
//    _allCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 140, bottomView.frame.size.height)];
//    _allCountLabel.text = [NSString stringWithFormat:@"合计：￥0"];
//    _allCountLabel.textAlignment = NSTextAlignmentCenter;
//    _allCountLabel.textColor = [UIColor redColor];
//    _allCountLabel.font = [UIFont systemFontOfSize:14];
//    [bottomView addSubview:_allCountLabel];
    
    
    
    
    
    // ****
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBtn.frame = CGRectMake(SCREENWIDTH-80, 0, 80, CGRectGetHeight(bottomView.frame));
    [goBtn setTitle:@"确认付款" forState:UIControlStateNormal];
    [goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    goBtn.backgroundColor = [UIColor orangeColor];
//    [goBtn addTarget:self action:@selector(goPayVC) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:goBtn];
    
    
    
    [self.view addSubview:bottomView];
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
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 40)];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [backView addSubview:titleLabel];
    
    if (section == 0) {
        titleLabel.text = @"选择支付方式";
    }else if(section == 1){
        titleLabel.text = @"商品清单";
    }else{
        titleLabel.text = @"费用明细";
    }
    
    return backView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else if(section == 1){
        return self.dataGoodsArr.count ;
    }else{
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    }else if(indexPath.section == 1){
        return 40;
    }else{
        return 135;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return [PayWayCell createPayWayCellWithTable:tableView andRow:indexPath.row];
    }else if(indexPath.section == 1){
        GoodsHomeModel *model = self.dataGoodsArr[indexPath.row];
        return [GoodsListCell cellWithTableView:tableView andCellModel:model];
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//去掉cell选中效果
        
        // ** dic ***
        NSDictionary *dic = @{@"taxes":@"0",
                              @"service_fee":@"0",
                              @"promotions":@"0",
                              @"real_amount":self.allCountStr};
        [cell addSubview:[OrderCountView createOrderCountViewWithData:dic]];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (section == 0) {
//        
//    }else if(section == 1){
//        
//    }else{
//        
//    }
}




#pragma mark - setter and getter
//懒加载
-(UITableView *)table
{
    if (_table == nil)
    {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];//style:UITableViewStylePlain(默认 设置分组有悬浮)
        //        _table.separatorStyle = UITableViewCellSeparatorStyleNone;//把table的线去掉
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

@end
