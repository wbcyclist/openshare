//
//  ViewController.m
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/27.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import "ViewController.h"
#import <KLCPopup/KLCPopup.h>
#import "SAShareView.h"
#import "OpenShareHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}


- (IBAction)shareAction:(id)sender {
    SAShareView *shareView = [SAShareView newFromNib];
    
    // qq
    SAShareBaseActivity *qqActivity = [[SAShareBaseActivity alloc] initWithActionHandler:^(int tag) {
        NSLog(@"tag=%@", @(tag));
        
    }];
    qqActivity.tag = 0;
    qqActivity.title = @"QQ分享";
    qqActivity.thumbImage = [UIImage imageNamed:@"qq"];
    [shareView loadShareObjects:@[qqActivity]];
    
    // 微信
    SAShareBaseActivity *weixinActivity = [[SAShareBaseActivity alloc] initWithActionHandler:^(int tag) {
        NSLog(@"tag=%@", @(tag));
        
    }];
    weixinActivity.tag = 1;
    weixinActivity.title = @"微信";
    weixinActivity.thumbImage = [UIImage imageNamed:@"qq"];
    
    // 微博
    SAShareBaseActivity *weiboActivity = [[SAShareBaseActivity alloc] initWithActionHandler:^(int tag) {
        NSLog(@"tag=%@", @(tag));
        
    }];
    weiboActivity.tag = 2;
    weiboActivity.title = @"微博";
    weiboActivity.thumbImage = [UIImage imageNamed:@"qq"];
    
    [shareView loadShareObjects:@[qqActivity, weixinActivity, weiboActivity]];
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutLeft, KLCPopupVerticalLayoutBottom);
    KLCPopup* popup = [KLCPopup popupWithContentView:shareView
                                            showType:KLCPopupShowTypeSlideInFromBottom
                                         dismissType:KLCPopupDismissTypeSlideOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
}




@end
