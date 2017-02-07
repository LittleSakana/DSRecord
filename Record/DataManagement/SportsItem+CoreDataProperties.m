//
//  SportsItem+CoreDataProperties.m
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "SportsItem+CoreDataProperties.h"

@implementation SportsItem (CoreDataProperties)

+ (NSFetchRequest<SportsItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SportsItem"];
}

@dynamic keyword;
@dynamic name;

@end
