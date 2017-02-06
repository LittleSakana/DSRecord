//
//  Sports+CoreDataProperties.h
//  Record
//
//  Created by fengdongsheng on 17/2/6.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Sports+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Sports (CoreDataProperties)

+ (NSFetchRequest<Sports *> *)fetchRequest;

@property (nonatomic) int16_t sports_count;
@property (nullable, nonatomic, copy) NSString *sports_keyword;
@property (nullable, nonatomic, copy) NSString *sports_name;
@property (nullable, nonatomic, copy) NSString *sports_time;

@end

NS_ASSUME_NONNULL_END
