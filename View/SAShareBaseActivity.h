//
//  SAShareBaseActivity.h
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/28.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAShareBaseActivity;

typedef void (^SAShareActivityActionHandler)(int tag);

@interface SAShareBaseActivity : NSObject

@property (nonatomic, assign) int tag;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) SAShareActivityActionHandler actionHandler;

- (instancetype)initWithActionHandler:(SAShareActivityActionHandler)block;

- (void)performActivity;

@end
