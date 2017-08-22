//
//  OrderDetailViewController.m
//  LoveFresh
//
//  Created by Jane on 16/4/21.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderHeadView.h"
#import "PJView.h"
#import "OrderCountView.h"
#import "OrderDetailCell.h"

@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *table;
/** 订单删除 弹出提示框 */   // 要改成 iOS 8.3 的
@property (nonatomic,strong) UIAlertView *alertView;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
//    NSLog(@"create_time===%@",self.dataDic[@"create_time"]);
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.toolbarHidden = YES;
}

-(void)setUI
{
    self.title = @"订单详情";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"反馈" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.view.backgroundColor = AUTOCOLOR;
    
    [self.view addSubview:self.table];
    //    //cell注册方式
    //    [self.table registerNib:[UINib nibWithNibName:@"FirstCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    // head...
    self.table.tableHeaderView = [OrderHeadView createHeadViewWithData:self.dataDic];
    
    // foot...
    self.table.tableFooterView = [PJView createFootViewWithData:self.dataDic];
    
    
    // **** toolBar ****
    self.navigationController.toolbarHidden = NO;    //唤起我们的工具栏
    
//    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    lineV.alpha = 0.6;
//    [toolBar addSubview:lineV];
    [self.navigationController.toolbar addSubview:lineV];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREENWIDTH-80 - 10, 2, 80, 40);
    btn.backgroundColor = THEMECORLOR;
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"删除订单" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(deleteOrder) forControlEvents:UIControlEventTouchUpInside];
//    [toolBar addSubview:btn];
    [self.navigationController.toolbar addSubview:btn];

}

#pragma mark - 删除订单
-(void)deleteOrder
{
    // alertView
    self.alertView = [[UIAlertView alloc] initWithTitle:@"删除订单" message:[NSString stringWithFormat:@"确定要删除该订单吗?"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [self.alertView show];
}
#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex)    // buttonIndex == 1 点击了确定,
    {
        
    }
    self.alertView = nil;
}



#pragma mark - UITableViewDataSource
// 返回段头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
// 返回段头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH-20, 50)];
    label.text = @"费用明细";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    [backView addSubview:label];
    
    return backView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 135;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [OrderCountView createOrderCountViewWithData:self.dataDic];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.dataDic[@"order_goods"];
    return arr.count;
}

//返回每个cell的高度，这里高度是固定的，可以直接写死, 如果高度是不固定的需要先调用estimatedHeightForRowAtIndexPath:方法给个预计高度
//等网络请求完毕后根据cell内容算出高度 再调用heightForRowAtIndexPath：设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = self.dataDic[@"order_goods"];
    NSArray *tempArr = arr[indexPath.row];
    NSDictionary *dic = tempArr[0];
    
    return [OrderDetailCell createCellWithTabel:tableView andData:dic];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
//        _table.backgroundColor = AUTOCOLOR;
    }
    return _table;

}
@end
