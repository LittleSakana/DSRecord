//
//  SportsAddVC.h
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "BaseVC.h"
#import "Sports+CoreDataClass.h"
#import "SportsItem+CoreDataClass.h"

@interface SportsAddVC : BaseVC

@property (nonatomic, strong) Sports        *sportsRecord;
@property (nonatomic, strong) SportsItem    *sportsType;

@end
