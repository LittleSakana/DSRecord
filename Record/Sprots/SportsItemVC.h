//
//  SportsItemVC.h
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "BaseVC.h"
#import "SportsItem+CoreDataClass.h"

@protocol SportsItemDelegate <NSObject>

- (void)selectSportsItem:(SportsItem*)sportsItem;

@end

@interface SportsItemVC : BaseVC

@property (nonatomic, weak  ) id<SportsItemDelegate> delegate;

@end
