//
//  ProductViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductCell.h"
#import "AllViewController.h"
#import "DetailViewController.h"

@interface ProductViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self buildCollectionView];
}

-(void)buildCollectionView
{
    //    collection
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing= 1;
    layout.minimumLineSpacing = 1;
    
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64-49) collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor whiteColor];
    _collection.delegate = self;
    _collection.dataSource = self;
    [self.view addSubview:_collection];
    
    //cell的复用
    // 代码+xib方法，一定要用下面的方法！否则cell无法加载
    [_collection registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    
//    //collection 的 head // 类似于TableView的TableHeaderView
//    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, -200, SCREENWIDTH, 200)];
//    viewHead.backgroundColor = [UIColor whiteColor];
    _collection.contentInset = UIEdgeInsetsMake(150+40, 0, 0, 0);//重要，整个collection的inset
//    [_collection addSubview:viewHead];
    
    //section headView复用
    //    UICollectionElementKindSectionHeader   :用了判断是headView还是footView
    [_collection registerClass:[UICollectionReusableView class]
    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
           withReuseIdentifier:@"head"];
}



-(void)clickSectionHead:(UITapGestureRecognizer *)tap
{
    // 点击的是哪一个section
    NSInteger index = tap.view.tag-100;
    NSDictionary *dic  = self.dataArr[index];
    
    AllViewController *vc = [[AllViewController alloc] init];
    vc.flag = 0;
    vc.dataArrFromTheme = dic[@"childrenList"];
    
    [self.navigationController pushViewController:vc animated:YES];
}





#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
//每个section有几个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *dic = self.dataArr[section];
    NSArray *arr = dic[@"childrenList"];
    
    if (arr.count < 4) {
        return arr.count;
    }else
        return 4;
}
//cell复用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArr[indexPath.section];
    NSArray *arr = dic[@"childrenList"];
    
    return [ProductCell cellWithCollection:collectionView andDataDic:arr[indexPath.row] andIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREENWIDTH/2-0.5, SCREENWIDTH/2-0.5);
    
}
//定义每个UICollectionView 的 inset
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//上、左、下、右（是相当于整个section的）
}

//section headView大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 70);
}




//定制head  foot
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //判断是head ,还是foot
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        //这里是头部
        UICollectionReusableView *head =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
        
        // 防止head复用出现问题
        NSArray *array = [head subviews];
        for (UIView *view in array) {
            [view removeFromSuperview];
        }
        
        head.backgroundColor = [UIColor whiteColor];
        // *** data ****
        NSDictionary *dic = self.dataArr[indexPath.section];
        
        UILabel *engLabel= [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 150, 20)];
        engLabel.text = dic[@"fnDesc"];
        engLabel.font = [UIFont systemFontOfSize:14];
        engLabel.textColor = [UIColor lightGrayColor];
        [head addSubview:engLabel];
        
        UILabel *textLabel= [[UILabel alloc] initWithFrame:CGRectMake(30, 15+20, 150, 20)];
        textLabel.text = dic[@"fnName"];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.textColor = [UIColor lightGrayColor];
        [head addSubview:textLabel];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH-40, (70-10)*0.5, 10, 10)];
        [imgView setImage:[UIImage imageNamed:@"552cc1babd9aa_32"]];
        [head addSubview:imgView];
        
        // ***** tap *****
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSectionHead:)];
        head.userInteractionEnabled = YES;
        head.tag = indexPath.section+100;
        [head addGestureRecognizer:tap];
        
        return head;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {

    }
    return nil;
}



#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArr[indexPath.section];
    NSArray *arr =  dic[@"childrenList"];
    NSDictionary *tempDic = arr[indexPath.row];
    NSDictionary *Dic = tempDic[@"pGoods"];
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.flagStr = @"goods";
    vc.idStr = Dic[@"fnId"];
    vc.titleStr = Dic[@"fnName"];
    vc.imageStr= Dic[@"fnAttachmentSnap1"];
    vc.priceStr = [NSString stringWithFormat:@"￥:%@",Dic[@"fnMarketPrice"]];
    vc.dataDic = Dic;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 计算偏移
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"******* %f",self.collection.contentOffset.y);
//    _collection.contentInset = UIEdgeInsetsMake(150+40, 0, 0, 0);// scroll 下滑时就恢复原来的inset
    CGFloat contentY = -(scrollView.contentOffset.y +150 + 40);
//    NSLog(@"%f",contentY);
//    if (contentY >= -200) {  // head没有从视图中消失
    
        // 反向传值，需要上一视图控制器 设置head的位移
        
        if ([_delegate respondsToSelector:@selector(changeHeadViewOffsetWhenCollectionViewScrolledWithOffset:)]) {
            [_delegate changeHeadViewOffsetWhenCollectionViewScrolledWithOffset:contentY];
        }
        
//    }

}







-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Products" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        _dataArr = dic[@"result"];
    }
    return _dataArr;
}


@end
