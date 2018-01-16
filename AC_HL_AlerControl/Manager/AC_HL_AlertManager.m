//
//  AC_HL_AlertManager.m
//  caiqr
//
//  Created by 洪利 on 2017/7/31.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "AC_HL_AlertManager.h"
#import "AC_HL_AlertInfoViewModel.h"
#import "AC_HL_AlertControl.h"
#import "UIView+AC_HL_AlertClosed.h"
#import "AppDelegate.h"
@interface AC_HL_AlertManager ()

@property (nonatomic, strong) NSMutableArray *alertDataQueue;//管理队列
@property (nonatomic, strong) AC_HL_AlertControl *alertShowsControl;//弹窗展示控制中心

@end

@implementation AC_HL_AlertManager

+ (instancetype)sharedInstance{
    static AC_HL_AlertManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AC_HL_AlertManager alloc] init];
    });
    return manager;
}


/*
 
 将用于描述弹窗任务的InfoModel 添加至管理队列
 
 */
- (void)addAlertToTheQueue:(AC_HL_AlertInfoViewModel *)infoModel{
    if (infoModel) {
        // 添加 并 重新排序
        if ([infoModel.alertView isKindOfClass:UIView.class]) {
            [infoModel.alertView registerMonitorMethod];
        }
        [self.alertDataQueue addObject:infoModel];
        [self dataOrderByOptions];
        // 通知control 开始展示
        [self.alertShowsControl startShow];
    }else{
        NSLog(@"创建了一个无效的数据模型并企图加入弹窗控制周期内");
    }
}



/*
 提供下一个要展示的弹窗
 oldAlertInfo ： 传入参数，用于销毁已经被展示过的弹窗
 */
- (AC_HL_AlertInfoViewModel *)nextAlertWitholdAlertInfo:(AC_HL_AlertInfoViewModel *)oldInfo{
    //清除上一个被展示过的
    [self.alertDataQueue removeObject:oldInfo];
    oldInfo.alertView = nil;
    oldInfo.superView = nil;
    
    //队列内容不为空
    if (self.alertDataQueue.count>0 && [[[self.alertDataQueue firstObject] nonInfoModelKeyWords] length] == 0) {
        //非占位model
        for (AC_HL_AlertInfoViewModel *model in self.alertDataQueue) {
            
            //是否绑定特定VC
            BOOL isNeedShowsOnSomeOneVC = model.targetViewController.length>0?YES:NO;
            //当前vc 与 绑定VC 是否是一个
            BOOL whetherNowIsTargetVC = [model.targetViewController isEqualToString:self.activityVC];
            //是否是占位alert
            BOOL isNonAlertInfo = model.nonInfoModelKeyWords.length>0?YES:NO;
            
            //非占位 且 可以在当前VC展示时 返回当前model
            if ([model.alertView isKindOfClass:UIView.class]) {
                if (!isNonAlertInfo && (!isNeedShowsOnSomeOneVC || whetherNowIsTargetVC) && [model.alertView alpha] && ![model.alertView isHidden] && model.alertView) {
                    return model;
                    break;
                }
            }else{
                if (model.alertView) {
                    return model;
                }
            }
            
        }
    }
    //是否是占位Model 或 队列内任务已全部完毕
    return nil;
}



- (void)removeNonAlertInfo:(id)keyWords{

    NSMutableArray *indexArr = [[NSMutableArray alloc] init];
    for (AC_HL_AlertInfoViewModel *model in self.alertDataQueue) {
        if (model.nonInfoModelKeyWords && [model.nonInfoModelKeyWords isEqualToString:keyWords]) {
            [indexArr addObject:model];
        }
    }
    if (indexArr.count>0) {
        [self.alertDataQueue removeObjectsInArray:indexArr];
    }
    [self.alertShowsControl startShow];
}




- (void)dataOrderByOptions{

    //按照option排序
    NSArray *tempArr = self.alertDataQueue;
    NSArray *orderByOptionArray = [tempArr sortedArrayUsingComparator:^NSComparisonResult(AC_HL_AlertInfoViewModel *obj1, AC_HL_AlertInfoViewModel *obj2) {
        if (obj1.option < obj2.option) {
            return NSOrderedDescending;//降序
        }else if (obj1.option > obj2.option){
            return NSOrderedAscending;//升序
        }else {
            return NSOrderedSame;//相等
        }
    }];
    [self.alertDataQueue removeAllObjects];
    [self.alertDataQueue addObjectsFromArray:orderByOptionArray];
    
}



#pragma mark - Getter Method
- (NSMutableArray *)alertDataQueue{
    if (!_alertDataQueue) {
        _alertDataQueue = [[NSMutableArray alloc] init];
    }
    return _alertDataQueue;
}
- (AC_HL_AlertControl *)alertShowsControl{
    if (!_alertShowsControl) {
        _alertShowsControl = [AC_HL_AlertControl sharedInstance];
    }
    return _alertShowsControl;
}

@end
