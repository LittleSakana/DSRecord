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

@interface MainTabVC ()

@property (nonatomic, strong) HomeVC                *vcHome;
@property (nonatomic, strong) SportsVC              *vcSports;
@property (nonatomic, strong) ForeignLanguageVC     *vcForeignLanguage;

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
    navigaitonHome.tabBarItem.title = @"首页";
    
    _vcSports = [[SportsVC alloc] init];
    UINavigationController *navigaitonSports = [[UINavigationController alloc] initWithRootViewController:_vcSports];
    navigaitonSports.tabBarItem.title = @"运动";
    
    _vcForeignLanguage = [[ForeignLanguageVC alloc] init];
    UINavigationController *navigaitonForeignLanguage = [[UINavigationController alloc] initWithRootViewController:_vcForeignLanguage];
    navigaitonForeignLanguage.tabBarItem.title = @"外语";
    
    self.viewControllers = @[navigaitonHome,navigaitonSports,navigaitonForeignLanguage];
}

@end
