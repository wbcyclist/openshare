//
//  ViewController.m
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/27.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import "ViewController.h"
#import "KLCPopupView.h"
#import "KXShareView.h"
#import "OpenShareHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}


- (IBAction)shareAction:(id)sender {
    KXShareView *shareView = [KXShareView newFromNibWithHeight:152.0];
    __weak __typeof__(shareView)weakShareView = shareView;
    shareView.dismissBlock = ^(){
        [weakShareView dismissPresentingPopup];
    };
    
    // qq
    KXShareBaseActivity *qqActivity = [[KXShareBaseActivity alloc] initWithActionHandler:^(int tag) {
        NSLog(@"tag=%@", @(tag));
        OSMessage *msg=[[OSMessage alloc] init];
        msg.title = @"testtfff";
        [OpenShare shareToQQFriends:msg Success:nil Fail:nil];
    }];
    qqActivity.tag = 0;
    qqActivity.title = @"QQ分享";
    qqActivity.thumbImage = [UIImage imageNamed:@"qq"];
    [shareView loadShareObjects:@[qqActivity]];
    
    
    // 微信
    KXShareBaseActivity *weixinActivity = [[KXShareBaseActivity alloc] initWithActionHandler:^(int tag) {
        NSLog(@"tag=%@", @(tag));
        OSMessage *msg=[[OSMessage alloc]init];
        msg.title=@"掌上快销";
        msg.desc = @"订单号：XXSUDH2016-06-06";
        msg.link=@"http://www.exinfm.com/excel%20files/capbudg.xls";
        msg.image = [UIImage imageNamed:@"Excel"];
        [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
            NSLog(@"微信分享到会话成功：\n%@", message);
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"微信分享到会话失败：\n%@\n%@", error,message);
        }];
    }];
    weixinActivity.tag = 1;
    weixinActivity.title = @"微信";
    weixinActivity.thumbImage = [UIImage imageNamed:@"qq"];
    
    // 微博
    KXShareBaseActivity *weiboActivity = [[KXShareBaseActivity alloc] initWithActionHandler:^(int tag) {
        NSLog(@"tag=%@", @(tag));
        
        OSMessage *msg = [[OSMessage alloc]init];
        msg.title=@"掌上快销 订单号：XXSUDH2016-06-06";
        msg.link=@"http://www.exinfm.com/excel%20files/capbudg.xls";
//        msg.image = [UIImage imageNamed:@"Excel"];
        [OpenShare shareToWeibo:msg Success:^(OSMessage *message) {
            NSLog(@"分享到sina微博成功:\%@",message);
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"分享到sina微博失败:\%@\n%@",message,error);
        }];
    }];
    weiboActivity.tag = 2;
    weiboActivity.title = @"微博";
    weiboActivity.thumbImage = [UIImage imageNamed:@"qq"];
    
    [shareView loadShareObjects:@[qqActivity, weixinActivity, weiboActivity]];
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutLeft, KLCPopupVerticalLayoutBottom);
    KLCPopupView* popupView = [KLCPopupView popupViewWithContentView:shareView
                                                        showType:KLCPopupShowTypeSlideInFromBottom
                                                     dismissType:KLCPopupDismissTypeSlideOutToBottom
                                                        maskType:KLCPopupMaskTypeDimmed
                                        dismissOnBackgroundTouch:YES
                                           dismissOnContentTouch:NO];
    [popupView showWithLayout:layout];
}




@end
