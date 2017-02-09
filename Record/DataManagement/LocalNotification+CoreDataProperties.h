//
//  LocalNotification+CoreDataProperties.h
//  Record
//
//  Created by fengdongsheng on 17/2/9.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "LocalNotification+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LocalNotification (CoreDataProperties)

+ (NSFetchRequest<LocalNotification *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *fireTime;
@property (nullable, nonatomic, copy) NSString *alertContent;
@property (nullable, nonatomic, copy) NSString *keyword;

@end

NS_ASSUME_NONNULL_END
