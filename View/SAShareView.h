//
//  SAShareView.h
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/27.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAShareBaseActivity.h"

@interface SAShareView : UIView

+ (instancetype)newFromNib;

- (void)loadShareObjects:(NSArray*)shareObjects;

- (IBAction)onCancelAction:(id)sender;

@end
