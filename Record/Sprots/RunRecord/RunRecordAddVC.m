//
//  RunRecordAddVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/7.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "RunRecordAddVC.h"

@interface RunRecordAddVC ()

@property (nonatomic, strong) UILabel       *lblTime;
@property (nonatomic, strong) UITextField   *tfTimeinterval;
@property (nonatomic, strong) UITextField   *tfDistance;
@property (nonatomic, strong) UIButton      *btnAdd;
@property (nonatomic, copy  ) NSString      *strSportsTime;

//日期选择
@property (nonatomic, strong) UIView        *vDatePickerBg;
@property (nonatomic, strong) UIDatePicker  *datePicker;

@end

@implementation RunRecordAddVC

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
    self.navigationItem.title = @"跑步记录";
    
    UIView *vBg = [UITools createViewWithFrame:CGRectMake(10, 30, YYScreenSize().width - 20, 150) backgroundColor:[UIColor whiteColor] superView:self.view];
    vBg.userInteractionEnabled = YES;
    
    
    UILabel *lblTimeTitle = [UITools createLabelWithFrame:CGRectMake(10, 0, 80, 50)
                                                     text:@"跑步日期"
                                                     font:[UIFont systemFontOfSize:15]
                                                textColor:[UIColor colorWithHexString:@"333333"]
                                            textAlignment:NSTextAlignmentLeft
                                                SuperView:vBg];
    _lblTime = [UITools createLabelWithFrame:CGRectMake(lblTimeTitle.right, lblTimeTitle.top, vBg.width - lblTimeTitle.width - 20, lblTimeTitle.height)
                                        text:[NSString stringWithFormat:@"%@ >",self.strSportsTime]
                                        font:[UIFont systemFontOfSize:15]
                                   textColor:[UIColor colorWithHexString:@"666666"]
                               textAlignment:NSTextAlignmentRight
                                   SuperView:vBg];
    if (!self.runRecord) {
        __weak RunRecordAddVC *weakSelf1 = self;
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
                                                      text:@"距离(KM)"
                                                      font:[UIFont systemFontOfSize:15]
                                                 textColor:[UIColor colorWithHexString:@"333333"]
                                             textAlignment:NSTextAlignmentLeft
                                                 SuperView:vBg];
    _tfDistance = [[UITextField alloc] init];
    self.tfDistance.placeholder = @"请输入跑步距离";
    self.tfDistance.frame = CGRectMake(lblDistanceTitle.right, lblDistanceTitle.top, self.lblTime.width, lblDistanceTitle.height);
    self.tfDistance.textColor = [UIColor colorWithHexString:@"666666"];
    self.tfDistance.keyboardType = UIKeyboardTypeNumberPad;
    self.tfDistance.font = [UIFont systemFontOfSize:15];
    self.tfDistance.textAlignment = NSTextAlignmentRight;
    self.tfDistance.rightViewMode = UITextFieldViewModeAlways;
    self.tfDistance.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [vBg addSubview:self.tfDistance];
    CGRect rectSeparateLine2 = CGRectMake(0, lblDistanceTitle.bottom, vBg.width, 1);
    [UITools createViewWithFrame:rectSeparateLine2
                 backgroundColor:[UIColor colorWithHexString:@"f5f5f5"]
                       superView:vBg];
    
    UILabel *lblTimeintervalTitle = [UITools createLabelWithFrame:CGRectMake(lblDistanceTitle.left, lblDistanceTitle.bottom, lblDistanceTitle.width, lblDistanceTitle.height)
                                                         text:@"时长(分钟)"
                                                         font:[UIFont systemFontOfSize:15]
                                                    textColor:[UIColor colorWithHexString:@"333333"]
                                                textAlignment:NSTextAlignmentLeft
                                                    SuperView:vBg];
    _tfTimeinterval = [[UITextField alloc] init];
    self.tfTimeinterval.placeholder = @"请输入跑步时长";
    self.tfTimeinterval.frame = CGRectMake(lblTimeintervalTitle.right, lblTimeintervalTitle.top, self.lblTime.width, lblTimeintervalTitle.height);
    self.tfTimeinterval.textColor = [UIColor colorWithHexString:@"666666"];
    self.tfTimeinterval.keyboardType = UIKeyboardTypeNumberPad;
    self.tfTimeinterval.font = [UIFont systemFontOfSize:15];
    self.tfTimeinterval.textAlignment = NSTextAlignmentRight;
    self.tfTimeinterval.rightViewMode = UITextFieldViewModeAlways;
    self.tfTimeinterval.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [vBg addSubview:self.tfTimeinterval];
    
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
    if (self.runRecord) {
        self.lblTime.text = [NSString stringWithFormat:@"%@ >",self.runRecord.run_time];
        self.tfDistance.text = [NSString stringWithFormat:@"%.2f",self.runRecord.run_distance];
        self.tfTimeinterval.text = [NSString stringWithFormat:@"%@",self.runRecord.run_time_interval];
    }
    
    [self initPickerView];
}

- (void)initPickerView{
    if (!self.datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        self.datePicker.maximumDate = [NSDate date];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
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
    if (self.runRecord) {
        self.strSportsTime = self.runRecord.run_time;
    }else{
        self.strSportsTime = [R_Utils getShortStringDate:nil];
    }
}

#pragma mark - 按钮点击事件
- (void)clickBtnAdd{
    [self hideDatePicker];
    [self.view endEditing:YES];
    if (!self.strSportsTime || [self.strSportsTime stringByTrim].length == 0) {
        [self showMessage:@"请选择跑步日期"];
        return;
    }
    if ([self.tfDistance.text stringByTrim].length == 0 || [self.tfDistance.text floatValue] <= 0) {
        [self showMessage:@"请填写跑步距离"];
        return;
    }
    if ([self.tfTimeinterval.text stringByTrim].length == 0 || [self.tfTimeinterval.text integerValue] <= 0) {
        [self showMessage:@"请填写跑步时长"];
        return;
    }
    
    BOOL flag = [Run addObjectWithTime:self.strSportsTime andTimeInterval:[NSNumber numberWithString:self.tfTimeinterval.text] andDistance:[self.tfDistance.text floatValue]];
    if (flag) {
        [self showMessage:@"保存运动记录成功"];
        [self performSelector:@selector(popVC) withObject:nil afterDelay:1.5];
    }else{
        [self showMessage:@"保存运动记录失败"];
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
    self.strSportsTime = [R_Utils getShortStringDate:self.datePicker.date];
    self.lblTime.text = [NSString stringWithFormat:@"%@ >",self.strSportsTime];
}

#pragma mark - 网络请求

#pragma mark - 代理方法

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self hideDatePicker];
}

#pragma mark - 其他

@end
