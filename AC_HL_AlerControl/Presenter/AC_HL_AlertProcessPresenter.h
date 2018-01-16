//
//  AC_HL_AlertProcessPresenter.h
//  caiqr
//
//  Created by 洪利 on 2017/7/31.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AC_HL_AlertInfoViewModel.h"
@interface AC_HL_AlertProcessPresenter : NSObject

//占位model 提供占位识别符，当真正model创建完成后用于销毁占位model
+ (void)loadNonInfoAlertView:(id)keyWords;

+ (void)removeNonAlertInfo:(id)keyWords;


//只提供alertView 其余属性均为默认设置
+ (void)loadAlertView:(id)alertView;

//提供 alertView 和 优先级
+ (void)loadAlertView:(id)alertView
               option:(AC_HL_AlertViewDisPlayedOption)options;

//提供 alertView 和 superView
+ (void)loadAlertView:(id)alertView
            superView:(id)superView;

//提供所有配置信息
+ (void)loadAlertView:(id)alertView
            superView:(id)superView
               option:(AC_HL_AlertViewDisPlayedOption)options;
//特定VC下展示
+ (void)loadAlertView:(id)alertView
             targetVC:(NSString *)targetVCName;

+ (void)loadAlertView:(id)alertView
            superView:(id)superView
             targetVC:(NSString *)targetVCName;

+ (void)loadAlertView:(id)alertView
            superView:(id)superView
             targetVC:(NSString *)targetVCName
               option:(AC_HL_AlertViewDisPlayedOption)options;
+ (void)loadAlertView:(id)alertView
             targetVC:(NSString *)targetVCName
               option:(AC_HL_AlertViewDisPlayedOption)options;
@end
