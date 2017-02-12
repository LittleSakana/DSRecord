//
//  PasswordListVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/11.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "PasswordListVC.h"
#import "PasswordAddVC.h"
#import "Password+CoreDataClass.h"
#import <SFHFKeychainUtils.h>

@interface PasswordListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tbvMain;
@property (nonatomic, strong) NSMutableArray    *arrSource;

@end

@implementation PasswordListVC

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
    self.navigationItem.title = @"Password";
    
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
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addLanguageRecord)];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}

#pragma mark - 初始化数据
- (void)initData{
    _arrSource = [[NSMutableArray alloc] initWithCapacity:1];
}

- (void)refreashData{
    [self.arrSource removeAllObjects];
    [self.arrSource addObjectsFromArray:[Password searchPasswordWithKeyword:@""]];
    [self.tbvMain reloadData];
}

#pragma mark - 按钮点击事件
- (void)addLanguageRecord{
    [R_Utils fingerprintAuthenticate:^(BOOL isSuccess, NSString *msg) {
        if (isSuccess) {
            PasswordAddVC *vcAdd = [PasswordAddVC new];
            [self dsPushViewController:vcAdd animated:YES];
        }else{
            [self showMessage:msg];
        }
    }];
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
        Password *item = [self.arrSource objectAtIndex:indexPath.row];
        cell.textLabel.text = item.detailDes;
        cell.detailTextLabel.text = item.account;
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
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除该密码？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self deleteItemAtIndex:indexPath.row];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [R_Utils fingerprintAuthenticate:^(BOOL isSuccess, NSString *msg) {
        if (!isSuccess) {
            [self showMessage:msg];
            return;
        }
        if (indexPath.row < self.arrSource.count) {
            Password *item = [self.arrSource objectAtIndex:indexPath.row];
            PasswordAddVC *vcAdd = [PasswordAddVC new];
            vcAdd.password = item;
            [self dsPushViewController:vcAdd animated:YES];
        }
    }];
}

#pragma mark - 其他
- (void)deleteItemAtIndex:(NSInteger)index{
    [R_Utils fingerprintAuthenticate:^(BOOL isSuccess, NSString *msg) {
        if (isSuccess) {
            if (index < self.arrSource.count) {
                NSError *error;
                Password *item = [self.arrSource objectAtIndex:index];
                [SFHFKeychainUtils deleteItemForUsername:item.keyword andServiceName:Record_Service error:&error];
                BOOL flag = [Password deleteObjectKeyword:item.keyword];
                if (flag && !error) {
                    [self.arrSource removeObject:item];
                    [self.tbvMain reloadData];
                }else{
                    [self showMessage:@"删除密码失败"];
                }
            }
        }else{
            [self showMessage:msg];
        }
    }];
}

@end
