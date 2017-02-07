//
//  Run+CoreDataProperties.m
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Run+CoreDataProperties.h"

@implementation Run (CoreDataProperties)

+ (NSFetchRequest<Run *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Run"];
}

@dynamic run_distance;
@dynamic run_time;
@dynamic run_time_interval;

@end
