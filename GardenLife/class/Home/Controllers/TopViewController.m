//
//  TopViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "TopViewController.h"
#import "FMDBmanager.h"
#import "Top1Cell.h"
#import "Top2Cell.h"
#import "HomeModel.h"
#import "DetailViewController.h"

@interface TopViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) JGProgressHUD *hud;

@property (nonatomic,strong) FMDBmanager *manager;

@property (nonatomic,strong)UIScrollView *bgScroll;

@property (nonatomic,strong)UISegmentedControl *segment;

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"本周排行TOP10";

    [self buildBGView];
    [self buildTopView];
}

-(void)buildBGView
{
    [self.view addSubview:self.bgScroll];
    [self buildTableView];
}

-(void)buildTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    
    [topView addSubview:self.segment];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREENWIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:lineView];
    
    [self.view addSubview:topView];
}

-(void)buildTableView
{
    [self.bgScroll addSubview:self.table];
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0 && indexPath.row < 3) {// 0,1,2
        
        return [Top1Cell cellWithTable:tableView andModel:[HomeModel buildTOP10ModelWithDataDic:self.dataArr[indexPath.row]] andIndexPath:indexPath];
    }else
    {
        return [Top2Cell cellWithTable:tableView andModel:[HomeModel buildTOP10ModelWithDataDic:self.dataArr[indexPath.row]] andIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel *model = [HomeModel buildTOP10ModelWithDataDic:self.dataArr[indexPath.row]];
    
    DetailViewController *vc= [[DetailViewController alloc] init];
    vc.flagStr = @"top";
    vc.idStr = model.idStr;
    vc.titleStr = model.titleStr;
    
    vc.dataDic = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}








-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView != self.table) {
        NSInteger index = scrollView.contentOffset.x / SCREENWIDTH;
        self.segment.selectedSegmentIndex = index;
    }
}

-(void)clickSegment:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    
    self.bgScroll.contentOffset = CGPointMake(index*SCREENWIDTH, 0);
}













#pragma mark - setter and getter
-(UIScrollView *)bgScroll
{
    if (!_bgScroll) {
        _bgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40+64, SCREENWIDTH, SCREENHEIGHT-40-64)];
        _bgScroll.alwaysBounceHorizontal = YES;
        _bgScroll.pagingEnabled = YES;
        _bgScroll.showsHorizontalScrollIndicator = NO;
        _bgScroll.contentSize = CGSizeMake(SCREENWIDTH*2, SCREENHEIGHT-40-64);
        _bgScroll.bounces = NO;
        _bgScroll.delegate = self;
    }
    return _bgScroll;
}

-(UISegmentedControl *)segment
{
    if (!_segment) {
        NSArray * items = @[@"专栏",@"作者"] ;
        _segment = [[UISegmentedControl alloc] initWithItems:items];
        _segment.frame = CGRectMake((SCREENWIDTH-170)*0.5, 4, 170, 32);
        _segment.tintColor = [UIColor lightGrayColor];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        [_segment setTitleTextAttributes:dic forState:UIControlStateNormal];
        
        _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

//懒加载
-(UITableView *)table
{
    if (_table == nil)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-40-64) style:UITableViewStylePlain];//style:UITableViewStylePlain(默认 设置分组有悬浮)
                _table.separatorStyle = UITableViewCellSeparatorStyleNone;//把table的线去掉
        _table.delegate = self;
        _table.dataSource = self;
//        _table.showsVerticalScrollIndicator = NO;
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
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Top10" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        _dataArr = dic[@"result"];
    }
    return _dataArr;
}

@end
