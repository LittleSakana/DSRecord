//
//  AddLocalNotificationVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/9.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "AddLocalNotificationVC.h"

@interface AddLocalNotificationVC ()

@property (nonatomic, strong) UILabel       *lblTime;
@property (nonatomic, strong) UITextField   *tfContent;
@property (nonatomic, strong) UIButton      *btnAdd;
@property (nonatomic, copy  ) NSString      *strAlertTime;

//日期选择
@property (nonatomic, strong) UIView        *vDatePickerBg;
@property (nonatomic, strong) UIDatePicker  *datePicker;

@end

@implementation AddLocalNotificationVC

#pragma mark - VC生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化页面
- (void)initPage{
    self.navigationItem.title = @"提醒";
    
    UIView *vBg = [UITools createViewWithFrame:CGRectMake(10, 30, YYScreenSize().width - 20, 100) backgroundColor:[UIColor whiteColor] superView:self.view];
    vBg.userInteractionEnabled = YES;
    
    
    UILabel *lblTimeTitle = [UITools createLabelWithFrame:CGRectMake(10, 0, 80, 50)
                                                     text:@"提醒时间"
                                                     font:[UIFont systemFontOfSize:15]
                                                textColor:[UIColor colorWithHexString:@"333333"]
                                            textAlignment:NSTextAlignmentLeft
                                                SuperView:vBg];
    _lblTime = [UITools createLabelWithFrame:CGRectMake(lblTimeTitle.right, lblTimeTitle.top, vBg.width - lblTimeTitle.width - 20, lblTimeTitle.height)
                                        text:[NSString stringWithFormat:@"%@ >",self.strAlertTime]
                                        font:[UIFont systemFontOfSize:15]
                                   textColor:[UIColor colorWithHexString:@"666666"]
                               textAlignment:NSTextAlignmentRight
                                   SuperView:vBg];
    if (!self.localNotification) {
        __weak AddLocalNotificationVC *weakSelf1 = self;
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [weakSelf1 showDatePicker];
        }];
        self.lblTime.userInteractionEnabled = YES;
        [self.lblTime addGestureRecognizer:tapGesture1];
    }
    CGRect rectSeparateLine1 = CGRectMake(0, lblTimeTitle.bottom, vBg.width, 1);
    [UITools createViewWithFrame:rectSeparateLine1
                 backgroundColor:[UIColor colorWithHexString:@"f5f5f5"]
                       superView:vBg];
    
    UILabel *lblDistanceTitle = [UITools createLabelWithFrame:CGRectMake(lblTimeTitle.left, lblTimeTitle.bottom, lblTimeTitle.width, lblTimeTitle.height)
                                                         text:@"内容"
                                                         font:[UIFont systemFontOfSize:15]
                                                    textColor:[UIColor colorWithHexString:@"333333"]
                                                textAlignment:NSTextAlignmentLeft
                                                    SuperView:vBg];
    _tfContent = [[UITextField alloc] init];
    self.tfContent.placeholder = @"小主，您该锻炼了！";
    self.tfContent.frame = CGRectMake(lblDistanceTitle.right, lblDistanceTitle.top, self.lblTime.width, lblDistanceTitle.height);
    self.tfContent.textColor = [UIColor colorWithHexString:@"666666"];
    self.tfContent.keyboardType = UIKeyboardTypeDefault;
    self.tfContent.font = [UIFont systemFontOfSize:15];
    self.tfContent.textAlignment = NSTextAlignmentRight;
    self.tfContent.rightViewMode = UITextFieldViewModeAlways;
    self.tfContent.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [vBg addSubview:self.tfContent];
    
    _btnAdd = [UITools createButtonWithFrame:CGRectMake(20, vBg.bottom + 30, YYScreenSize().width - 40, 45)
                                       title:@"保存"
                                    setImage:nil
                                    setBgImg:nil
                                        font:[UIFont systemFontOfSize:18]
                                  titleColor:[UIColor whiteColor]
                             backgroundColor:[UIColor colorWithHexString:Color_blue]
                                   SuperView:self.view];
    self.btnAdd.layer.masksToBounds = YES;
    self.btnAdd.layer.cornerRadius = 3;
    [self.btnAdd addTarget:self action:@selector(clickBtnAdd) forControlEvents:UIControlEventTouchUpInside];
    
    //如果传入有记录，则表示修改，不允许修改记录类型和时间
    if (self.localNotification) {
        self.lblTime.text = [NSString stringWithFormat:@"%@ >",self.localNotification.fireTime];
        self.tfContent.text = self.localNotification.alertContent;
    }else{
        self.tfContent.text = @"小主，您该锻炼了";
    }
    
    [self initPickerView];
}

- (void)initPickerView{
    if (!self.datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        self.datePicker.datePickerMode = UIDatePickerModeTime;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
        self.datePicker.locale = locale;
        self.datePicker.top = 44;
        self.datePicker.centerX = YYScreenSize().width/2;
    }
    if (!self.vDatePickerBg) {
        _vDatePickerBg = [UITools createViewWithFrame:CGRectMake(0, YYScreenSize().height, YYScreenSize().width, self.datePicker.height + 44)
                                      backgroundColor:[UIColor whiteColor]
                                            superView:[UIApplication sharedApplication].keyWindow];
        [self.vDatePickerBg addSubview:self.datePicker];
        
        UIButton *btnCancel = [UITools createButtonWithFrame:CGRectMake(10, 0, self.vDatePickerBg.width/2 - 10, 44)
                                                       title:@"Cancel"
                                                    setImage:nil
                                                    setBgImg:nil
                                                        font:[UIFont systemFontOfSize:16]
                                                  titleColor:[UIColor colorWithHexString:Color_blue]
                                             backgroundColor:[UIColor clearColor]
                                                   SuperView:self.vDatePickerBg];
        [btnCancel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btnCancel addTarget:self action:@selector(hideDatePicker) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnConfirm = [UITools createButtonWithFrame:CGRectMake(btnCancel.right, 0, btnCancel.width, btnCancel.height)
                                                        title:@"OK"
                                                     setImage:nil
                                                     setBgImg:nil
                                                         font:[UIFont systemFontOfSize:16]
                                                   titleColor:[UIColor colorWithHexString:Color_blue]
                                              backgroundColor:[UIColor clearColor]
                                                    SuperView:self.vDatePickerBg];
        [btnConfirm setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [btnConfirm addTarget:self action:@selector(clickBtnOK) forControlEvents:UIControlEventTouchUpInside];
        
        [UITools createViewWithFrame:CGRectMake(0, 44, self.vDatePickerBg.width, 0.5) backgroundColor:[UIColor colorWithHexString:@"F5F5F5"] superView:self.vDatePickerBg];
    }
}

#pragma mark - 初始化数据
- (void)initData{
    if (self.localNotification) {
        self.strAlertTime = self.localNotification.fireTime;
    }else{
        self.strAlertTime = [R_Utils getShortStringTime:nil];
    }
}

#pragma mark - 按钮点击事件
- (void)clickBtnAdd{
    [self hideDatePicker];
    [self.view endEditing:YES];
    if (!self.strAlertTime || [self.strAlertTime stringByTrim].length == 0) {
        [self showMessage:@"请选择提醒时间"];
        return;
    }
    if ([self.tfContent.text stringByTrim].length == 0) {
        [self showMessage:@"请填提醒内容"];
        return;
    }
    NSString *strKeyword;
    if (self.localNotification) {
        strKeyword = self.localNotification.keyword;
    }else{
        strKeyword = [self generateKeyword];
    }
    BOOL flag = [LocalNotification addObjectWithKeyword:[self generateKeyword] andTime:self.strAlertTime andContent:[self.tfContent.text stringByTrim]];
    if (flag) {
        [self showMessage:@"保存提醒成功"];
        if (self.localNotification) {
            [LocalNotification cancelNotification:self.localNotification];
        }
        UILocalNotification *localNotifi = [UILocalNotification new];
        localNotifi.fireDate = [NSDate dateWithString:[[R_Utils getShortStringDate:nil] stringByAppendingFormat:@" %@",self.strAlertTime]
                                               format:@"yyyy-MM-dd HH:mm"];
        localNotifi.repeatInterval = kCFCalendarUnitDay;
        localNotifi.alertTitle = @"Record";
        localNotifi.alertBody = [self.tfContent.text stringByTrim];
        localNotifi.applicationIconBadgeNumber = 1;
        localNotifi.userInfo = @{@"keyword":strKeyword};
        [self performSelector:@selector(popVC) withObject:nil afterDelay:1.5];
    }else{
        [self showMessage:@"保存提醒失败"];
    }
}

- (void)showDatePicker{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.vDatePickerBg.bottom = YYScreenSize().height;
    }];
}

- (void)hideDatePicker{
    [UIView animateWithDuration:0.3 animations:^{
        self.vDatePickerBg.bottom = YYScreenSize().height + self.vDatePickerBg.height;
    }];
}

- (void)clickBtnOK{
    [self hideDatePicker];
    self.strAlertTime = [R_Utils getShortStringTime:self.datePicker.date];
    self.lblTime.text = [NSString stringWithFormat:@"%@ >",self.strAlertTime];
}

#pragma mark - 网络请求

#pragma mark - 代理方法

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self hideDatePicker];
}

#pragma mark - 其他
- (NSString*)generateKeyword{
    NSString *strKeyword = [NSString stringWithFormat:@"localNotification%i",arc4random()/1000000];
    NSArray *arr = [LocalNotification searchLocalNotificationWithKeyword:strKeyword];
    if (arr && arr.count > 0) {
        strKeyword = [self generateKeyword];
    }
    return strKeyword;
}

@end
