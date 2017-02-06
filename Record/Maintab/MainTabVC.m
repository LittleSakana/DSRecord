//
//  MainTabVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "MainTabVC.h"
#import "HomeVC.h"
#import "SportsVC.h"
#import "ForeignLanguageVC.h"
#import "SettingVC.h"

@interface MainTabVC ()

@property (nonatomic, strong) HomeVC                *vcHome;
@property (nonatomic, strong) SportsVC              *vcSports;
@property (nonatomic, strong) ForeignLanguageVC     *vcForeignLanguage;
@property (nonatomic, strong) SettingVC             *vcSetting;

@end

@implementation MainTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initViewControllers{
    
    _vcHome = [[HomeVC alloc] init];
    UINavigationController *navigaitonHome = [[UINavigationController alloc] initWithRootViewController:_vcHome];
    navigaitonHome.tabBarItem.title = @"Home";
    navigaitonHome.tabBarItem.image = [UIImage imageNamed:@"home"];
    
    _vcSports = [[SportsVC alloc] init];
    UINavigationController *navigaitonSports = [[UINavigationController alloc] initWithRootViewController:_vcSports];
    navigaitonSports.tabBarItem.title = @"Sports";
    navigaitonSports.tabBarItem.image = [UIImage imageNamed:@"sports"];
    
    _vcForeignLanguage = [[ForeignLanguageVC alloc] init];
    UINavigationController *navigaitonForeignLanguage = [[UINavigationController alloc] initWithRootViewController:_vcForeignLanguage];
    navigaitonForeignLanguage.tabBarItem.title = @"Language";
    navigaitonForeignLanguage.tabBarItem.image = [UIImage imageNamed:@"language"];
    
    _vcSetting = [[SettingVC alloc] init];
    UINavigationController *navigaiton4 = [[UINavigationController alloc] initWithRootViewController:_vcSetting];
    navigaiton4.tabBarItem.title = @"Settings";
    navigaiton4.tabBarItem.image = [UIImage imageNamed:@"setting"];
    
    self.viewControllers = @[navigaitonHome,navigaitonSports,navigaitonForeignLanguage,navigaiton4];
}

@end
