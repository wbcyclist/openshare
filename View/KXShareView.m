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
@property (nonatomic, weak) KXShareViewFlowLayout *flowLayout;

@end

@implementation KXShareView
@synthesize itemSize = _itemSize;
@synthesize itemFont = _itemFont;
@synthesize itemFontColor = _itemFontColor;

+ (instancetype)newFromNibWithHeight:(CGFloat)height {
    KXShareView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor whiteColor];
    view.bottomView.hidden = YES;
    view.bottomHeightLC.constant = 0.0;
    
    CGRect frame = view.frame;
    view.viewHeight = height;
    frame.size = CGSizeMake(KX_SCREEN_WIDTH, height);
    view.frame = frame;
    return view;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupDefaultValues];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupDefaultValues];
}

- (void)setupDefaultValues {
    _itemMinGapV = _itemMinGapH = 5.f;
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

- (void)setItemSize:(CGSize)itemSize {
    if (CGSizeEqualToSize(itemSize, _itemSize)) {
        return;
    }
    if (itemSize.width==0 || itemSize.height==0) {
        KXShareViewCell *cellView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([KXShareViewCell class]) owner:nil options:nil] firstObject];
        itemSize = cellView.frame.size;
    }
    _itemSize = itemSize;
    _flowLayout.itemSize = _itemSize;
}
- (CGSize)itemSize {
    if (_itemSize.width==0 || _itemSize.height==0) {
        KXShareViewCell *cellView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([KXShareViewCell class]) owner:nil options:nil] firstObject];
        _itemSize = cellView.frame.size;
    }
    return _itemSize;
}

- (UIFont *)itemFont {
    if (!_itemFont) {
        _itemFont = [UIFont systemFontOfSize:14.f];
    }
    return _itemFont;
}
- (void)setItemFont:(UIFont *)itemFont {
    if (!itemFont) {
        itemFont = [UIFont systemFontOfSize:14.f];
    }
    _itemFont = itemFont;
    [_collectionView reloadData];
}

- (UIColor *)itemFontColor {
    if (!_itemFontColor) {
        _itemFontColor = [UIColor colorWithRed:128/255.f green:128/255.f blue:128/255.f alpha:1.f];
    }
    return _itemFontColor;
}
- (void)setItemFontColor:(UIColor *)itemFontColor {
    if (!itemFontColor) {
        itemFontColor = [UIColor colorWithRed:128/255.f green:128/255.f blue:128/255.f alpha:1.f];
    }
    _itemFontColor = itemFontColor;
    [_collectionView reloadData];
}

- (void)setItemMinGapH:(CGFloat)itemMinGapH {
    if (_itemMinGapH != itemMinGapH) {
        _itemMinGapH = itemMinGapH;
        _flowLayout.itemMinGapH = itemMinGapH;
    }
}
- (void)setItemMinGapV:(CGFloat)itemMinGapV {
    if (_itemMinGapV != itemMinGapV) {
        _itemMinGapV = itemMinGapV;
        _flowLayout.itemMinGapV = itemMinGapV;
    }
}
- (void)setMaxRowItemCount:(u_int)maxRowItemCount {
    if (_maxRowItemCount != maxRowItemCount) {
        _maxRowItemCount = maxRowItemCount;
        _flowLayout.maxRowItemCount = maxRowItemCount;
    }
}
- (void)setMaxColumnItemCount:(u_int)maxColumnItemCount {
    if (_maxColumnItemCount != maxColumnItemCount) {
        _maxColumnItemCount = maxColumnItemCount;
        _flowLayout.maxColumnItemCount = maxColumnItemCount;
    }
}

- (void)setCollectionView:(UICollectionView *)collectionView {
    if (_collectionView != collectionView) {
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _flowLayout = (KXShareViewFlowLayout*)_collectionView.collectionViewLayout;
        _flowLayout.itemSize = self.itemSize;
        _flowLayout.itemMinGapH = self.itemMinGapH;
        _flowLayout.itemMinGapV = self.itemMinGapV;
        _flowLayout.maxRowItemCount = self.maxRowItemCount;
        _flowLayout.maxColumnItemCount = self.maxColumnItemCount;
        
        UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([KXShareViewCell class]) bundle:[NSBundle bundleForClass:[self class]]];
        [_collectionView registerNib:cellNib forCellWithReuseIdentifier:NSStringFromClass([KXShareViewCell class])];
    }
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
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.shareObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KXShareViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KXShareViewCell class]) forIndexPath:indexPath];
    KXShareBaseActivity *activity = self.shareObjects[indexPath.row];
    cell.itemFont = _itemFont;
    cell.itemFontColor = _itemFontColor;
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
