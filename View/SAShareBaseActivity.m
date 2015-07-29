//
//  SAShareBaseActivity.m
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/28.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import "SAShareBaseActivity.h"

@implementation SAShareBaseActivity


- (instancetype)initWithActionHandler:(SAShareActivityActionHandler)block {
    self = [super init];
    if (self) {
        self.actionHandler = block;
    }
    return self;
}

- (void)performActivity {
    if (_actionHandler) {
        _actionHandler(self.tag);
    }
}


@end
