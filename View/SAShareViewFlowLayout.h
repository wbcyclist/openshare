//
//  SAShareViewFlowLayout.h
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/28.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAShareViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemGapH;
@property (nonatomic, assign) CGFloat itemGapV;
@property (nonatomic, assign) CGFloat topOffset;

@end
