//
//  KXShareViewFlowLayout.h
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/28.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KXShareViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGSize itemSize;
/// item间水平最小距离
@property (nonatomic, assign) CGFloat itemMinGapH;
/// item间垂直最小距离
@property (nonatomic, assign) CGFloat itemMinGapV;

/// 一行最多显示多少个item, 0为不做限制
@property (nonatomic, assign) u_int maxRowItemCount;
/// 一列最多显示多少item, 0为不做限制
@property (nonatomic, assign) u_int maxColumnItemCount;


@end
