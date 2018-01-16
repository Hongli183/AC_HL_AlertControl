//
//  AC_HL_AlertInfoViewModel.h
//  caiqr
//
//  Created by 洪利 on 2017/7/31.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 优先级
 
 - CQAlertViewDisPlayedOptionDefault: 默认default
 */
typedef NS_ENUM(NSInteger, AC_HL_AlertViewDisPlayedOption) {
    AC_HL_AlertViewDisPlayedOptionDefault = 0, //活动、更新、中奖、掉线
    AC_HL_AlertViewDisPlayedOptionNormal = 10,//新手引导
    AC_HL_AlertViewDisPlayedOptionHight = 20, //三帧
    AC_HL_AlertViewDisPlayedOptionHigher = 30,//广告
    AC_HL_AlertViewDisPlayedOptionHightHighest = 40  //闪屏
};

@interface AC_HL_AlertInfoViewModel : NSObject

@property (nonatomic, assign) AC_HL_AlertViewDisPlayedOption option;//优先级
@property (nonatomic, strong) NSString *targetViewController;//标记展示在特定的VC中
@property (nonatomic, strong) id superView;//父视图
@property (nonatomic, strong) id alertView;//弹窗,可以是View 也可以是ViewController
@property (nonatomic, strong) NSString *nonInfoModelKeyWords;//信息为空的占位model





@end
