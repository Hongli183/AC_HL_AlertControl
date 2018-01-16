//
//  AC_HL_AlertControl.h
//  caiqr
//
//  Created by 洪利 on 2017/7/31.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AC_HL_AlertControl : NSObject

+ (instancetype)sharedInstance;

- (void)startShow;

- (void)pause;

@end
