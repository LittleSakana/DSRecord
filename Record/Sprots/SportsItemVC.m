//
//  SportsItemVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "SportsItemVC.h"
#import "SportsItemAddVC.h"
#import "SportsItem+CoreDataClass.h"

@interface SportsItemVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tbvMain;
@property (nonatomic, strong) NSMutableArray    *arrSource;

@end

@implementation SportsItemVC

#pragma mark - VC生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreashData];
}

#pragma mark - 初始化页面
- (void)initPage{
    self.navigationItem.title = @"运动项目";
    
    [self initRightNavigationBarButtonItem];
    
    _tbvMain = [UITools createTableViewWithFrame:CGRectMake(0, 0, self.view.width, YYScreenSize().height - 64) style:UITableViewStylePlain delegate:self];
    self.tbvMain.backgroundColor = [UIColor clearColor];
    self.tbvMain.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tbvMain.delegate = self;
    self.tbvMain.dataSource = self;
    [R_Utils hideExtraCellLine:self.tbvMain];
    [self.view addSubview:self.tbvMain];
}

- (void)initRightNavigationBarButtonItem{
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSportItem)];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}

#pragma mark - 初始化数据
- (void)initData{
    _arrSource = [[NSMutableArray alloc] initWithCapacity:1];
}

- (void)refreashData{
    [self.arrSource removeAllObjects];
    [self.arrSource addObjectsFromArray:[SportsItem searchSportsWithKeyword:@""]];
    [self.tbvMain reloadData];
}

#pragma mark - 按钮点击事件
- (void)addSportItem{
    SportsItemAddVC *vcSportsItemAdd = [SportsItemAddVC new];
    [self.navigationController pushViewController:vcSportsItemAdd animated:YES];
}

#pragma mark - 网络请求

#pragma mark - 代理方法
#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"NormalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    if (indexPath.row < self.arrSource.count) {
        SportsItem *item = [self.arrSource objectAtIndex:indexPath.row];
        cell.textLabel.text = item.name;
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
    if (indexPath.row < self.arrSource.count) {
        SportsItem *item = [self.arrSource objectAtIndex:indexPath.row];
        if ([item.keyword isEqualToString:@"sportsItem4093"]) {
            return UITableViewCellEditingStyleNone;
        }
    }
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除该运动项目？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self deleteItemAtIndex:indexPath.row];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectSportsItem:)]) {
        if (indexPath.row < self.arrSource.count) {
            SportsItem *item = [self.arrSource objectAtIndex:indexPath.row];
            [self.delegate selectSportsItem:item];
            [self popVC];
        }
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    SportsItemAddVC *vcSportsItemAdd = [SportsItemAddVC new];
    if (indexPath.row < self.arrSource.count) {
        SportsItem *item = [self.arrSource objectAtIndex:indexPath.row];
        if ([item.keyword isEqualToString:@"sportsItem4093"]) {
            return;
        }
        vcSportsItemAdd.strKeyword = item.keyword;
    }
    [self dsPushViewController:vcSportsItemAdd animated:YES];
}

#pragma mark - 其他
- (void)deleteItemAtIndex:(NSInteger)index{
    if (index < self.arrSource.count) {
        SportsItem *item = [self.arrSource objectAtIndex:index];
        BOOL flag = [SportsItem deleteObjectKeyword:item.keyword];
        if (flag) {
            [self.arrSource removeObject:item];
            [self.tbvMain reloadData];
        }else{
            [self showMessage:@"删除运动项目失败"];
        }
    }
}
@end
