//
//  R_Utils.m
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "R_Utils.h"
#import <NSDate+YYAdd.h>
#import <LocalAuthentication/LocalAuthentication.h>

@implementation R_Utils

+ (NSString*)getShortStringDate:(NSDate*)date{
    if (!date) {
        date = [NSDate date];
    }
    return [[date stringWithISOFormat] substringToIndex:10];
}

+ (NSString*)getShortStringTime:(NSDate*)date{
    if (!date) {
        date = [NSDate date];
    }
    return [[date stringWithISOFormat] substringWithRange:NSMakeRange(11, 5)];
}

+ (void)hideExtraCellLine:(UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (void)fingerprintAuthenticate:(void(^)(BOOL isSuccess,NSString *msg))completion{
    //创建LAContext
    LAContext *context = [LAContext new];
    
    //这个属性是设置指纹输入失败之后的弹出框的选项
//    context.localizedFallbackTitle = @"请先去设置中心添加指纹";
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"必须通过指纹验证才能使用密码管理功能" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功 刷新主界面");
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completion(YES,@"验证成功");
                }];
            }else{
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                        case LAErrorSystemCancel:
                    {
                        NSLog(@"系统取消授权，如其他APP切入");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            completion(NO,@"系统取消授权");
                        }];
                        break;
                    }
                        case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            completion(NO,@"您取消了验证Touch ID");
                        }];
                        break;
                    }
                        case LAErrorAuthenticationFailed:
                    {
                        NSLog(@"授权失败");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            completion(NO,@"授权失败");
                        }];
                        break;
                    }
                        case LAErrorPasscodeNotSet:
                    {
                        NSLog(@"系统未设置密码");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            completion(NO,@"系统未设置密码");
                        }];
                        break;
                    }
                        case LAErrorTouchIDNotAvailable:
                    {
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            completion(NO,@"设备Touch ID不可用");
                        }];
                        break;
                    }
                        case LAErrorTouchIDNotEnrolled:
                    {
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            completion(NO,@"设备Touch ID不可用");
                        }];
                        break;
                    }
                        case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理");
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                            completion(NO,@"设备Touch ID使用异常");
                        }];
                        break;
                    }
                }
            }
        }];
    }else{
        NSLog(@"不支持指纹识别");
        switch (error.code) {
                case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completion(NO,@"TouchID 没有注册");
                }];
                break;
            }
                case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completion(NO,@"TouchID 不可用");
                }];
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}

@end
