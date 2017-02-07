//
//  LanguageRecordAddVC.h
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "BaseVC.h"
#import "Language+CoreDataClass.h"
#import "LanguageItem+CoreDataClass.h"

@interface LanguageRecordAddVC : BaseVC

@property (nonatomic, strong) Language          *languageRecord;
@property (nonatomic, strong) LanguageItem      *languageType;

@end
