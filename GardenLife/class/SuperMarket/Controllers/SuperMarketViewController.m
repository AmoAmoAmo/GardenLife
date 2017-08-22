//
//  SuperMarketViewController.m
//  Demo－1
//
//  Created by Jane on 16/3/12.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "SuperMarketViewController.h"
#import "JingCell.h"
#import "TipView.h"
#import "ProductViewController.h"
#import "QuestionViewController.h"
#import "MenuViewController.h"
#import "DetailViewController.h"

#define TopImgHeight 150  // 40

#define URL @"http://ec.htxq.net/rest/htxq/index/jingList/1"

@interface SuperMarketViewController ()<UITableViewDataSource,UITableViewDelegate,ProductViewControllerDelegate,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) NSMutableArray *dataArr;
//@property (nonatomic, assign) NSInteger lastSection;
@property (nonatomic,strong)UIScrollView *bgScroll;

@property (nonatomic,strong)UISegmentedControl *segment;

@property (nonatomic,strong)UIView *topView;
//@property (nonatomic,strong)UIImageView *headImgView;//**

@property (nonatomic,strong) ProductViewController *productVC;

@property (nonatomic,strong) UIButton *menuBtn;
@property (nonatomic,assign) BOOL isRotation;
//@property (nonatomic,strong) QuestionViewController *quesVC;
@property (nonatomic,strong) MenuViewController *menuVC;


@property (nonatomic,strong) UIButton *searchBtn;

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) UIView *searchTopView;

/**
 *滚动视图的控件
 */
@property(nonatomic,strong)UIScrollView* scroll;
/**
 *页码指示视图的控件
 */
@property(nonatomic,strong)UIPageControl* pageControl;
/**
 *显示左边图片的控件
 */
@property(nonatomic,strong)UIImageView* LeftImageView;
/**
 *显示中心图片的控件
 */
@property(nonatomic,strong)UIImageView* centerImageView;
/**
 *显示右边图片的控件
 */
@property(nonatomic,strong)UIImageView* rightImageView;
/**
 *保存图片的数组
 */
@property(nonatomic,strong)NSArray* imageArray;
/**
 *图片的当前下标索引
 */
@property(nonatomic,assign)NSInteger currentIndex;
/**
 *图片总数
 */
@property(nonatomic,assign)NSInteger imageCount;

/** 计时器 */
@property (nonatomic,strong) NSTimer *myTimer;

@end

@implementation SuperMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商城";

    [self addNotification];
    
    [self buildBGView];
    [self buildTopView];
    [self buildTableView];
    [self buildCollectionView];
    
    [self buildTopBtn];
}

-(void)buildTopBtn
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.menuBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
}





-(void)buildBGView
{
    [self.view addSubview:self.bgScroll];
    
}

-(void)buildTopView
{
    self.currentIndex=0;
    [self loadImage];
    [self createScrollView];
    [self createImageView];
    [self createPageControl];
    [self setImageByIndex:self.currentIndex];
    
    [self createTimer];
    
    
    
    
    
    
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + TopImgHeight, SCREENWIDTH, 40)];
    self.topView.backgroundColor = [UIColor whiteColor];
    
    [self.topView addSubview:self.segment];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREENWIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.topView addSubview:lineView];
    
    [self.view addSubview:self.topView];
}

-(void)buildTableView
{
    [self.bgScroll addSubview:self.table];
}

-(void)buildCollectionView
{
    self.productVC = [[ProductViewController alloc] init];
    self.productVC.delegate = self;
    [self addChildViewController:self.productVC];
    [self.bgScroll addSubview:self.productVC.view];
    
    self.productVC.view.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT-64-49);
}





#pragma mark - 点击menu按钮
-(void)clickMenuBtn
{
    
    
    if (_isRotation !=1 ) {  // 点击前还没旋转
        
        // 让它旋转   &&   add VC
        _menuVC = [[MenuViewController alloc] init];
        _menuVC.flag = 2;
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



-(void)clickSearchBtn
{
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.tag = 200;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:bgView];
    

//    self.navigationItem.titleView = self.searchBar;
    _searchTopView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, SCREENWIDTH, 64)];
//    [_searchTopView addSubview:self.searchBar];
    _searchTopView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view addSubview:_searchTopView];
    
    [_searchTopView  addSubview:self.searchBar];
    
    
    UIButton *canselBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canselBtn.frame = CGRectMake(SCREENWIDTH-50, (44-25)*0.5+20, 40, 25);
    [canselBtn setTitle:@"取消" forState:UIControlStateNormal];
    canselBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [canselBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [canselBtn addTarget:self action:@selector(clickCanselBtn) forControlEvents:UIControlEventTouchUpInside];
    [_searchTopView addSubview:canselBtn];
    
    [UIView animateWithDuration:0.2 animations:^{
        _searchTopView.frame = CGRectMake(0, 0, SCREENWIDTH, 64);
//        self.searchBtn.userInteractionEnabled = NO;
        // 让键盘成为第一响应者
        [self.searchBar becomeFirstResponder];
    }];
}

-(void)clickCanselBtn
{
    
    
    [self.searchBar endEditing:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        _searchTopView.frame = CGRectMake(0, -64, SCREENWIDTH, 44);
        [self.searchBar endEditing:YES];
        
    }];
    [_searchTopView removeFromSuperview];
    
    UIView *bgView = [self.view viewWithTag:200];
    [bgView removeFromSuperview];
    bgView = nil;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self clickCanselBtn];
}


#pragma mark - Notification
-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotice) name:@"no_more_product" object:nil];  /** 库存不足时的提醒view */
    
    /** NSNotificationCenter */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyNumisChangedWithNotic:) name:@"buyNum_isChanged" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NeedToShowCarVC) name:@"NeedToShowCarVC" object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)NeedToShowCarVC
{
    //    NSLog(@"444444444");
    self.tabBarController.selectedIndex = 2;
}

-(void)showNotice
{
    //        NSLog(@"该商品库存不足啦~请选购其他商品吧");
    [self.view addSubview:[TipView showTheTipView]];
}
-(void)buyNumisChangedWithNotic:(NSNotification*)noti
{
    [self.table reloadData];
}







/** 启动计时器 (线程) */
-(void)createTimer
{
    /**
     * 参数一：  时间间隔：多少秒
     *    二：  目标对象 self
     *    三：  SEL
     *    四：  nil
     *    五：  YES(重复)
     每两秒 调用一次self对象里面的 timeUpDate 方法
     */
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(timeUpDate) userInfo:nil repeats:YES];
}

-(void)timeUpDate
{
    [UIView animateWithDuration:0.6 animations:^{
        
        self.scroll.contentOffset=CGPointMake(SCREENWIDTH*2, 0);
        
    }completion:^(BOOL finished) {
        
        // 相当于停止减速了
        [self scrollViewDidEndDecelerating:self.scroll];
    }];
}


/**
 *以下是循环轮播图片UI界面的方法
 */
-(void)loadImage
{
    self.imageArray=@[@"head_0.jpg",@"head_1.jpg",@"head_2.jpg"];
    self.imageCount=self.imageArray.count;
}
-(void)createScrollView
{
    self.scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, TopImgHeight)];
    self.scroll.backgroundColor=[UIColor whiteColor];
    self.scroll.showsHorizontalScrollIndicator=NO;
    self.scroll.showsVerticalScrollIndicator=NO;
    self.scroll.pagingEnabled=YES;
    self.scroll.bounces=NO;
    self.scroll.delegate=self;
    self.scroll.contentOffset=CGPointMake(SCREENWIDTH, 0);
    self.scroll.contentSize=CGSizeMake(SCREENWIDTH*self.imageCount, TopImgHeight);
    [self.view addSubview:self.scroll];
}
-(void)createPageControl
{
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(130, 64+TopImgHeight-20, 60, 20)];
    self.pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    self.pageControl.enabled=YES;
    self.pageControl.numberOfPages=self.imageCount;
    [self.view addSubview:self.pageControl];
}
-(void)createImageView
{
    self.LeftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, TopImgHeight)];
    [self.scroll addSubview:self.LeftImageView];
    
    self.centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, TopImgHeight)];
    [self.scroll addSubview:self.centerImageView];
    
    self.rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH*2, 0, SCREENWIDTH, TopImgHeight)];
    [self.scroll addSubview:self.rightImageView];
}


#pragma mark ----刷新图片
-(void)refreshImage
{
    if (self.scroll.contentOffset.x>SCREENWIDTH) {
        self.currentIndex=((self.currentIndex+1)%self.imageCount);
    }
    else if(self.scroll.contentOffset.x<SCREENWIDTH){
        self.currentIndex=((self.currentIndex-1+self.imageCount)%self.imageCount);
    }
    [self setImageByIndex:self.currentIndex];
}

#pragma mark ----该方法根据传回的下标设置三个ImageView的图片
-(void)setImageByIndex:(NSInteger)currentIndex
{
    NSString* curruntImageName=[NSString stringWithFormat:@"head_%ld.jpg",currentIndex];
    self.centerImageView.image=[UIImage imageNamed:curruntImageName];
    
    self.LeftImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"head_%ld.jpg",((self.currentIndex-1+self.imageCount)%self.imageCount)]];
    
    self.rightImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"head_%ld.jpg",((self.currentIndex+1)%self.imageCount)]];
    self.pageControl.currentPage=currentIndex;
}

#pragma mark ----UIScrollViewDelegate代理方法（停止加速时调用）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView  // 滑得太快会出现空白（背景）是因为还没有停止减速，还没调用该方法
{
    if (scrollView == self.scroll)  // 图片滚动的scroll
    {
        [self refreshImage];
        self.scroll.contentOffset = CGPointMake(SCREENWIDTH,0);
        self.pageControl.currentPage = self.currentIndex;
    }
    
    
    if (scrollView == self.bgScroll) {  // 左右滑动的scroll
        NSInteger index = scrollView.contentOffset.x / SCREENWIDTH;
        self.segment.selectedSegmentIndex = index;
    }
}








#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JingCell *cell = [JingCell cellWithTable:tableView andDataDic:self.dataArr[indexPath.row]];
    
    [cell clickAddBtnandReturnImgView:^(UIImageView *imgView) {
        
        [self addProductsAnimationWithImageView:imgView];
    }];
    
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArr[indexPath.row];
    
    
    
    DetailViewController *vc= [[DetailViewController alloc] init];
    vc.flagStr = @"goods";
    vc.idStr = dic[@"fnId"];
    vc.titleStr = dic[@"fnName"];
    vc.imageStr= dic[@"fnAttachmentSnap1"];
    vc.priceStr = [NSString stringWithFormat:@"￥:%@",dic[@"fnMarketPrice"]];
    vc.dataDic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)clickSegment:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    
    self.bgScroll.contentOffset = CGPointMake(index*SCREENWIDTH, 0);
    
    self.productVC.collection.contentOffset =CGPointMake(0, 64-CGRectGetMaxY(self.topView.frame));
    self.table.contentOffset =CGPointMake(0, 64-CGRectGetMaxY(self.topView.frame));

}

#pragma mark - 计算偏移
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"**********");
    if (scrollView == self.table) {  // table
        
        CGFloat contentY = -(scrollView.contentOffset.y +TopImgHeight + 40);
//        NSLog(@"%f",contentY);
        if (contentY >= -200) {
            self.scroll.frame = CGRectMake(0, contentY+64, SCREENWIDTH, TopImgHeight);
            self.pageControl.frame= CGRectMake(130, contentY+(64+TopImgHeight-20), 60, 20);
            self.topView.frame = CGRectMake(0, contentY + TopImgHeight+64, SCREENWIDTH, 40);
        }else if(contentY < -200){ //  -220 < -200
            // 预防滑动太快时留在顶部的bug  contentY -> -200
            self.scroll.frame = CGRectMake(0, -200+64, SCREENWIDTH, TopImgHeight);
            self.pageControl.frame= CGRectMake(130, -200+(64+TopImgHeight-20), 60, 20);
            self.topView.frame = CGRectMake(0, -200 + TopImgHeight+64, SCREENWIDTH, 40);
        }
    }
    if (scrollView == self.bgScroll) {
    
        self.productVC.collection.contentOffset =CGPointMake(0, 64-CGRectGetMaxY(self.topView.frame));
        self.table.contentOffset =CGPointMake(0, 64-CGRectGetMaxY(self.topView.frame));
    }
}



#pragma mark - ProductViewControllerDelegate
-(void)changeHeadViewOffsetWhenCollectionViewScrolledWithOffset:(CGFloat)offsetY
{
//    NSLog(@"offsetY ====== %f",offsetY);
//    self.scroll.frame = CGRectMake(0, offsetY+64, SCREENWIDTH, TopImgHeight);
//    self.pageControl.frame= CGRectMake(130, offsetY+(64+TopImgHeight-20), 60, 20);
//    self.topView.frame = CGRectMake(0, offsetY + TopImgHeight+64, SCREENWIDTH, 40);
    
    if (offsetY >= -200) {
        self.scroll.frame = CGRectMake(0, offsetY+64, SCREENWIDTH, TopImgHeight);
        self.pageControl.frame= CGRectMake(130, offsetY+(64+TopImgHeight-20), 60, 20);
        self.topView.frame = CGRectMake(0, offsetY + TopImgHeight+64, SCREENWIDTH, 40);
    }else if(offsetY < -200){ //  -220 < -200
        // 预防滑动太快时留在顶部的bug  contentY -> -200
        self.scroll.frame = CGRectMake(0, -200+64, SCREENWIDTH, TopImgHeight);
        self.pageControl.frame= CGRectMake(130, -200+(64+TopImgHeight-20), 60, 20);
        self.topView.frame = CGRectMake(0, -200 + TopImgHeight+64, SCREENWIDTH, 40);
    }
}





#pragma mark -- UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText //实时获得搜索框中输入的数据
{
    //    NSLog(@"%@ ", searchText) ;
    //    NSString * str = searchBar.text ;
    if (searchText.length == 0) {
        //    NSLog(@"%@ -- %@",str, searchText) ;
        
        // searchBar字符串为0就隐藏搜索结果collection
        // 刷新 历史记录
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar  //  搜索按钮(回车)被按下
{
    NSLog(@"search.......");
    

    
}






#pragma mark - setter and getter
//懒加载
-(UITableView *)table
{
    if (_table == nil)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64-49) style:UITableViewStylePlain];//style:UITableViewStylePlain(默认 设置分组有悬浮)
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;//把table的线去掉
        _table.delegate = self;
        _table.dataSource = self;
        
        _table.contentInset = UIEdgeInsetsMake(TopImgHeight + 40, 0, 0, 0);
    }
    return _table;
}

-(UIScrollView *)bgScroll
{
    if (!_bgScroll) {
//        _bgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40+64, SCREENWIDTH, SCREENHEIGHT-40-64)];
        _bgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-49)];
        _bgScroll.alwaysBounceHorizontal = YES;
        _bgScroll.pagingEnabled = YES;
        _bgScroll.showsHorizontalScrollIndicator = NO;
        _bgScroll.contentSize = CGSizeMake(SCREENWIDTH*2, SCREENHEIGHT-64-49);
        _bgScroll.bounces = NO;
        _bgScroll.delegate = self;
    }
    return _bgScroll;
}

-(UISegmentedControl *)segment
{
    if (!_segment) {
        NSArray * items = @[@"精选",@"商城"] ;
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

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Collect10" ofType:nil];
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

//-(QuestionViewController *)quesVC
//{
//    if (!_quesVC) {
//        _quesVC = [[QuestionViewController alloc] init];
//        self.quesVC.view.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-49);
//        [self addChildViewController:_quesVC];
//        [self.view addSubview:_quesVC.view];
//    }
//    return _quesVC;
//}

-(UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"ic_nav_search"] forState:UIControlStateNormal];
        _searchBtn.titleLabel.hidden = YES;
        _searchBtn.frame = CGRectMake(0, 0, 25, 25);
        [_searchBtn addTarget:self action:@selector(clickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}
-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 64-30-6, SCREENWIDTH-60, 30)];
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.placeholder = @"请输入商品名称";
    }
    return _searchBar;
}

@end
