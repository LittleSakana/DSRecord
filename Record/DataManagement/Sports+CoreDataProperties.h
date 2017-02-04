//
//  Sports+CoreDataProperties.h
//  Record
//
//  Created by fengdongsheng on 17/2/3.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "Sports+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Sports (CoreDataProperties)

+ (NSFetchRequest<Sports *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *sports_time;
@property (nonatomic) int16_t sports_count;
@property (nullable, nonatomic, copy) NSString *sports_name;
@property (nullable, nonatomic, copy) NSString *sports_keyword;

@end

NS_ASSUME_NONNULL_END
