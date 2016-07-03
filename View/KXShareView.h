//
//  KXShareView.h
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/27.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KXShareBaseActivity.h"


typedef void (^KXShareViewDismissActionBlock)();

@interface KXShareView : UIView

+ (instancetype)newFromNibWithHeight:(CGFloat)height;

- (void)loadShareObjects:(NSArray<KXShareBaseActivity *> *)shareObjects;

@property (nonatomic, copy) KXShareViewDismissActionBlock dismissBlock;

@end
