//
//  SportsAddVC.m
//  Record
//
//  Created by fengdongsheng on 17/2/4.
//  Copyright © 2017年 fengdongsheng. All rights reserved.
//

#import "SportsAddVC.h"
#import "SportsItemVC.h"

@interface SportsAddVC ()<SportsItemDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UILabel       *lblType;
@property (nonatomic, strong) UILabel       *lblTime;
@property (nonatomic, strong) UITextField   *tfCount;
@property (nonatomic, strong) UIButton      *btnAdd;

@property (nonatomic, copy  ) NSString      *strSportsTime;

//日期选择
@property (nonatomic, strong) UIView        *vDatePickerBg;
@property (nonatomic, strong) UIDatePicker  *datePicker;

@end

@implementation SportsAddVC

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
    self.navigationItem.title = @"添加运动记录";
    
    UIView *vBg = [UITools createViewWithFrame:CGRectMake(10, 30, YYScreenSize().width - 20, 150) backgroundColor:[UIColor whiteColor] superView:self.view];
    vBg.userInteractionEnabled = YES;
    
    UILabel *lblTypeTitle = [UITools createLabelWithFrame:CGRectMake(10, 0, 80, 50)
                                                     text:@"运动项目"
                                                     font:[UIFont systemFontOfSize:15]
                                                textColor:[UIColor colorWithHexString:@"333333"]
                                            textAlignment:NSTextAlignmentLeft
                                                SuperView:vBg];
    _lblType = [UITools createLabelWithFrame:CGRectMake(lblTypeTitle.right, lblTypeTitle.top, vBg.width - lblTypeTitle.width - 20, lblTypeTitle.height)
                                        text:@"请选择运动项目 >"
                                        font:[UIFont systemFontOfSize:15]
                                   textColor:[UIColor colorWithHexString:@"666666"]
                               textAlignment:NSTextAlignmentRight
                                   SuperView:vBg];
    if (!self.sportsRecord && !self.sportsType) {
        __weak SportsAddVC *weakSelf = self;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            SportsItemVC *vcSportsItem = [SportsItemVC new];
            vcSportsItem.delegate = weakSelf;
            [weakSelf dsPushViewController:vcSportsItem animated:YES];
        }];
        self.lblType.userInteractionEnabled = YES;
        [self.lblType addGestureRecognizer:tapGesture];
    }
    CGRect rectSeparateLine = CGRectMake(0, lblTypeTitle.bottom, vBg.width, 1);
    [UITools createViewWithFrame:rectSeparateLine
                 backgroundColor:[UIColor colorWithHexString:@"f5f5f5"]
                       superView:vBg];
    
    UILabel *lblTimeTitle = [UITools createLabelWithFrame:CGRectMake(lblTypeTitle.left, lblTypeTitle.bottom, lblTypeTitle.width, lblTypeTitle.height)
                                                     text:@"运动日期"
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
    if (!self.sportsRecord) {
        __weak SportsAddVC *weakSelf1 = self;
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
    
    UILabel *lblCountTitle = [UITools createLabelWithFrame:CGRectMake(lblTypeTitle.left, lblTimeTitle.bottom, lblTypeTitle.width, lblTypeTitle.height)
                                                     text:@"数目(个)"
                                                     font:[UIFont systemFontOfSize:15]
                                                textColor:[UIColor colorWithHexString:@"333333"]
                                            textAlignment:NSTextAlignmentLeft
                                                SuperView:vBg];
    _tfCount = [[UITextField alloc] init];
    self.tfCount.placeholder = @"请输入个数";
    self.tfCount.frame = CGRectMake(lblCountTitle.right, lblCountTitle.top, self.lblTime.width, lblCountTitle.height);
    self.tfCount.textColor = [UIColor colorWithHexString:@"666666"];
    self.tfCount.keyboardType = UIKeyboardTypeNumberPad;
    self.tfCount.font = [UIFont systemFontOfSize:15];
    self.tfCount.textAlignment = NSTextAlignmentRight;
    self.tfCount.rightViewMode = UITextFieldViewModeAlways;
    self.tfCount.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [vBg addSubview:self.tfCount];
    
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
    if (self.sportsRecord) {
        self.lblType.text = [NSString stringWithFormat:@"%@ >",self.sportsRecord.sports_name];
        self.tfCount.text = [NSString stringWithFormat:@"%i",self.sportsRecord.sports_count];
    }else if (self.sportsType) {
        self.lblType.text = [NSString stringWithFormat:@"%@ >",self.sportsType.name];
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
    if (self.sportsRecord) {
        self.strSportsTime = self.sportsRecord.sports_time;
    }else{
        self.strSportsTime = [R_Utils getShortStringDate:nil];
    }
}

#pragma mark - 按钮点击事件
- (void)clickBtnAdd{
    [self hideDatePicker];
    [self.view endEditing:YES];
    if (!self.sportsType && !self.sportsRecord) {
        [self showMessage:@"请选择运动项目"];
        return;
    }
    if (!self.strSportsTime || [self.strSportsTime stringByTrim].length == 0) {
        [self showMessage:@"请选择运动日期"];
        return;
    }
    if ([self.tfCount.text stringByTrim].length == 0 || [self.tfCount.text intValue] == 0) {
        [self showMessage:@"请填写个数"];
        return;
    }
    NSString *strKeyword = @"";
    if (self.sportsRecord) {
        strKeyword = self.sportsRecord.sports_keyword;
    }else{
        strKeyword = self.sportsType.keyword;
    }
    BOOL flag = [Sports addObjectWithTime:self.strSportsTime andKeyword:strKeyword andCount:[self.tfCount.text intValue]];
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
- (void)selectSportsItem:(SportsItem *)sportsItem{
    self.sportsType = sportsItem;
    self.lblType.text = [NSString stringWithFormat:@"%@ >",sportsItem.name];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self hideDatePicker];
}

#pragma mark - 其他

@end
