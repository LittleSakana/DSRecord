//
//  SportsItem+CoreDataProperties.h
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "SportsItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SportsItem (CoreDataProperties)

+ (NSFetchRequest<SportsItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *keyword;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
