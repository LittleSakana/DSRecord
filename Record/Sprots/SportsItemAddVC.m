//
//  SportsItemAddVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "SportsItemAddVC.h"
#import "SportsItem+CoreDataClass.h"

@interface SportsItemAddVC ()

@property (nonatomic, strong) UITextField   *tfName;
@property (nonatomic, strong) UIButton      *btnAdd;

@end

@implementation SportsItemAddVC

#pragma mark - VC生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPage];
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化页面
- (void)initPage{
    
    self.navigationItem.title = @"运动项目";
    
    _tfName = [[UITextField alloc] init];
    self.tfName.placeholder = @"请输入运动项目名称";
    self.tfName.backgroundColor = [UIColor whiteColor];
    self.tfName.frame = CGRectMake(20, 30, YYScreenSize().width - 40, 40);
    self.tfName.textColor = [UIColor colorWithHexString:Color_blue];
    self.tfName.leftViewMode = UITextFieldViewModeAlways;
    self.tfName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [self.tfName becomeFirstResponder];
    [self.view addSubview:self.tfName];
    
    _btnAdd = [UITools createButtonWithFrame:CGRectMake(40, self.tfName.bottom + 40, YYScreenSize().width - 80, 35)
                                                title:@"添加"
                                             setImage:nil
                                             setBgImg:nil
                                                 font:[UIFont systemFontOfSize:16]
                                           titleColor:[UIColor whiteColor]
                                      backgroundColor:[UIColor colorWithHexString:Color_blue]
                                            SuperView:self.view];
    self.btnAdd.layer.masksToBounds = YES;
    self.btnAdd.layer.cornerRadius = 3;
    [self.btnAdd addTarget:self action:@selector(clickBtnAdd) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 初始化数据
- (void)initData{
    if (self.strKeyword && self.strKeyword.length > 0) {
        [self.btnAdd setTitle:@"修改" forState:UIControlStateNormal];
        NSArray *arr = [SportsItem searchSportsWithKeyword:self.strKeyword];
        [arr enumerateObjectsUsingBlock:^(SportsItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            self.tfName.text = obj.name;
        }];
    }
}

#pragma mark - 按钮点击事件
- (void)clickBtnAdd{
    [self.view endEditing:YES];
    
    if ([self.tfName.text stringByTrim].length == 0) {
        [self showMessage:@"运动项目名称不能为空"];
        return;
    }
    
    //根据名称先进行查询，如果已存在，则提示已经存在
    NSArray *arrSearch = [SportsItem searchSportsWithName:[self.tfName.text stringByTrim]];
    if (arrSearch && arrSearch.count > 0) {
        [self showMessage:@"此运动项目已存在"];
        return;
    }
    
    //添加运动项目
    BOOL flag;
    if (self.strKeyword && self.strKeyword.length > 0) {
        flag = [SportsItem addObjectWithKeyword:self.strKeyword andName:self.tfName.text];
    }else{
        flag = [SportsItem addObjectWithKeyword:[self generateKeyword] andName:self.tfName.text];
    }
    if (flag) {
        [self showMessage:@"保存运动项目成功"];
        [self performSelector:@selector(popVC) withObject:nil afterDelay:1.5];
    }else{
        [self showMessage:@"保存运动项目失败"];
    }
}

#pragma mark - 网络请求

#pragma mark - 代理方法

#pragma mark - 其他
- (NSString*)generateKeyword{
    NSString *strKeyword = [NSString stringWithFormat:@"sportsItem%i",arc4random()/1000000];
    NSArray *arr = [SportsItem searchSportsWithKeyword:strKeyword];
    if (arr && arr.count > 0) {
        strKeyword = [self generateKeyword];
    }
    return strKeyword;
}
@end
