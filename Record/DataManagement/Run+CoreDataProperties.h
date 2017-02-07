//
//  Run+CoreDataProperties.h
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Run+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Run (CoreDataProperties)

+ (NSFetchRequest<Run *> *)fetchRequest;

@property (nonatomic) double run_distance;
@property (nullable, nonatomic, copy) NSString *run_time;
@property (nullable, nonatomic, copy) NSNumber *run_time_interval;

@end

NS_ASSUME_NONNULL_END
