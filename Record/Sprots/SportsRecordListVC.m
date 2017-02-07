//
//  SportsRecordListVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/6.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "SportsRecordListVC.h"
#import "Sports+CoreDataClass.h"
#import "SportsAddVC.h"

@interface SportsRecordListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tbvMain;
@property (nonatomic, strong) NSMutableArray    *arrSource;

@end

@implementation SportsRecordListVC

#pragma mark - VC生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initPage];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreashData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化页面
- (void)initPage{
    self.navigationItem.title = [NSString stringWithFormat:@"%@记录",self.itemName];
    [self initRightNavigationBarItem];
        
    _tbvMain = [UITools createTableViewWithFrame:CGRectMake(0, 0, self.view.width, YYScreenSize().height - 64) style:UITableViewStylePlain delegate:self];
    self.tbvMain.backgroundColor = [UIColor clearColor];
    self.tbvMain.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tbvMain.delegate = self;
    self.tbvMain.dataSource = self;
    [R_Utils hideExtraCellLine:self.tbvMain];
    [self.view addSubview:self.tbvMain];
}

- (void)initRightNavigationBarItem{
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSportRecord)];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}

#pragma mark - 初始化数据
- (void)initData{
    _arrSource = [[NSMutableArray alloc] initWithCapacity:1];
}

- (void)refreashData{
    [self.arrSource removeAllObjects];
    [self.arrSource addObjectsFromArray:[Sports searchSportsWithKeyword:self.keyword andTime:self.time]];
    [self.tbvMain reloadData];
}

#pragma mark - 按钮点击事件

- (void)addSportRecord{
    SportsAddVC *vcAdd = [SportsAddVC new];
    vcAdd.sportsType = [SportsItem searchItemByWithKeyword:self.keyword];
    [self dsPushViewController:vcAdd animated:YES];
}

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
        Sports *item = [self.arrSource objectAtIndex:indexPath.row];
        cell.textLabel.text = item.sports_time;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%i",item.sports_count];
    }
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除该运动记录？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self deleteItemAtIndex:indexPath.row];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.arrSource.count) {
        Sports *item = [self.arrSource objectAtIndex:indexPath.row];
        SportsAddVC *vcAdd = [SportsAddVC new];
        vcAdd.sportsRecord = item;
        [self dsPushViewController:vcAdd animated:YES];
    }
}

#pragma mark - 其他
- (void)deleteItemAtIndex:(NSInteger)index{
    if (index < self.arrSource.count) {
        Sports *item = [self.arrSource objectAtIndex:index];
        BOOL flag = [Sports deleteObjectWithTime:item.sports_time andKeyword:item.sports_keyword];
        if (flag) {
            [self.arrSource removeObject:item];
            [self.tbvMain reloadData];
        }else{
            [self showMessage:@"删除运动项目失败"];
        }
    }
}

@end
