//
//  AC_HL_AlertQueueProxy.h
//  caiqr
//
//  Created by 洪利 on 2017/8/1.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AC_HL_AlertProtocol.h"

#define alertProxy [AC_HL_AlertQueueProxy dealerProxy]





@interface AC_HL_AlertQueueProxy : NSProxy<AC_HL_AlertProtocol>

+ (instancetype)dealerProxy;

@end
