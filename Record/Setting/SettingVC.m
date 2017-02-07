//
//  SettingVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/6.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "SettingVC.h"
#import "SportsItemVC.h"
#import "LanguageItemListVC.h"

@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tbvMain;
@property (nonatomic, strong) NSMutableArray    *arrSource;

@end

@implementation SettingVC

#pragma mark - VC生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化页面
- (void)initPage{
    self.navigationItem.title = @"Settings";
    
    _tbvMain = [UITools createTableViewWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain delegate:self];
    self.tbvMain.backgroundColor = [UIColor clearColor];
    self.tbvMain.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tbvMain.delegate = self;
    self.tbvMain.dataSource = self;
    [R_Utils hideExtraCellLine:self.tbvMain];
    [self.view addSubview:self.tbvMain];
}

#pragma mark - 初始化数据
- (void)initData{
    _arrSource = [[NSMutableArray alloc] initWithCapacity:1];
    [self.arrSource addObject:@{@"name":@"Sports",@"value":@"sports"}];
    [self.arrSource addObject:@{@"name":@"Language",@"value":@"language"}];
}

#pragma mark - 按钮点击事件

#pragma mark - 网络请求

#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"NormalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row < self.arrSource.count) {
        NSDictionary *item = [self.arrSource objectAtIndex:indexPath.row];
        cell.textLabel.text = item[@"name"];
    }
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.arrSource.count) {
        NSDictionary *item = [self.arrSource objectAtIndex:indexPath.row];
        if ([item[@"value"] isEqualToString:@"sports"]) {
            SportsItemVC *vc = [SportsItemVC new];
            [self dsPushViewController:vc animated:YES];
        }else if ([item[@"value"] isEqualToString:@"language"]) {
            LanguageItemListVC *vc = [LanguageItemListVC new];
            [self dsPushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 其他

@end
