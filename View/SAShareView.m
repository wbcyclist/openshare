//
//  SAShareView.m
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/27.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import "SAShareView.h"
#import "SAShareViewCell.h"
#import "SAShareViewFlowLayout.h"
#import <KLCPopup/KLCPopup.h>

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

@interface SAShareView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *shareObjects;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConst;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SAShareView

+ (instancetype)newFromNib
{
    SAShareView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    CGRect frame = view.frame;
    frame.size.width = SCREEN_WIDTH;
    view.frame = frame;
    return view;
}

- (void)setCollectionView:(UICollectionView *)collectionView
{
    if (_collectionView != collectionView) {
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        SAShareViewFlowLayout *flowLayout = (SAShareViewFlowLayout*)_collectionView.collectionViewLayout;
        flowLayout.topOffset = 10.f;
        if (SCREEN_WIDTH>=375) {
            flowLayout.itemGapH = 29.f;
        } else {
            flowLayout.itemGapH = 20.f;
        }
        flowLayout.itemGapV = 10.f;
        flowLayout.itemSize = [self getCellSize];
        UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([SAShareViewCell class]) bundle:[NSBundle mainBundle]];
        [_collectionView registerNib:cellNib forCellWithReuseIdentifier:NSStringFromClass([SAShareViewCell class])];
    }
}

- (void)setContentHeightConst:(NSLayoutConstraint *)contentHeightConst
{
    if (_contentHeightConst != contentHeightConst) {
        _contentHeightConst = contentHeightConst;
    }
}

- (CGSize)getCellSize
{
    SAShareViewCell *cellView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SAShareViewCell class]) owner:nil options:nil] firstObject];
    return cellView.frame.size;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (CGRectGetWidth(self.frame) != SCREEN_WIDTH) {
        CGRect frame = self.frame;
        frame.size.width = SCREEN_WIDTH;
        self.frame = frame;
    }
}

- (void)loadShareObjects:(NSArray *)shareObjects
{
    self.shareObjects = shareObjects;
}

- (void)setShareObjects:(NSArray *)shareObjects
{
    if (_shareObjects != shareObjects) {
        _shareObjects = shareObjects;
        [self.collectionView reloadData];
    }
}


- (IBAction)onCancelAction:(id)sender
{
    [self dismissPresentingPopup];
}

#pragma mark - UICollectionViewDataSource
// 返回section的数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// 返回在一个给定section里的cell数量
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.shareObjects.count;
}

// 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defaultCellIdentifier = @"SAShareViewCell";
    SAShareViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:defaultCellIdentifier forIndexPath:indexPath];
//    cell.title = [NSString stringWithFormat:@"%@, %@", @(indexPath.section), @(indexPath.row)];
    SAShareBaseActivity *activity = self.shareObjects[indexPath.row];
    cell.title = activity.title;
    cell.thumbImage = activity.thumbImage;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"didSelectItemAtIndexPath %@", @(indexPath.row));
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    SAShareBaseActivity *activity = self.shareObjects[indexPath.row];
    [activity performActivity];
    [self onCancelAction:nil];
}


@end
