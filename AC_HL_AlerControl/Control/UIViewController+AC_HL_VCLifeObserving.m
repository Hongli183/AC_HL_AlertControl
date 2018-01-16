//
//  UIViewController+AC_HL_VCLifeObserving.m
//  caiqr
//
//  Created by 洪利 on 2017/7/31.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "UIViewController+AC_HL_VCLifeObserving.h"
#import "AC_HL_AlertManager.h"
#import <objc/runtime.h>



@implementation UIViewController (AC_HL_VCLifeObserving)


+ (void)load{

    // 交换 viewWillAppear方法
    [self AC_HL_methodSwizzlingWithOriginalSelector:@selector(viewWillAppear:)
                                 bySwizzledSelector:@selector(AC_HL_viewWillAppear:)];
    
    /*
    //交换 push pop  present dismiss 方法
    [self AC_HL_methodSwizzlingWithOriginalSelector:@selector(pushViewController:animated:)
                                 bySwizzledSelector:@selector(AC_HL_pushViewController:animated:)];
    
    [self AC_HL_methodSwizzlingWithOriginalSelector:@selector(popViewControllerAnimated:)
                                 bySwizzledSelector:@selector(AC_HL_popViewControllerAnimated:)];
    
    [self AC_HL_methodSwizzlingWithOriginalSelector:@selector(popToViewController:animated:)
                                 bySwizzledSelector:@selector(AC_HL_popToViewController:animated:)];
    [self AC_HL_methodSwizzlingWithOriginalSelector:@selector(popToRootViewControllerAnimated:)
                                 bySwizzledSelector:@selector(AC_HL_popToRootViewControllerAnimated:)];
    
     */
    
    [self AC_HL_methodSwizzlingWithOriginalSelector:@selector(presentViewController:animated:completion:)
                                 bySwizzledSelector:@selector(AC_HL_presentViewController:animated:completion:)];
    [self AC_HL_methodSwizzlingWithOriginalSelector:@selector(dismissViewControllerAnimated:completion:)
                                 bySwizzledSelector:@selector(AC_HL_dismissViewControllerAnimated:completion:)];
    [self AC_HL_methodSwizzlingWithOriginalSelector:@selector(dismissModalViewControllerAnimated:)
                                 bySwizzledSelector:@selector(AC_HL_dismissModalViewControllerAnimated:)];
}




- (void)AC_HL_viewWillAppear:(BOOL)animated{
    [self AC_HL_viewWillAppear:animated];
    if (![self.description containsString:@"UIInputWindowController"]
        &&![self.description containsString:@"UIApplicationRotationFollowingController"]
        && ![self.description containsString:@"UICompatibilityInputViewController"]
        && ![self isKindOfClass:UINavigationController.class]) {
        //被模态出来的视图不具备执行弹窗任务的资格
        if (![self presentingViewController]) {
            ac_hl_alertManager.activityVC = NSStringFromClass([self class]);
            [alertProxy reStartMission];
        }
        
    }
}
/*
- (void)AC_HL_pushViewController:(UIViewController *)viewController
                        animated:(BOOL)animated{
    
    [self AC_HL_pushViewController:viewController
                          animated:animated];
    [alertProxy missionPause];
    
}
- (void)AC_HL_popViewControllerAnimated:(BOOL)animated{
    [self AC_HL_popViewControllerAnimated:animated];
    [alertProxy missionPause];
}

- (void)AC_HL_popToViewController:(UIViewController *)viewController
                         animated:(BOOL)animated{
    
    [self AC_HL_popToViewController:viewController
                           animated:animated];
    [alertProxy missionPause];
}

- (void)AC_HL_popToRootViewControllerAnimated:(BOOL)animated{
    [self AC_HL_popToRootViewControllerAnimated:animated];
    [alertProxy missionPause];
}



*/
- (void)AC_HL_presentViewController:(UIViewController *)viewControllerToPresent
                           animated: (BOOL)flag
                         completion:(void (^ __nullable)(void))completion{
    
    [self AC_HL_presentViewController:viewControllerToPresent
                             animated:flag
                           completion:completion];
    [alertProxy missionPause];
}


 - (void)AC_HL_dismissViewControllerAnimated:(BOOL)flag
                                  completion:(void (^ __nullable)(void))completion{
 
     [self AC_HL_dismissViewControllerAnimated:flag completion:completion];
 
 //[alertProxy missionPause];
     [alertProxy alertViewHasbeenClosed:NSStringFromClass([self class])];
}
- (void)AC_HL_dismissModalViewControllerAnimated:(BOOL)animated{
     [self AC_HL_dismissModalViewControllerAnimated:animated];
//     [alertProxy missionPause];
     [alertProxy alertViewHasbeenClosed:NSStringFromClass([self class])];
}





//方法交换
+ (void)AC_HL_methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
