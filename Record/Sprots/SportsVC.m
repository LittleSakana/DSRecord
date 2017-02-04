//
//  SportsVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "SportsVC.h"
#import "Sports+CoreDataClass.h"
#import <NSDate+YYAdd.h>

@interface SportsVC ()

@end

@implementation SportsVC

#pragma mark - VC生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Sports";
    
    [self initRightNavigationBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化页面

- (void)initRightNavigationBarItem{
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSportRecord)];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}

#pragma mark - 初始化数据

#pragma mark - 按钮点击事件

- (void)addSportRecord{
//    Sports *sport = [[Sports alloc] init];
//    sport.sports_count = 30;
//    sport.sports_keyword = @"Squats";
//    sport.sports_name = @"深蹲";
//    sport.sports_time = [[[NSDate date] stringWithISOFormat] substringToIndex:9];
    [Sports insertSports:nil];
}

#pragma mark - 网络请求

#pragma mark - 代理方法

#pragma mark - 其他

@end
