//
//  HealthManagement.h
//  Record
//
//  Created by fengdongsheng on 17/2/8.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface HealthManagement : NSObject

@property (nonatomic, strong) HKHealthStore *healthStore;

+(id)shareInstance;

- (void)getStepCountWithDate:(NSDate*)date andCompletion:(void(^)(double value, NSError *error))completion;

- (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))compltion;
@end
