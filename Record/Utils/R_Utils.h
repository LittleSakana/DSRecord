//
//  R_Utils.h
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R_Utils : NSObject

+ (NSString*)getShortStringDate:(NSDate*)date;

+ (NSString*)getShortStringTime:(NSDate*)date;

+ (void)hideExtraCellLine:(UITableView *)tableView;

@end
