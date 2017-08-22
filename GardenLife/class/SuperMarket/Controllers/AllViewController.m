//
//  AllViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/4.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "AllViewController.h"
#import "SortCell.h"
#import "DetailViewController.h"


#define URL @"http://ec.htxq.net/rest/htxq/goods/itemGoods?itemId=%@"

@interface AllViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collection;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = AUTOCOLOR;
    
    if (self.flag == 1) {
        self.title = @"分组列表";
        [self observeNetStatus];
    }else{
        self.title = @"主题列表";
        self.dataArr = self.dataArrFromTheme;
    }
    
    [self buildCollection];
    
}

-(void)buildCollection
{
    //    collection
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    _collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor whiteColor];
    _collection.delegate = self;
    _collection.dataSource = self;
    [self.view addSubview:_collection];
    //cell的复用
    // 代码+xib方法，一定要用下面的方法！否则cell无法加载
    [_collection registerNib:[UINib nibWithNibName:@"SortCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    
}


- (void)observeNetStatus
{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //            NSLog(@"无网络连接");
            // *** HUD ***
//            self.hud = [JGProgressHUD showMessage:@"无网络连接" inViewController:self];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//                [self.hud hides];
//            });
            
        }else
        {
            [self getDataFromNet];
        }
        
    }];
}

- (void)getDataFromNet
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer.timeoutInterval = 30;
    NSString *urlStr = [NSString stringWithFormat:URL,self.idStr];
//    NSLog(@"urlStr == %@",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.dataArr = responseObject[@"result"][@"result"];
        
        
        
        [self.collection reloadData];//刷表
//        [self.hud hides]; // *** HUD ***
//        //        [self createCollectionHeadViewwithView:self.viewHead];
//        [self createCollectionHeadView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"获取网络数据失败,error==%@",error);
    }];
}




#pragma mark - UICollectionViewDataSource
//每个section有几个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
//cell复用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArr[indexPath.row];
    return [SortCell cellWithCollectionView:collectionView andDataDic:dic andIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    return CGSizeMake(SCREENWIDTH/2-15, (190.0/145.0)*(SCREENWIDTH/2-15));//
    return CGSizeMake(SCREENWIDTH/2-15, 230);
    
}
//定义每个UICollectionView 的 inset
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//上、左、下、右（是相当于整个section的）
}




#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [NSDictionary dictionary];
    
    if (!self.dataArrFromTheme) {// 点击menu传过来的界面
        dic = self.dataArr[indexPath.row];
    }else{  // 点击sectionHead传过来的界面
        NSDictionary *tempDic = self.dataArrFromTheme[indexPath.row];
        dic = tempDic[@"pGoods"];
    }
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.flagStr = @"goods";
    vc.idStr = dic[@"fnId"];
    vc.titleStr = dic[@"fnName"];
    vc.imageStr= dic[@"fnAttachmentSnap1"];
//    NSLog(@"titleStr ==== %@",vc.titleStr);
    vc.priceStr = [NSString stringWithFormat:@"￥:%@",dic[@"fnMarketPrice"]];
    vc.dataDic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}










-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
