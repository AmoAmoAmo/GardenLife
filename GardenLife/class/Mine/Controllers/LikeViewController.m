//
//  LikeViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/5.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "LikeViewController.h"
#import "MyHomeCell.h"
#import "DetailModel.h"
#import "HomeModel.h"
#import "DetailViewController.h"
#import "AuthorViewController.h"

@interface LikeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UIView *emptyView;

@end

@implementation LikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets= YES;
    self.view.backgroundColor = AUTOCOLOR;
    self.title = @"我的收藏";
    
    [self addNotification];
    [self buildUI];
    [self loadDataFromDB];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBarTintColor:nil];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)loadDataFromDB
{
    [self.dataArr removeAllObjects];
    
    FMDBmanager *manager = [FMDBmanager shareInstance];
    NSString *sqlStr = [NSString stringWithFormat:@"select * from Like"];
    FMResultSet *rs = [manager.dataBase executeQuery:sqlStr];
    while ([rs next]) {
        HomeModel *model = [[HomeModel alloc] init];
        model.idStr = [rs stringForColumn:@"idStr"];
        model.imgUrlStr = [rs stringForColumn:@"imgUrl"];
        model.iconImgStr = [rs stringForColumn:@"icon"];
        model.nameStr = [rs stringForColumn:@"name"];
        model.rzStr = [rs stringForColumn:@"rzStr"];
        model.categoryStr = [rs stringForColumn:@"category"];
        model.titleStr = [rs stringForColumn:@"title"];
        model.desStr = [rs stringForColumn:@"desStr"];
        model.liulangStr = [rs stringForColumn:@"lookNum"];//
        model.collectedNum = [rs stringForColumn:@"likeNum"];
        model.huifuStr = [rs stringForColumn:@"commentNum"];
        model.createDateStr= [rs stringForColumn:@"createDate"];
        [self.dataArr addObject:model];
        
    }
    /**
     (idStr ,icon ,name , rzStr ,lookNum ,imgUrl ,title ,category , commentNum , desStr , likeNum , createDate )
     */
    [self.table reloadData];
    
    if (!self.dataArr.count) {
        // 为空，创建相应的界面
//        NSLog(@"*****  %ld",self.dataArr.count);
        [self showEmptyUI];
    }else
    {
        //
        [self.emptyView removeFromSuperview];
//        [self buildUI];
    }
    
}

-(void)buildUI
{
    [self.view addSubview:self.table];
}

-(void)showEmptyUI
{
    [self.view addSubview:self.emptyView];
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
    MyHomeCell *cell = [MyHomeCell cellWithTable:tableView andModel:self.dataArr[indexPath.row] andDataDic:nil];
    
    cell.iconImgView.userInteractionEnabled = YES;
    cell.iconImgView.tag = 100+indexPath.row;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAuthorView:)];
    [cell.iconImgView addGestureRecognizer:tap];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel *model = self.dataArr[indexPath.row];
    
    DetailViewController *vc= [[DetailViewController alloc] init];
    vc.flagStr = @"db";
    vc.idStr = model.idStr;
    vc.titleStr = model.titleStr;
    // ***
//    vc.dataDic = self.dataArr[indexPath.row];
    vc.myModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - Notification
-(void)addNotification
{
    /** NSNotificationCenter */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyNumisChangedWithNotic:) name:@"buyNum_isChanged" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataFromDB) name:@"LikeTableNeedToReload" object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)buyNumisChangedWithNotic:(NSNotification*)noti
{
    [self.table reloadData];
}




#pragma mark - 点击userView
-(void)clickAuthorView:(UITapGestureRecognizer*)tap
{
//    NSInteger index = tap.view.tag-100;
    AuthorViewController *vc = [[AuthorViewController alloc] init];
//    NSDictionary *dic = self.dataArr[index];
    vc.dataDic = nil;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - setter and getter
//懒加载
-(UITableView *)table
{
    if (_table == nil)
    {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];//style:UITableViewStylePlain(默认 设置分组有悬浮)
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;//把table的线去掉
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
    
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
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _emptyView.backgroundColor = AUTOCOLOR;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH-200)*0.5, (SCREENHEIGHT-100)*0.5-50, 200, 100)];
        label.text = @"暂时没有喜欢的收藏噢~";
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        
        [_emptyView addSubview:label];
    }
    return _emptyView;
}

@end
