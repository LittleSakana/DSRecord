//
//  DataManagement.h
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataManagement : NSObject

@property (nonatomic, strong) NSManagedObjectContext    *managedObjectContext;

+ (instancetype)sharedDataManagement;

@end
