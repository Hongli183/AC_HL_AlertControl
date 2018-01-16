//
//  UIView+AC_HL_AlertClosed.m
//  caiqr
//
//  Created by 洪利 on 2017/7/31.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "UIView+AC_HL_AlertClosed.h"
#import <objc/message.h>
#import "AC_HL_AlertQueueProxy.h"

@implementation UIView (AC_HL_AlertClosed)

- (void)registerMonitorMethod
{
    [self AC_HL_resigtureSubClass];
}

#pragma mark - isa swizzling
- (void)AC_HL_resigtureSubClass{
    // isa-swizzling implement
    //构建类名
    NSString *className;
    if ([NSStringFromClass(object_getClass(self)) containsString:@"AC_HL_IsaSwizzling_"]) {
        className = NSStringFromClass(object_getClass(self));
    }else{
        className = [@"AC_HL_IsaSwizzling_" stringByAppendingString:NSStringFromClass(object_getClass(self))];;
    }
    //构建方法名
    NSString *methodName = @"removeFromSuperview";
    
    Class subCls = NSClassFromString(className);
    if (!subCls) {

        subCls = objc_allocateClassPair(object_getClass(self), [className UTF8String], 0);
    }
    //构建子类
    //构建子类方法 实现方法重载
    class_addMethod(subCls, NSSelectorFromString(methodName), (IMP)removeFromSuperview, "v@");
    
    //应用中注册通过 objc_allocateClassPair 方法创建的类
    objc_registerClassPair(subCls);
    object_setClass(self, subCls);
    
}

//rewite removefromesuperview method
static void removeFromSuperview(id self, SEL _cmd){
    
    //子类Class
    Class subCls = object_getClass(self);
    //父类Class
    Class supCls = class_getSuperclass(subCls);
    
    //在此通知control 弹窗被关闭
    [alertProxy alertViewHasbeenClosed:NSStringFromClass(subCls)];
    //父类结构体
    struct objc_super superInfo = {
        self,
        supCls
    };
    //方法最终调用 【super 。。。】
    ((void (*) (void * , SEL, ...))objc_msgSendSuper)(&superInfo, _cmd);
    
}


@end

