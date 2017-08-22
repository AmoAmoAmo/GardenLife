//
//  UpDataAddressViewController.m
//  LoveFresh
//
//  Created by Jane on 16/4/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "UpDataAddressViewController.h"
#import "SexBtn.h"

#define TFX 15+70+10
#define leftMargin  15
#define labelWidth  70
#define Height      50
#define TFWIDTH     200

@interface UpDataAddressViewController ()<UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UIView *addressView;

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *city1TF;
@property (nonatomic, strong) UITextField *city2TF;
@property (nonatomic, strong) UITextField *detailTF;

@property (nonatomic, strong) SexBtn *sexManBtn;
@property (nonatomic, strong) SexBtn *sexWomanBtn;

@property (nonatomic,strong) UIButton *saveBtn;

/** 滚轮选择器 */
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *citysArr;
/** 省份列 选中了第几行 */
@property (nonatomic ,assign) NSInteger firstRow;
/** 城市列 选中了第几行 */
@property (nonatomic ,assign) NSInteger secondRow;

@end

@implementation UpDataAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑地址";
        
    [self.view setBackgroundColor:AUTOCOLOR];
    
    [self setUI];
}

-(void)setUI
{
        
    [self.view addSubview:self.scroll];
    
    [self.addressView addSubview:self.nameTF];
    [self.addressView addSubview:self.phoneTF];
    self.city1TF.inputView = self.pickerView;
    self.city1TF.inputAccessoryView = [self buildInputViewWithTitle:@"选择城市"];
    [self.addressView addSubview:self.city1TF];
    [self.addressView addSubview:self.city2TF];
    [self.addressView addSubview:self.detailTF];
    [self.addressView addSubview:self.sexManBtn];
    [self.addressView addSubview:self.sexWomanBtn];
    
    [self.scroll addSubview:self.addressView];
    
    
    //  确认并保存按钮
    [self buildSaveBtn];
    
    // 监听textField是否都填上内容
    [self.detailTF addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self.nameTF addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self.phoneTF addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self.city1TF addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self.city2TF addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听 firstRow 是否发生改变
    [self addObserver:self forKeyPath:@"firstRow" options:NSKeyValueObservingOptionNew context:nil];
    
    if (!self.idStr) {
        // 禁止状态
        [self.saveBtn setEnabled:NO];
    }
    
    
    //
    if (self.dataDic) {//修改界面
        
        [self updateUIDataWithDic:self.dataDic];
    }
}


-(UIView*)buildInputViewWithTitle:(NSString *)title
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    lineV.alpha = 0.6;
    [toolBar addSubview:lineV];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.alpha = 0.8;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [toolBar addSubview:titleLabel];
    
    UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noBtn.frame = CGRectMake(0, 0, 80, 40);
    [noBtn setTitle:@"取消" forState:UIControlStateNormal];
    [noBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    noBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [noBtn addTarget:self action:@selector(selectedCityTextFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:noBtn];
    
    UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yesBtn.frame = CGRectMake(SCREENWIDTH-80, 0, 80, 40);
    [yesBtn setTitle:@"确定" forState:UIControlStateNormal];
    [yesBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    yesBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [yesBtn addTarget:self action:@selector(selectedCityTextFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:yesBtn];
    
    
    return toolBar;
}

-(void)selectedCityTextFieldDidChange:(UIButton*)btn
{
    if ([btn.titleLabel.text isEqualToString:@"确定"]) {
        
        NSDictionary *dic = self.citysArr[self.firstRow];
        // 省份
        NSString *city1Str = dic[@"name"];
        // 城市
        NSArray *arr = dic[@"cities"];
        NSDictionary *dic2 = arr[self.secondRow];
        NSString *city2Str = dic2[@"name"];
        
        NSString *cityStr = [NSString stringWithFormat:@"%@ %@",city1Str,city2Str];
        [self.city1TF setText:cityStr];
//        [self.pickerView endEditing:YES];
        [self.city1TF endEditing:YES];
        
    }else                                   // 取消
        [self.city1TF endEditing:YES];
}


#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSString *str = change[@"new"];
//    NSLog(@"change===%@",change);
//    NSLog(@"/////////%ld",self.detailTF.text.length);
    
    if ([str integerValue] && [str integerValue] <= 11 && [str integerValue] > 0) { // self.firstRow 发生改变

        // 刷 pickerView  第二列 reload
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];// 总是先从第一行显示
    }
  
    
    if (str && self.nameTF.text.length && self.phoneTF.text.length>=11 && self.city1TF.text.length && self.city2TF.text.length && self.detailTF.text.length) {
        // 如果全部填满，按钮为非禁止状态
        [self.saveBtn setEnabled:YES];
    }else
        [self.saveBtn setEnabled:NO];
}
-(void)dealloc
{
    [self.nameTF removeObserver:self forKeyPath:@"text" context:nil];
    [self.phoneTF removeObserver:self forKeyPath:@"text" context:nil];
    [self.city1TF removeObserver:self forKeyPath:@"text" context:nil];
    [self.city2TF removeObserver:self forKeyPath:@"text" context:nil];
    [self.detailTF removeObserver:self forKeyPath:@"text" context:nil];
    
    [self removeObserver:self forKeyPath:@"firstRow" context:nil];
}



#pragma mark - UIPickerViewDataSource
// 有几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// 每一列有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.citysArr.count;
    }else{
        NSDictionary *dic = self.citysArr[self.firstRow];
        NSArray *arr = dic[@"cities"];
        return arr.count;
    }
}

// 每一行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        NSDictionary *dic1 = self.citysArr[row];
        return dic1[@"name"];
        
    }else{
        NSDictionary *dic1 = self.citysArr[self.firstRow];
        NSArray *arr = dic1[@"cities"];
        NSDictionary *dic2 = arr[row];
        return dic2[@"name"];
    }
}

#pragma mark - UIPickerViewDelegate

// 选择了那一列，那一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.firstRow = row;
    }else
        self.secondRow = row;
//    NSLog(@"%ld 列，%ld 行", component, row);
}




#pragma mark - 更新界面数据
-(void)updateUIDataWithDic:(NSDictionary*)dic
{
    [self.nameTF setText:dic[@"name"]];
    [self.phoneTF  setText:dic[@"telphone"]];
    [self.city1TF  setText:dic[@"province_name"]];
    [self.city2TF  setText:dic[@"city_name"]];
    [self.detailTF  setText:dic[@"address"]];
    if ([dic[@"gender"] isEqualToString:@"1"]) {//man
        
        self.sexManBtn.selected = YES;
    }else
        self.sexWomanBtn.selected = YES;
}

-(void)buildSaveBtn
{
    if (!self.idStr) {
//        [self.saveBtn removeTarget:self action:@selector(clickSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.scroll addSubview:self.saveBtn];
}

-(void)clickBackBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickSaveBtn
{
    // 保存
    //  sandBox
    NSString *homePath = NSHomeDirectory();
    //获取完整路径
    NSString *path = [homePath stringByAppendingPathComponent:@"/Documents/MyAddressData.plist"];
    NSLog(@"地址plist文件路径：%@",path);
    //沙盒文件中的全部内容（arr）
    NSMutableArray *docDataArr = [NSMutableArray arrayWithContentsOfFile:path];

    
    
    

    // 判断 修改、还是新建
    if (self.idStr) {// edit
        
        
        NSMutableDictionary *dic = [docDataArr objectAtIndex:[self.idStr intValue]];
        [dic setValue:self.nameTF.text forKey:@"name"];
        [dic setValue:self.phoneTF.text forKey:@"telphone"];
        [dic setValue:self.city1TF.text forKey:@"province_name"];
        [dic setValue:self.city2TF.text forKey:@"city_name"];
        [dic setValue:self.detailTF.text forKey:@"address"];
        
        if (self.sexManBtn.selected) {
            
            [dic setValue:@"1" forKey:@"gender"];
        }else{
            [dic setValue:@"2" forKey:@"gender"];
        }
        
    }else{          // new,new id
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.nameTF.text forKey:@"name"];
        [dic setValue:self.phoneTF.text forKey:@"telphone"];
        [dic setValue:self.city1TF.text forKey:@"province_name"];
        [dic setValue:self.city2TF.text forKey:@"city_name"];
        [dic setValue:self.detailTF.text forKey:@"address"];
        
        if (self.sexManBtn.selected) {
            
            [dic setValue:@"1" forKey:@"gender"];
        }else{
            [dic setValue:@"2" forKey:@"gender"];
        }

        
        NSDictionary *tempDic = [docDataArr lastObject];
        NSString *idStr = tempDic[@"id"];
//        NSLog(@"last idStr   %@",idStr);
        NSInteger idIndex = [idStr intValue];
        [dic setValue:[NSString stringWithFormat:@"%ld",idIndex+1] forKey:@"id"];
        [docDataArr insertObject:dic atIndex:idIndex+1];
    }
    
    
    [docDataArr writeToFile:path atomically:YES];
    // 并退出
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickSexBtn:(UIButton *)sexBtn
{
    if ([sexBtn.titleLabel.text isEqualToString:@"先生"]) {
        
        self.sexManBtn.selected = YES;
        self.sexWomanBtn.selected = NO;
    }else
    {
        self.sexManBtn.selected = NO;
        self.sexWomanBtn.selected = YES;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",event);
    [self.view endEditing:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark - setter and getter
-(UIPickerView *)pickerView
{
    if (!_pickerView)
    {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-200, SCREENWIDTH, 200)];
        
        
        // 代理和数据源，显示的内容是通过数据源指定的
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

-(UIScrollView *)scroll
{
    if (!_scroll) {
        
        _scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scroll.backgroundColor = [UIColor clearColor];
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.alwaysBounceVertical = YES;
        _scroll.userInteractionEnabled = YES;
        _scroll.delegate = self;
    }
    return _scroll;
}
-(UIView *)addressView
{
    if (!_addressView) {
        
        _addressView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH, 300)];
        _addressView.backgroundColor =[UIColor whiteColor];
        _addressView.userInteractionEnabled = YES;
        
        //****************************************
//        CGFloat leftMargin = 15;
//        CGFloat labelWidth = 70;
//        CGFloat height     = 50;
        
        UILabel *nameL  = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, 0, labelWidth, Height)];
        UILabel *phoneL = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, Height*2, labelWidth, Height)];
        UILabel *city1L = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, Height*3, labelWidth, Height)];
        UILabel *city2L = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, Height*4, labelWidth, Height)];
        UILabel *detaiL = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, Height*5, labelWidth, Height)];
        nameL.text = @"联系人";
        phoneL.text = @"手机号码";
        city1L.text = @"所在城市";
        city2L.text = @"所在地区";
        detaiL.text = @"详细地址";
        nameL.font = [UIFont systemFontOfSize:15];
        phoneL.font = [UIFont systemFontOfSize:15];
        city2L.font = [UIFont systemFontOfSize:15];
        city1L.font = [UIFont systemFontOfSize:15];
        detaiL.font = [UIFont systemFontOfSize:15];
        [_addressView addSubview:nameL];
        [_addressView addSubview:phoneL];
        [_addressView addSubview:city1L];
        [_addressView addSubview:city2L];
        [_addressView addSubview:detaiL];

        for (int i = 0; i < 5; i++) {
            
            UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(10, Height - 1 + Height*i, SCREENWIDTH - 20, 1)];
            [_addressView addSubview:lineV];
            lineV.backgroundColor = [UIColor lightGrayColor];
        }
        
    }
    return _addressView;
}
-(UITextField *)nameTF
{
    if (!_nameTF) {
        
        _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(TFX, 0, TFWIDTH, Height)];
        _nameTF.font = [UIFont systemFontOfSize:15];
        _nameTF.placeholder = @"收货人姓名";
    }
    return _nameTF;
}
-(UITextField *)phoneTF
{
    if (!_phoneTF) {
        
        _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(TFX, Height*2, TFWIDTH, Height)];
        _phoneTF.placeholder = @"手机号码";
        _phoneTF.font = [UIFont systemFontOfSize:15];
        _phoneTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneTF;
}
-(UITextField *)city1TF
{
    if (!_city1TF) {
        
        _city1TF = [[UITextField alloc] initWithFrame:CGRectMake(TFX, Height*3, TFWIDTH, Height)];
        _city1TF.font = [UIFont systemFontOfSize:15];
        _city1TF.placeholder = @"";
    }
    return _city1TF;
}
-(UITextField *)city2TF
{
    if (!_city2TF) {
        
        _city2TF = [[UITextField alloc] initWithFrame:CGRectMake(TFX, Height*4, TFWIDTH, Height)];
        _city2TF.font = [UIFont systemFontOfSize:15];
        _city2TF.placeholder = @"地区";
    }
    return _city2TF;
}
-(UITextField *)detailTF
{
    if (!_detailTF) {
        
        _detailTF = [[UITextField alloc] initWithFrame:CGRectMake(TFX, Height*5, TFWIDTH, Height)];
        _detailTF.font = [UIFont systemFontOfSize:15];
        _detailTF.placeholder = @"详细地址";
    }
    return _detailTF;
}
-(SexBtn *)sexManBtn
{
    if (!_sexManBtn) {
        
        _sexManBtn = [SexBtn buttonWithType:UIButtonTypeCustom];
        _sexManBtn.frame = CGRectMake(TFX, Height*1, 100, 50);
        [_sexManBtn setTitle:@"先生" forState:UIControlStateNormal];
        [_sexManBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sexManBtn setImage:[UIImage imageNamed:@"v2_noselected"] forState:UIControlStateNormal];
        [_sexManBtn setImage:[UIImage imageNamed:@"v2_selected"] forState:UIControlStateSelected];
        [_sexManBtn addTarget:self action:@selector(clickSexBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sexManBtn;
}
-(SexBtn *)sexWomanBtn
{
    if (!_sexWomanBtn) {
        
        _sexWomanBtn = [SexBtn buttonWithType:UIButtonTypeCustom];
        _sexWomanBtn.frame = CGRectMake(TFX + 100 + 10, Height*1, 100, 50);
        [_sexWomanBtn setTitle:@"女士" forState:UIControlStateNormal];
        [_sexWomanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sexWomanBtn setImage:[UIImage imageNamed:@"v2_noselected"] forState:UIControlStateNormal];
        [_sexWomanBtn setImage:[UIImage imageNamed:@"v2_selected"] forState:UIControlStateSelected];
        [_sexWomanBtn addTarget:self action:@selector(clickSexBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sexWomanBtn;
}

-(UIButton *)saveBtn
{
    if (!_saveBtn) {
        
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];

        _saveBtn.frame = CGRectMake(50, 7*Height, SCREENWIDTH - 100, Height - 20);
        [_saveBtn setTitle:@"确  认" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_saveBtn setBackgroundImage:[UIImage imageNamed:@"mw1"] forState:UIControlStateNormal];
        [_saveBtn setBackgroundImage:[UIImage imageNamed:@"llll"] forState:UIControlStateDisabled];// 禁止状态下
        _saveBtn.layer.cornerRadius = 8;
        _saveBtn.clipsToBounds = YES;
        _saveBtn.layer.borderWidth = 1;
        _saveBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_saveBtn addTarget:self action:@selector(clickSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

-(NSArray *)citysArr
{
    if (!_citysArr) {
        
        _citysArr = [NSArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"城市" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        _citysArr = dic[@"citys"];
    }
    return _citysArr;
}

@end
