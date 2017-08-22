//
//  HomeViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "HomeViewController.h"
#import "TopViewController.h"
#import "FMDBmanager.h"
#import "MJRefresh.h"
#import "MyHomeCell.h"
#import "HomeModel.h"
#import "DetailViewController.h"
#import "MenuViewController.h"
#import "AuthorViewController.h"
#import "MyRefreshHeader.h"


@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) JGProgressHUD *hud;

@property (nonatomic,strong) FMDBmanager *manager;


@property (nonatomic,strong) UIButton *menuBtn;
@property (nonatomic,assign) BOOL isRotation;
@property (nonatomic,strong) MenuViewController *menuVC;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    [self addNotification];
    
    
    [self buildTopItem];
    [self buildTableView];
}


-(void)buildTopItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"TOP" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.menuBtn];
}

-(void)clickRightItem
{
    TopViewController *vc = [[TopViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - 点击menu按钮
-(void)clickMenuBtn
{
    if (_isRotation !=1 ) {  // 点击前还没旋转
        
        // 让它旋转   &&   add VC
        _menuVC = [[MenuViewController alloc] init];
        _menuVC.flag = 1;
        [self addChildViewController:_menuVC];
        [self.view addSubview:_menuVC.view];
        _menuVC.view.frame = CGRectMake(0, 64-(SCREENHEIGHT-64-49), SCREENWIDTH, SCREENHEIGHT-64-49);
        
        [UIView animateWithDuration:0.6 animations:^{
            
            self.menuBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
            _menuVC.view.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-49);
        }];
        
        _isRotation = 1;
        
        
    }else{                   // 点击前已旋转
        // 让他恢复   &&   remove VC
        [UIView animateWithDuration:0.6 animations:^{
            
            self.menuBtn.transform = CGAffineTransformIdentity;
            _menuVC.view.frame = CGRectMake(0, 64-(SCREENHEIGHT-64-49), SCREENWIDTH, SCREENHEIGHT-64-49);
        } completion:^(BOOL finished) {
            
            [_menuVC.view removeFromSuperview];
            [_menuVC removeFromParentViewController];
            _menuVC = nil;
        }];
        
        _isRotation = 0;
    }
}



-(void)buildTableView
{
    [self.view addSubview:self.table];
    //设置上拉刷新
    [self setHeadRefresh];
}

- (void)setHeadRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MyRefreshHeader *header = [MyRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//    
//    // 隐藏状态
//    header.stateLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.table.header = header;
}

//下拉加载数据
- (void)loadNewData
{
    //模拟1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.table.header endRefreshing];
    });
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
    // ***
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
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;//把table的线去掉
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
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Home1" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        _dataArr = dic[@"result"];
    }
    return _dataArr;
}

-(UIButton *)menuBtn
{
    if (!_menuBtn) {
        _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_menuBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        _menuBtn.titleLabel.hidden = YES;
        _menuBtn.frame = CGRectMake(0, 0, 25, 25);
        [_menuBtn addTarget:self action:@selector(clickMenuBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuBtn;
}

@end
