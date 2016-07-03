//
//  KXShareView.m
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/27.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import "KXShareView.h"
#import "KXShareViewCell.h"
#import "KXShareViewFlowLayout.h"

#define KX_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface KXShareView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray<KXShareBaseActivity *> *shareObjects;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightLC;

@property (nonatomic, assign) CGFloat viewHeight;

@end

@implementation KXShareView

+ (instancetype)newFromNibWithHeight:(CGFloat)height {
    KXShareView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor whiteColor];
    view.bottomView.hidden = YES;
    view.bottomHeightLC.constant = 0.0;
    
    CGRect frame = view.frame;
    view.viewHeight = height;
    frame.size = CGSizeMake(KX_SCREEN_WIDTH, height);
    view.frame = frame;
    return view;
}

- (void)dealloc {
//    NSLog(@"%s", __func__);
}

- (void)setDismissBlock:(KXShareViewDismissActionBlock)dismissBlock {
    if (_dismissBlock != dismissBlock) {
        _dismissBlock = dismissBlock;
        
        if (dismissBlock == nil) {
            _bottomView.hidden = YES;
            _bottomHeightLC.constant = 0.0;
        } else {
            _bottomHeightLC.constant = 50.0;
            _bottomView.hidden = NO;
        }
    }
}

- (void)setCollectionView:(UICollectionView *)collectionView {
    if (_collectionView != collectionView) {
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        KXShareViewFlowLayout *flowLayout = (KXShareViewFlowLayout*)_collectionView.collectionViewLayout;
        flowLayout.topOffset = 10.f;
        if (KX_SCREEN_WIDTH>=375) {
            flowLayout.itemGapH = 29.f;
        } else {
            flowLayout.itemGapH = 20.f;
        }
        flowLayout.itemGapV = 10.f;
        flowLayout.itemSize = [self getCellSize];
        UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([KXShareViewCell class]) bundle:[NSBundle mainBundle]];
        [_collectionView registerNib:cellNib forCellWithReuseIdentifier:NSStringFromClass([KXShareViewCell class])];
    }
}

- (CGSize)getCellSize {
    KXShareViewCell *cellView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KXShareViewCell class]) owner:nil options:nil] firstObject];
    return cellView.frame.size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (CGRectGetWidth(self.frame) != KX_SCREEN_WIDTH) {
        CGRect frame = self.frame;
        frame.size.width = KX_SCREEN_WIDTH;
        self.frame = frame;
    }
}

- (void)loadShareObjects:(NSArray<KXShareBaseActivity *> *)shareObjects {
    self.shareObjects = shareObjects;
}

- (void)setShareObjects:(NSArray<KXShareBaseActivity *> *)shareObjects {
    if (_shareObjects != shareObjects) {
        _shareObjects = shareObjects;
        [self.collectionView reloadData];
    }
}


- (IBAction)onCancelAction:(id)sender {
    if (_dismissBlock) {
        _dismissBlock();
    }
}

#pragma mark - UICollectionViewDataSource
// 返回section的数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
// 返回在一个给定section里的cell数量
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.shareObjects.count;
}

// 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KXShareViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KXShareViewCell class]) forIndexPath:indexPath];
    KXShareBaseActivity *activity = self.shareObjects[indexPath.row];
    cell.title = activity.title;
    cell.thumbImage = activity.thumbImage;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"didSelectItemAtIndexPath %@", @(indexPath.row));
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    KXShareBaseActivity *activity = self.shareObjects[indexPath.row];
    [activity performActivity];
    [self onCancelAction:nil];
}




@end
