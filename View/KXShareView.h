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

/// default (50, 78)
@property (nonatomic, assign) CGSize itemSize;
/// default [UIFont systemFontOfSize:14.f]
@property (nonatomic, copy) UIFont *itemFont;
/// default [UIColor colorWithRed:128/255.f green:128/255.f blue:128/255.f alpha:1.f]
@property (nonatomic, copy) UIColor *itemFontColor;

/// item间水平最小距离 default:5
@property (nonatomic, assign) CGFloat itemMinGapH;
/// item间垂直最小距离 default:5
@property (nonatomic, assign) CGFloat itemMinGapV;
/// 一行最多显示多少个item, 0为不做限制
@property (nonatomic, assign) u_int maxRowItemCount;
/// 一列最多显示多少item, 0为不做限制
@property (nonatomic, assign) u_int maxColumnItemCount;

- (void)loadShareObjects:(NSArray<KXShareBaseActivity *> *)shareObjects;

@property (nonatomic, copy) KXShareViewDismissActionBlock dismissBlock;

@end
