//
//  R_Utils.m
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "R_Utils.h"
#import <NSDate+YYAdd.h>

@implementation R_Utils

+ (NSString*)getShortStringDate:(NSDate*)date{
    if (!date) {
        date = [NSDate date];
    }
    return [[date stringWithISOFormat] substringToIndex:10];
}

+ (void)hideExtraCellLine:(UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
