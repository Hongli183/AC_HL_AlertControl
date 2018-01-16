//
//  AC_HL_AlertControl.m
//  caiqr
//
//  Created by 洪利 on 2017/7/31.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "AC_HL_AlertControl.h"
#import "AC_HL_AlertManager.h"
#import "AC_HL_AlertInfoViewModel.h"
#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "AC_HL_AlertProtocol.h"
@interface AC_HL_AlertControl ()<AC_HL_AlertProtocol>

@property (nonatomic, strong) AC_HL_AlertInfoViewModel *alertViewModel;
@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, assign) BOOL isNeedIgoreNextShowsOrder;//是否需要忽略下次的移除指令
@end


@implementation AC_HL_AlertControl
+ (instancetype)sharedInstance{
    static AC_HL_AlertControl *control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[AC_HL_AlertControl alloc] init];
    });
    return control;
}
//暂停弹窗任务
- (void)pause{
    self.isNeedIgoreNextShowsOrder = YES;
//    //移除当前正在展示的
//    if ([self.alertViewModel.alertView isKindOfClass:UIViewController.class]) {
//        [self.alertViewModel.alertView dismissViewControllerAnimated:NO completion:nil];
//    }else{
//        [self.alertViewModel.alertView removeFromSuperview];
//    }
//    self.baseView.hidden = YES;
//    self.alertViewModel = nil;
    
}

//开始弹窗任务
- (void)startShow{
    if (!self.isNeedIgoreNextShowsOrder) {
        [self startAlertShowsMission];
    }
}


- (void)startAlertShowsMission{
    
    AC_HL_AlertInfoViewModel *alertInfo = [ac_hl_alertManager nextAlertWitholdAlertInfo:self.alertViewModel];
    self.alertViewModel = alertInfo;

    if (self.alertViewModel && self.alertViewModel.alertView) {
        if (self.alertViewModel.superView) {
            //已经配置好了父视图
            if ([self.alertViewModel.alertView isKindOfClass:UIViewController.class]) {
                //用ViewController制作的弹窗
                [[self.alertViewModel.superView navigationController] presentViewController:self.alertViewModel.alertView animated:NO completion:nil];
            }else{
                [self.alertViewModel.superView addSubview:self.alertViewModel.alertView];
            }
        }else if([self.alertViewModel.alertView isKindOfClass:UIView.class]){
            self.baseView.hidden = NO;
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            [keyWindow addSubview:self.alertViewModel.alertView];
        }else if ([self.alertViewModel.alertView isKindOfClass:UIViewController.class]) {
            //用ViewController制作的弹窗
            [[self topViewController].navigationController presentViewController:self.alertViewModel.alertView animated:NO completion:nil];
        }
        self.isNeedIgoreNextShowsOrder = YES;
    }
}


#pragma mark - AC_HL_AlertProtocol
- (void)missionPause{
    [self pause];
}

- (void)reStartMission{
    [self startShow];
}

- (void)alertViewHasbeenClosed:(NSString *)alertClassName{
    self.baseView.hidden = YES;
    self.isNeedIgoreNextShowsOrder = NO;
    if ([alertClassName isEqualToString:NSStringFromClass([self.alertViewModel.alertView class])]) {
        [self startAlertShowsMission];
    }
}


#pragma mark - 获取当前最上层VC
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


#pragma mark- Getter Method
- (UIView *)baseView{
    if (!_baseView) {
        _baseView = [UIView new];
        UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
        _baseView.backgroundColor = [UIColor blackColor];
        _baseView.alpha = 0.7;
        [keywindow addSubview:_baseView];
        [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(keywindow);
        }];
        _baseView.hidden = YES;
    }
    return _baseView;
}


@end
