//
//  AC_HL_AlertProtocol.h
//  caiqr
//
//  Created by 洪利 on 2017/8/1.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AC_HL_AlertProtocol <NSObject>

//暂时停止弹窗任务
- (void)missionPause;
//启动弹窗任务
- (void)reStartMission;
//弹窗被移除
- (void)alertViewHasbeenClosed:(NSString *)alertClassName;


@end
