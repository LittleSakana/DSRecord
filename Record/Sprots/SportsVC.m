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
#import "SportsAddVC.h"
#import "SportsItem+CoreDataClass.h"

@interface SportsVC ()

@property (nonatomic, strong) UISegmentedControl    *segDate;
@property (nonatomic, strong) UIScrollView          *scrollMain;
@property (nonatomic, strong) NSMutableArray        *arrData;

@end

@implementation SportsVC

#pragma mark - VC生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Sports";
    
    [self initData];
    [self initPage];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化页面
- (void)initPage{
    [self initRightNavigationBarItem];
    
    //segment
    
    //统计数据
    _scrollMain = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollMain];
}

- (void)initRightNavigationBarItem{
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSportRecord)];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}

- (void)generateStatisticsPage{
    [self.scrollMain.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int n = 2;
    CGFloat padding = 20;
    CGFloat itemWidth = (self.scrollMain.width - padding*(n + 1))/n;
    CGFloat itemHeight = itemWidth;
    CGFloat x = padding;
    CGFloat y = padding;
    for (int i = 0; i < self.arrData.count; i++) {
        SportsItem *item = [self.arrData objectAtIndex:i];
        NSArray *arrRecord = [Sports searchSportsWithKeyword:item.keyword andTime:[R_Utils getShortStringDate:nil]];
        int64_t countAll = 0;
        for (Sports *sportRecord in arrRecord) {
            countAll += sportRecord.sports_count;
        }
        UIView *vBg = [UITools createViewWithFrame:CGRectMake(x, y, itemWidth, itemHeight)
                                   backgroundColor:[UIColor whiteColor]
                                         superView:self.scrollMain];
        
        if (x + itemWidth + padding >= self.scrollMain.width) {
            x = padding;
        }else{
            x = x + itemWidth + padding;
        }
        if ((i + 1)/n > 0 && (i + 1)%n == 0) {
            y = y + itemHeight + padding;
        }
        UILabel *lblCount = [UITools createLabelWithFrame:CGRectMake(0, 0, vBg.width, vBg.height - 40)
                                                     text:@""
                                                     font:[UIFont boldSystemFontOfSize:30]
                                                textColor:[UIColor colorWithHexString:Color_blue]
                                            textAlignment:NSTextAlignmentCenter
                                                SuperView:vBg];
        UILabel *lblName = [UITools createLabelWithFrame:CGRectMake(0, lblCount.bottom, vBg.width, 40)
                                                    text:@""
                                                    font:[UIFont systemFontOfSize:15]
                                               textColor:[UIColor colorWithHexString:@"333333"]
                                           textAlignment:NSTextAlignmentCenter
                                               SuperView:vBg];
        lblCount.text = [NSString stringWithFormat:@"%lld",countAll];
        lblName.text = item.name;
        [UITools createViewWithFrame:CGRectMake(0, lblCount.bottom, vBg.width, 1)
                     backgroundColor:[UIColor colorWithHexString:Color_devideLine]
                           superView:vBg];
    }
    self.scrollMain.contentSize = CGSizeMake(self.scrollMain.width, y);
}

#pragma mark - 初始化数据
- (void)initData{
    _arrData = [NSMutableArray array];
}

#pragma mark - 按钮点击事件

- (void)addSportRecord{
    SportsAddVC *vcAdd = [SportsAddVC new];
    [self dsPushViewController:vcAdd animated:YES];
}

#pragma mark - 网络请求
- (void)fetchData{
    [self.arrData removeAllObjects];
    [self.arrData addObjectsFromArray:[SportsItem searchSportsWithKeyword:nil]];
    [self generateStatisticsPage];
}

#pragma mark - 代理方法

#pragma mark - 其他

@end
