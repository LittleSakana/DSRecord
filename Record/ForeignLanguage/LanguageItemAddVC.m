//
//  LanguageItemAddVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "LanguageItemAddVC.h"
#import "LanguageItem+CoreDataClass.h"

@interface LanguageItemAddVC ()

@property (nonatomic, strong) UITextField   *tfName;
@property (nonatomic, strong) UIButton      *btnAdd;

@end

@implementation LanguageItemAddVC

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
    
    self.navigationItem.title = @"外语项目";
    
    _tfName = [[UITextField alloc] init];
    self.tfName.placeholder = @"请输入外语项目名称";
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
        NSArray *arr = [LanguageItem searchLanguageItemWithKeyword:self.strKeyword];
        [arr enumerateObjectsUsingBlock:^(LanguageItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            self.tfName.text = obj.name;
        }];
    }
}

#pragma mark - 按钮点击事件
- (void)clickBtnAdd{
    [self.view endEditing:YES];
    
    if ([self.tfName.text stringByTrim].length == 0) {
        [self showMessage:@"外语项目名称不能为空"];
        return;
    }
    
    //根据名称先进行查询，如果已存在，则提示已经存在
    NSArray *arrSearch = [LanguageItem searchLanguageItemWithName:[self.tfName.text stringByTrim]];
    if (arrSearch && arrSearch.count > 0) {
        [self showMessage:@"此外语项目已存在"];
        return;
    }
    
    //添加运动项目
    BOOL flag;
    if (self.strKeyword && self.strKeyword.length > 0) {
        flag = [LanguageItem addObjectWithKeyword:self.strKeyword andName:self.tfName.text];
    }else{
        flag = [LanguageItem addObjectWithKeyword:[self generateKeyword] andName:self.tfName.text];
    }
    if (flag) {
        [self showMessage:@"保存外语项目成功"];
        [self performSelector:@selector(popVC) withObject:nil afterDelay:1.5];
    }else{
        [self showMessage:@"保存外语项目失败"];
    }
}

#pragma mark - 网络请求

#pragma mark - 代理方法

#pragma mark - 其他
- (NSString*)generateKeyword{
    NSString *strKeyword = [NSString stringWithFormat:@"languageItem%i",arc4random()/1000000];
    NSArray *arr = [LanguageItem searchLanguageItemWithKeyword:strKeyword];
    if (arr && arr.count > 0) {
        strKeyword = [self generateKeyword];
    }
    return strKeyword;
}
@end
