//
//  PasswordAddVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/11.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "PasswordAddVC.h"
#import <SFHFKeychainUtils.h>

@interface PasswordAddVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField   *tfDes;
@property (nonatomic, strong) UITextField   *tfAccount;
@property (nonatomic, strong) UITextField   *tfPassword;
@property (nonatomic, strong) UIButton      *btnAdd;

@end

@implementation PasswordAddVC

#pragma mark - VC生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化页面
- (void)initPage{
    self.navigationItem.title = @"添加密码";
    
    UIView *vBg = [UITools createViewWithFrame:CGRectMake(10, 30, YYScreenSize().width - 20, 150) backgroundColor:[UIColor whiteColor] superView:self.view];
    vBg.userInteractionEnabled = YES;
    
    UILabel *lblTypeTitle = [UITools createLabelWithFrame:CGRectMake(10, 0, 80, 50)
                                                     text:@"标题"
                                                     font:[UIFont systemFontOfSize:15]
                                                textColor:[UIColor colorWithHexString:@"333333"]
                                            textAlignment:NSTextAlignmentLeft
                                                SuperView:vBg];
    _tfDes = [[UITextField alloc] init];
    self.tfDes.placeholder = @"请输入标题";
    self.tfDes.frame = CGRectMake(lblTypeTitle.right, lblTypeTitle.top, vBg.width - lblTypeTitle.width - 20, lblTypeTitle.height);
    self.tfDes.textColor = [UIColor colorWithHexString:@"666666"];
    self.tfDes.keyboardType = UIKeyboardTypeDefault;
    self.tfDes.font = [UIFont systemFontOfSize:15];
    self.tfDes.textAlignment = NSTextAlignmentRight;
    self.tfDes.rightViewMode = UITextFieldViewModeAlways;
    self.tfDes.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [vBg addSubview:self.tfDes];
    CGRect rectSeparateLine = CGRectMake(0, lblTypeTitle.bottom, vBg.width, 1);
    [UITools createViewWithFrame:rectSeparateLine
                 backgroundColor:[UIColor colorWithHexString:@"f5f5f5"]
                       superView:vBg];
    
    UILabel *lblAccount = [UITools createLabelWithFrame:CGRectMake(lblTypeTitle.left, lblTypeTitle.bottom, lblTypeTitle.width, lblTypeTitle.height)
                                                     text:@"账号"
                                                     font:[UIFont systemFontOfSize:15]
                                                textColor:[UIColor colorWithHexString:@"333333"]
                                            textAlignment:NSTextAlignmentLeft
                                                SuperView:vBg];
    _tfAccount = [[UITextField alloc] init];
    self.tfAccount.placeholder = @"请输入账号";
    self.tfAccount.frame = CGRectMake(lblAccount.right, lblAccount.top, vBg.width - lblAccount.width - 20, lblAccount.height);
    self.tfAccount.textColor = [UIColor colorWithHexString:@"666666"];
    self.tfAccount.keyboardType = UIKeyboardTypeASCIICapable;
    self.tfAccount.font = [UIFont systemFontOfSize:15];
    self.tfAccount.textAlignment = NSTextAlignmentRight;
    self.tfAccount.rightViewMode = UITextFieldViewModeAlways;
    self.tfAccount.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [vBg addSubview:self.tfAccount];
    CGRect rectSeparateLine1 = CGRectMake(0, lblAccount.bottom, vBg.width, 1);
    [UITools createViewWithFrame:rectSeparateLine1
                 backgroundColor:[UIColor colorWithHexString:@"f5f5f5"]
                       superView:vBg];
    
    UILabel *lblPassword = [UITools createLabelWithFrame:CGRectMake(lblTypeTitle.left, lblAccount.bottom, lblTypeTitle.width, lblTypeTitle.height)
                                                      text:@"密码"
                                                      font:[UIFont systemFontOfSize:15]
                                                 textColor:[UIColor colorWithHexString:@"333333"]
                                             textAlignment:NSTextAlignmentLeft
                                                 SuperView:vBg];
    _tfPassword = [[UITextField alloc] init];
    self.tfPassword.placeholder = @"请输入密码";
    self.tfPassword.frame = CGRectMake(lblPassword.right, lblPassword.top, self.tfDes.width, lblPassword.height);
    self.tfPassword.textColor = [UIColor colorWithHexString:@"666666"];
    self.tfPassword.keyboardType = UIKeyboardTypeASCIICapable;
    self.tfPassword.font = [UIFont systemFontOfSize:15];
    self.tfPassword.textAlignment = NSTextAlignmentRight;
    self.tfPassword.rightViewMode = UITextFieldViewModeAlways;
    self.tfPassword.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [vBg addSubview:self.tfPassword];
    
    _btnAdd = [UITools createButtonWithFrame:CGRectMake(20, vBg.bottom + 30, YYScreenSize().width - 40, 45)
                                       title:@"保存"
                                    setImage:nil
                                    setBgImg:nil
                                        font:[UIFont systemFontOfSize:18]
                                  titleColor:[UIColor whiteColor]
                             backgroundColor:[UIColor colorWithHexString:Color_blue]
                                   SuperView:self.view];
    self.btnAdd.layer.masksToBounds = YES;
    self.btnAdd.layer.cornerRadius = 3;
    [self.btnAdd addTarget:self action:@selector(clickBtnAdd) forControlEvents:UIControlEventTouchUpInside];
    
    //如果传入有记录，则表示修改，不允许修改记录类型和时间
    if (self.password) {
        self.tfDes.text = self.password.detailDes;
        self.tfAccount.text = self.password.account;
        NSError *error;
        self.tfPassword.text = [SFHFKeychainUtils getPasswordForUsername:self.password.keyword andServiceName:Record_Service error:&error];
        if (error) {
            [self showMessage:@"读取密码出错"];
        }
    }
}

#pragma mark - 初始化数据

#pragma mark - 按钮点击事件
- (void)clickBtnAdd{
    [self.view endEditing:YES];
    if ([self.tfDes.text stringByTrim].length == 0) {
        [self showMessage:@"请输入描述"];
        return;
    }
    if ([self.tfPassword.text stringByTrim].length == 0) {
        [self showMessage:@"请输入密码"];
        return;
    }
    NSString *strKeyword = @"";
    if (self.password) {
        strKeyword = self.password.keyword;
    }else{
        strKeyword = [self generateKeyword];
    }
    BOOL flag = [Password addObjectWithKeyword:strKeyword andAccount:[self.tfAccount.text stringByTrim] andDetail:[self.tfDes.text stringByTrim]];
    NSError *error;
    [SFHFKeychainUtils storeUsername:strKeyword andPassword:[self.tfPassword.text stringByTrim] forServiceName:Record_Service updateExisting:YES error:&error];
    if (flag && !error) {
        [self showMessage:@"保存账号密码成功"];
        [self performSelector:@selector(popVC) withObject:nil afterDelay:1.5];
    }else{
        [self showMessage:@"保存账号密码失败"];
    }
}

#pragma mark - 网络请求

#pragma mark - 代理方法

#pragma mark - 其他
- (NSString*)generateKeyword{
    NSString *strKeyword = [NSString stringWithFormat:@"record_passwordItem%i",arc4random()/1000000];
    NSArray *arr = [Password searchPasswordWithKeyword:strKeyword];
    if (arr && arr.count > 0) {
        strKeyword = [self generateKeyword];
    }
    return strKeyword;
}

@end
