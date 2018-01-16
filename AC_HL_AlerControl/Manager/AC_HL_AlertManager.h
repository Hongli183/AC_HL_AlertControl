//
//  AC_HL_AlertManager.h
//  caiqr
//
//  Created by 洪利 on 2017/7/31.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>



#define ac_hl_alertManager [AC_HL_AlertManager sharedInstance]
@class AC_HL_AlertInfoViewModel;
@interface AC_HL_AlertManager : NSObject


@property (nonatomic, strong) NSString *activityVC;//记录当前最上层或者即将展示的VC

+ (instancetype)sharedInstance;





/*
 
 将用于描述弹窗任务的InfoModel 添加至管理队列
 
 */
- (void)addAlertToTheQueue:(AC_HL_AlertInfoViewModel *)infoModel;

/*
 提供下一个要展示的弹窗
 oldAlertInfo ： 传入参数，用于销毁已经被展示过的弹窗
 */
- (AC_HL_AlertInfoViewModel *)nextAlertWitholdAlertInfo:(AC_HL_AlertInfoViewModel *)oldInfo;

//根据关键字移除占位model
- (void)removeNonAlertInfo:(id)keyWords;

@end
