//
//  AC_HL_AlertProcessPresenter.m
//  caiqr
//
//  Created by 洪利 on 2017/7/31.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "AC_HL_AlertProcessPresenter.h"
#import "AC_HL_AlertManager.h"
@implementation AC_HL_AlertProcessPresenter

+ (void)loadNonInfoAlertView:(id)keyWords{
    AC_HL_AlertInfoViewModel *model = [self getAlertInfoModel];
    model.nonInfoModelKeyWords = keyWords;
    [ac_hl_alertManager addAlertToTheQueue:model];
}

+ (void)loadAlertView:(id)alertView{
    AC_HL_AlertInfoViewModel *model = [self getAlertInfoModel];
    model.alertView = alertView;
    model.option = AC_HL_AlertViewDisPlayedOptionDefault;
    [ac_hl_alertManager addAlertToTheQueue:model];

}
+ (void)loadAlertView:(id)alertView
               option:(AC_HL_AlertViewDisPlayedOption)options{
    AC_HL_AlertInfoViewModel *model = [self getAlertInfoModel];
    model.alertView = alertView;
    model.option = options;
    [ac_hl_alertManager addAlertToTheQueue:model];

}
+ (void)loadAlertView:(id)alertView
            superView:(id)superView{
    AC_HL_AlertInfoViewModel *model = [self getAlertInfoModel];
    model.alertView = alertView;
    model.superView = superView;
    model.option = AC_HL_AlertViewDisPlayedOptionDefault;
    [ac_hl_alertManager addAlertToTheQueue:model];
}
+ (void)loadAlertView:(id)alertView
            superView:(id)superView
               option:(AC_HL_AlertViewDisPlayedOption)options{
    AC_HL_AlertInfoViewModel *model = [self getAlertInfoModel];
    model.option = AC_HL_AlertViewDisPlayedOptionDefault;
    model.alertView = alertView;
    model.superView = superView;
    [ac_hl_alertManager addAlertToTheQueue:model];
}

+ (void)removeNonAlertInfo:(id)keyWords{
    if ([keyWords isKindOfClass:NSString.class]) {
        
    }else if ([keyWords isKindOfClass:AC_HL_AlertInfoViewModel.class]){
        [ac_hl_alertManager addAlertToTheQueue:keyWords];
    }

}

//特定VC下展示
+ (void)loadAlertView:(id)alertView
             targetVC:(NSString *)targetVCName{
    AC_HL_AlertInfoViewModel *model = [self getAlertInfoModel];
    model.option = AC_HL_AlertViewDisPlayedOptionDefault;
    model.alertView = alertView;
    model.targetViewController = targetVCName;
    [ac_hl_alertManager addAlertToTheQueue:model];

}

+ (void)loadAlertView:(id)alertView
            superView:(id)superView
             targetVC:(NSString *)targetVCName{
    AC_HL_AlertInfoViewModel *model = [self getAlertInfoModel];
    model.option = AC_HL_AlertViewDisPlayedOptionDefault;
    model.alertView = alertView;
    model.superView = superView;
    model.targetViewController = targetVCName;
    [ac_hl_alertManager addAlertToTheQueue:model];
}

+ (void)loadAlertView:(id)alertView
            superView:(id)superView
             targetVC:(NSString *)targetVCName
               option:(AC_HL_AlertViewDisPlayedOption)options{
    AC_HL_AlertInfoViewModel *model = [self getAlertInfoModel];
    model.option = options;
    model.alertView = alertView;
    model.superView = superView;
    model.targetViewController = targetVCName;
    [ac_hl_alertManager addAlertToTheQueue:model];
}
+ (void)loadAlertView:(id)alertView
             targetVC:(NSString *)targetVCName
               option:(AC_HL_AlertViewDisPlayedOption)options{
    AC_HL_AlertInfoViewModel *model = [self getAlertInfoModel];
    model.option = options;
    model.alertView = alertView;
    model.targetViewController = targetVCName;
    [ac_hl_alertManager addAlertToTheQueue:model];
}




+ (AC_HL_AlertInfoViewModel *)getAlertInfoModel{

    return [[AC_HL_AlertInfoViewModel alloc] init];
}


@end
