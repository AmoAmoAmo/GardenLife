//
//  MyAddressViewController.m
//  
//
//  Created by Jane on 16/4/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "MyAddressViewController.h"
#import "AddressCell.h"
#import "UpDataAddressViewController.h"
#import "HomeViewController.h"

@interface MyAddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,copy) NSMutableArray *dataArr;

@property (nonatomic,strong) UIView *addNewAddressView;

@property (nonatomic, assign) BOOL isSelected;
/** 把选中的row写入userDefault */
@property (nonatomic, assign) NSInteger selectedRow;

@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"管理收货地址";
    
    // 设置选中行index
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *rowStr = [userDefaults objectForKey:@"selectedRow"];
    if (!rowStr) {
        self.selectedRow = 0;
    }else{
        
        self.selectedRow = [rowStr intValue];
    }
    
    
    
    [self setUI];
//    NSLog(@"view did load...");
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBarTintColor:nil];
    self.tabBarController.tabBar.hidden = YES;
    
    // 清空数据源，让它重新从mainbundle/沙盒目录中读取数据
    self.dataArr = nil;
    // 重新刷表
    [self.table reloadData];
}

-(void)setUI
{
    
    
    [self.view addSubview:self.table];
    
    [self.view addSubview:self.addNewAddressView];
}

-(void)clickAddNewAddressBtn
{
    UpDataAddressViewController *vc = [[UpDataAddressViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDataSource

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic  = self.dataArr[indexPath.row];
    
    AddressCell *cell = [AddressCell createCellWithTabel:tableView andDataDic:dic];

//    NSLog(@"indexPath.row==%ld",indexPath.row);
    // 注意不要设置为UITableViewCellSelectionStyleNone 属性
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//去掉cell选中效果
//    cell.selected = self.isSelected;
    
    if (indexPath.row == self.selectedRow) {
//        cell.selected = YES;
        cell.lineView.hidden = NO;
    }else{
        cell.lineView.hidden = YES;
    }
    
    
    // *******
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cilckEdit:)];
    cell.tapView.tag = indexPath.row;
    [cell.tapView addGestureRecognizer:tap];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArr[indexPath.row];
    
    
    
    // **** userdefault *****
    self.selectedRow = indexPath.row;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%ld",self.selectedRow] forKey:@"selectedRow"];
    // 写入内存（每次打开都记录上一次选中）
    [userDefaults synchronize];
    [self.table reloadData];
    
    
    // --------- 发送通知消息 （发送给前一个VC） ---------
    [[NSNotificationCenter defaultCenter] postNotificationName:@"get_receiver_massage" object:self userInfo:dic];
    
    if ([self.flagStr isEqualToString:@"car"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)cilckEdit:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    NSDictionary *dic  = self.dataArr[index];
    
    UpDataAddressViewController *vc = [[UpDataAddressViewController alloc] init];
    vc.idStr = dic[@"id"];
    vc.dataDic = self.dataArr[index];
    [self.navigationController pushViewController:vc animated:YES];
}

//滑动删除事件
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"-- row = %ld",indexPath.row);
    // 1. 删数据
    [self.dataArr removeObjectAtIndex:indexPath.row];
    //    数据更新到沙盒目录文件
    //      sandBox
    NSString *homePath = NSHomeDirectory();
    //      获取完整路径
    NSString *path = [homePath stringByAppendingPathComponent:@"/Documents/MyAddressData.plist"];
    //    NSLog(@"地址plist文件路径：%@",path);
    //      地址plist文件中的全部内容（arr）
    NSMutableArray *docDataArr = [NSMutableArray arrayWithContentsOfFile:path];
    [docDataArr removeObjectAtIndex:indexPath.row];
    // 更新到地址plist文件中
    [docDataArr writeToFile:path atomically:YES];
    
    
    // 2. 删界面
    NSLog(@"--- 删界面 ---- indexPath = %@",indexPath);
    NSArray *deleteArr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    [self.table deleteRowsAtIndexPaths:deleteArr withRowAnimation:UITableViewRowAnimationLeft];
}
//更改删除文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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

        
        //获取本地沙盒路径
        NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //获取完整路径
        NSString *documentsPath = [pathArr objectAtIndex:0];
        NSString *path = [documentsPath stringByAppendingPathComponent:@"MyAddressData.plist"];
//        NSLog(@"1====%@",path);
        
        // 如果沙盒里有MyAddressData.plist该文件的话则直接读文件内容
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:path]) {
            //沙盒文件中的内容（arr）
            NSArray *docArr = [NSArray arrayWithContentsOfFile:path];

            /*
             如果将mutableCopy换成copy 或者直接_dataArr = (NSMutableArray*)[NSArray arrayWithArray:docArr];
             就会报以上错误或者[__NSArrayI addObjectAtIndex:]: unrecognized selector sent to instance  等等一列操作NSArray的错误.
             
             注:将NSMutableArray转成NSArray的时候要写copy
             */
//            _dataArr = (NSMutableArray*)[NSArray arrayWithArray:docArr];  // 误
            _dataArr = [docArr mutableCopy];  // NSArray转成NSMutableArray的时候要这样写
        }else
        {
            // 否则从mainBundle 的 plist文件读取数据，写入沙盒
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MyAddressData" ofType:@"plist"];
            NSArray *arr = [NSArray arrayWithContentsOfFile:plistPath];
            _dataArr = [arr mutableCopy];
            
            //把plist文件里面的内容写入沙盒
            [_dataArr writeToFile:path atomically:YES];
        }
        
    }
    return _dataArr;
}

-(UIView *)addNewAddressView
{
    if (!_addNewAddressView) {
        
        _addNewAddressView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-50, SCREENWIDTH, 50)];
        _addNewAddressView.backgroundColor = [UIColor whiteColor];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame= CGRectMake((SCREENWIDTH-140)/2, 10, 140, 30);
//        addBtn.frame= CGRectMake(0 , 0, 100, 60);

        addBtn.backgroundColor = THEMECORLOR;
        [addBtn setTitle:@"+ 新增收货地址" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.layer.cornerRadius = 8;
        addBtn.clipsToBounds = YES;
        [addBtn addTarget:self action:@selector(clickAddNewAddressBtn) forControlEvents:UIControlEventTouchUpInside];
        [_addNewAddressView addSubview:addBtn];
        
    }
    return _addNewAddressView;
}

@end
