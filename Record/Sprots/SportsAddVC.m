//
//  SportsAddVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "SportsAddVC.h"
#import "SportsItemVC.h"

@interface SportsAddVC ()

@property (nonatomic, strong) UIButton      *btnAdd;

@end

@implementation SportsAddVC

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
    self.navigationItem.title = @"添加运动记录";
    _btnAdd = [UITools createButtonWithFrame:CGRectMake(40, 60 + 20, YYScreenSize().width - 80, 30)
                                       title:@"添加"
                                    setImage:nil
                                    setBgImg:nil
                                        font:[UIFont systemFontOfSize:18]
                                  titleColor:[UIColor whiteColor]
                             backgroundColor:[UIColor colorWithHexString:@"007aff"]
                                   SuperView:self.view];
    self.btnAdd.layer.masksToBounds = YES;
    self.btnAdd.layer.cornerRadius = 3;
    [self.btnAdd addTarget:self action:@selector(clickBtnAdd) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 初始化数据

#pragma mark - 按钮点击事件
- (void)clickBtnAdd{
    SportsItemVC *vcSportsItem = [SportsItemVC new];
    [self dsPushViewController:vcSportsItem animated:YES];
}

#pragma mark - 网络请求

#pragma mark - 代理方法

#pragma mark - 其他

@end
