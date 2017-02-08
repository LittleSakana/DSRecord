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
#import "SportsRecordListVC.h"
#import "SportsItem+CoreDataClass.h"
#import "RunRecordListVC.h"

@interface SportsVC ()

@property (nonatomic, strong) UISegmentedControl    *segDate;
@property (nonatomic, strong) UIScrollView          *scrollMain;
@property (nonatomic, strong) UILabel               *lblTime;
@property (nonatomic, strong) NSMutableArray        *arrData;
@property (nonatomic, strong) NSDate                *currentDate;
@property (nonatomic, copy  ) NSString              *strSearchTime;

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
    _segDate = [[UISegmentedControl alloc] initWithItems:@[@"天",@"月",@"年"]];
    self.segDate.frame = CGRectMake(50, 20, YYScreenSize().width - 100, 30);
    self.segDate.selectedSegmentIndex = 0;
    [self.segDate addTarget:self action:@selector(segmentedValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segDate];
    
    _lblTime = [UITools createLabelWithFrame:CGRectMake(0, self.segDate.bottom + 20, YYScreenSize().width, 40)
                                                text:self.strSearchTime
                                                font:[UIFont boldSystemFontOfSize:30]
                                           textColor:[UIColor colorWithHexString:Color_blue]
                                       textAlignment:NSTextAlignmentCenter
                                           SuperView:self.view];
    self.lblTime.userInteractionEnabled = YES;
    UIButton *btnLeft = [UITools createButtonWithFrame:CGRectMake(13, 0, 80, self.lblTime.height)
                                                    title:@""
                                                 setImage:@"leftArrow"
                                                 setBgImg:nil
                                                     font:nil
                                               titleColor:nil
                                          backgroundColor:[UIColor clearColor]
                                             SuperView:self.lblTime];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnLeft addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btnRight = [UITools createButtonWithFrame:CGRectMake(YYScreenSize().width - 13 - btnLeft.width, 0, btnLeft.width, self.lblTime.height)
                                                 title:@""
                                              setImage:@"rightArrow"
                                              setBgImg:nil
                                                  font:nil
                                            titleColor:nil
                                       backgroundColor:[UIColor clearColor]
                                             SuperView:self.lblTime];
    
    [btnRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btnRight addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //统计数据
    _scrollMain = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.lblTime.bottom, YYScreenSize().width, YYScreenSize().height - self.lblTime.bottom - 49 - 64)];
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
        NSArray *arrRecord = [Sports searchSportsWithKeyword:item.keyword andTime:self.strSearchTime];
        int64_t countAll = 0;
        for (Sports *sportRecord in arrRecord) {
            countAll += sportRecord.sports_count;
        }
        UIView *vBg = [UITools createViewWithFrame:CGRectMake(x, y, itemWidth, itemHeight)
                                   backgroundColor:[UIColor whiteColor]
                                         superView:self.scrollMain];
        vBg.tag = i;
        vBg.userInteractionEnabled = YES;
        __weak SportsVC *weakSelf = self;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if (arrRecord && arrRecord.count > 0) {
                SportsRecordListVC *vc = [SportsRecordListVC new];
                vc.keyword = item.keyword;
                vc.time = weakSelf.strSearchTime;
                vc.itemName = item.name;
                [weakSelf dsPushViewController:vc animated:YES];
            }else{
                SportsAddVC *vc = [SportsAddVC new];
                vc.sportsType = item;
                [weakSelf dsPushViewController:vc animated:YES];
            }
        }];
        [vBg addGestureRecognizer:tapGesture];
        
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
    self.scrollMain.contentSize = CGSizeMake(self.scrollMain.width, self.arrData.count%n > 0 ? y + itemHeight + padding : y);
}

#pragma mark - 初始化数据
- (void)initData{
    _arrData = [NSMutableArray array];
    self.currentDate = [NSDate date];
    self.strSearchTime = [R_Utils getShortStringDate:self.currentDate];
}

#pragma mark - 按钮点击事件

- (void)addSportRecord{
//    SportsAddVC *vcAdd = [SportsAddVC new];
//    [self dsPushViewController:vcAdd animated:YES];
    RunRecordListVC *vc = [RunRecordListVC new];
    vc.time = self.strSearchTime;
    [self dsPushViewController:vc animated:YES];
}

- (void)segmentedValueChanged:(UISegmentedControl*)segControl{
    [self calculateDateWithSegmentIndex:segControl.selectedSegmentIndex andIsAdd:0];
}

- (void)clickLeftBtn{
    [self calculateDateWithSegmentIndex:self.segDate.selectedSegmentIndex andIsAdd:-1];
    
}

- (void)clickRightBtn{
    [self calculateDateWithSegmentIndex:self.segDate.selectedSegmentIndex andIsAdd:1];
}

- (void)calculateDateWithSegmentIndex:(NSInteger)index andIsAdd:(int)symbolic{
    if ([self.currentDate timeIntervalSinceNow] > 0) {
        self.currentDate = [NSDate date];
    }
    if (index == 0) {
        if (symbolic > 0 && ![self.currentDate isToday]){
            self.currentDate = [self.currentDate dateByAddingDays:1];
        }else if (symbolic < 0){
            self.currentDate = [self.currentDate dateByAddingDays:-1];
        }
    }else if (index == 1) {
        if (symbolic > 0 && !(self.currentDate.year == [NSDate date].year && self.currentDate.month == [NSDate date].month)){
            self.currentDate = [self.currentDate dateByAddingMonths:1];
        }else if (symbolic < 0){
            self.currentDate = [self.currentDate dateByAddingMonths:-1];
        }
    }else if (index == 2) {
        if (symbolic > 0 && self.currentDate.year != [NSDate date].year){
            self.currentDate = [self.currentDate dateByAddingYears:1];
        }else if (symbolic < 0){
            self.currentDate = [self.currentDate dateByAddingYears:-1];
        }
    }
    
    self.strSearchTime = [R_Utils getShortStringDate:self.currentDate];
    if (index == 1) {
        self.strSearchTime = [self.strSearchTime substringToIndex:7];
    }else if (index == 2) {
        self.strSearchTime = [self.strSearchTime substringToIndex:4];
    }
    self.lblTime.text = self.strSearchTime;
    [self fetchData];
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
