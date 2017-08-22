//
//  MyOrderViewController.m
//  LoveFresh
//
//  Created by Jane on 16/4/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrdersModel.h"
#import "OrderCell.h"
#import "OrderDetailViewController.h"

@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;

@property (nonatomic, strong) NSMutableArray *dataArr;
/** 每个单的dic */
@property (nonatomic, strong) NSMutableArray *dataBigArr;
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];    
    
}

-(void)setUI
{
    self.title = @"我的订单";
    
    self.view.backgroundColor = AUTOCOLOR;
    
    [self.view addSubview:self.table];
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
//返回每个cell的高度，这里高度是固定的，可以直接写死, 如果高度是不固定的需要先调用estimatedHeightForRowAtIndexPath:方法给个预计高度
//等网络请求完毕后根据cell内容算出高度 再调用heightForRowAtIndexPath：设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 213;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrdersModel *model = self.dataArr[indexPath.section];
    return [OrderCell cellWithTableView:tableView andCellModel:model];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
    vc.dataDic = _dataBigArr[indexPath.section];
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
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        _dataBigArr = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MyOrders" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *arr = Dic[@"data"];
//        _dataBigArr = [NSMutableArray arrayWithArray:Dic[@"data"]];
//        NSLog(@"arr.count===%ld",arr.count);
        for (NSDictionary *dic in arr) {
            
            OrdersModel *model = [[OrdersModel alloc] init];
            model.create_time_Str = dic[@"create_time"];
            model.pay_status_Str = dic[@"pay_status"];
            model.real_amount_Str = dic[@"real_amount"];
            model.buy_num_Str = dic[@"buy_num"];
            model.order_goods_Arr = dic[@"order_goods"];

            [_dataArr addObject:model];
            [_dataBigArr addObject:dic];
        }
//        NSLog(@"_dataBigArr.count===%ld",_dataBigArr.count);
    }
    return _dataArr;
}
@end
