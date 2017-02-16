//
//  KXShareBaseActivity.h
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/28.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KXShareBaseActivity;

typedef void (^KXShareActivityActionHandler)(int tag);

@interface KXShareBaseActivity : NSObject

@property (nonatomic, assign) int tag;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) UIImage *thumbImage;
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) KXShareActivityActionHandler actionHandler;

- (instancetype)initWithActionHandler:(KXShareActivityActionHandler)block;

- (void)performActivity;

@end
