//
//  SelectedViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/8.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "SelectedViewController.h"
#import "HomeModel.h"
#import "MyHomeCell.h"
#import "DetailViewController.h"
#import "AuthorViewController.h"

@interface SelectedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNotification];
    
    [self setUI];
}

-(void)setUI
{
    self.title = self.nameStr;
    [self.view addSubview:self.table];
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 311;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyHomeCell *cell = [MyHomeCell cellWithTable:tableView andModel:[HomeModel buildModelWithDataDic:self.dataArr[indexPath.row]] andDataDic:self.dataArr[indexPath.row]];
    
    cell.iconImgView.userInteractionEnabled = YES;
    cell.iconImgView.tag = 100+indexPath.row;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAuthorView:)];
    [cell.iconImgView addGestureRecognizer:tap];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel *model = [HomeModel buildModelWithDataDic:self.dataArr[indexPath.row]];
    
    DetailViewController *vc= [[DetailViewController alloc] init];
    vc.flagStr = @"topic";
    vc.idStr = model.idStr;
    vc.titleStr = model.titleStr;
    vc.dataDic = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - Notification
-(void)addNotification
{
    /** NSNotificationCenter */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LikeTableDidChanged) name:@"LikeTableDidChanged" object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)LikeTableDidChanged
{
    [self.table reloadData];
}




#pragma mark - 点击userView
-(void)clickAuthorView:(UITapGestureRecognizer*)tap
{
    NSInteger index = tap.view.tag-100;
    AuthorViewController *vc = [[AuthorViewController alloc] init];
    NSDictionary *dic = self.dataArr[index];
    vc.dataDic = dic[@"author"];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - setter and getter
//懒加载
-(UITableView *)table
{
    if (_table == nil)
    {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];//style:UITableViewStylePlain(默认 设置分组有悬浮)
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
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeAll" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *arr = dic[@"result"];
        
        for (NSDictionary *tempDic in arr) {
            NSString *nameStr = tempDic[@"category"][@"name"];
            if ([nameStr isEqualToString:self.nameStr]) {
                [_dataArr addObject:tempDic];
            }
        }
    }
    return _dataArr;
}

@end
