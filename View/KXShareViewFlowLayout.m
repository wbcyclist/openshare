//
//  KXShareViewFlowLayout.m
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/28.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import "KXShareViewFlowLayout.h"

@implementation KXShareViewFlowLayout {
    // 页面大小
    CGSize _boundsSize;
    // 总共有多少item
    NSInteger _itemCount;
    // 一行共多少item
    u_int _rowItemCount;
    // 一列共多少item
    u_int _columnItemCount;
    // 当前共多少页
    u_int _pageCount;
    
    CGFloat _itemGapH;
    CGFloat _itemGapV;
}
@synthesize itemSize = _itemSize;

- (void)prepareLayout {
    // Get the number of cells and the bounds size
    if (_itemSize.width==0) {
        _itemSize = CGSizeMake(100, 100);
    }
    _itemCount = [self.collectionView numberOfItemsInSection:0];
    _boundsSize = self.collectionView.bounds.size;
}

- (CGSize)collectionViewContentSize {
    // We should return the content size. Lets do some math:
    
    u_int horizontalItemsCount = MAX(1, floorf( (_boundsSize.width+_itemMinGapH) / (_itemSize.width+_itemMinGapH) ));
    u_int verticalItemsCount = MAX(1, floorf( (_boundsSize.height+_itemMinGapV) / (_itemSize.height+_itemMinGapV) ));
    
    if (_maxRowItemCount > 0 && _maxRowItemCount < horizontalItemsCount) {
        horizontalItemsCount = _maxRowItemCount;
    }
    if (_maxColumnItemCount > 0 && _maxColumnItemCount < verticalItemsCount) {
        verticalItemsCount = _maxColumnItemCount;
    }
    if (_itemCount < horizontalItemsCount) {
        horizontalItemsCount = MAX(1, _itemCount);
    }
    
    u_int vCount = ceilf(_itemCount / (CGFloat)horizontalItemsCount);
    if (vCount < verticalItemsCount) {
        verticalItemsCount = MAX(1, vCount);
    }
    
    _rowItemCount = horizontalItemsCount;
    _columnItemCount = verticalItemsCount;
    _pageCount = ceilf(_itemCount / (CGFloat)(_rowItemCount*_columnItemCount));
    
    _itemGapH = (_boundsSize.width - (_rowItemCount * _itemSize.width)) / (_rowItemCount+1);
    _itemGapV = (_boundsSize.height - (_columnItemCount * _itemSize.height)) / (_columnItemCount+1);
    
    CGSize size = CGSizeMake(_pageCount * _boundsSize.width, _boundsSize.height);
    return size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // This method requires to return the attributes of those cells that intsersect with the given rect.
    // In this implementation we just return all the attributes.
    // In a better implementation we could compute only those attributes that intersect with the given rect.
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:_itemCount];
    
    for (NSUInteger i=0; i<_itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self _layoutForAttributesForCellAtIndexPath:indexPath];
        [allAttributes addObject:attr];
    }
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self _layoutForAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    // We should do some math here, but we are lazy.
    return YES;
}

- (UICollectionViewLayoutAttributes*)_layoutForAttributesForCellAtIndexPath:(NSIndexPath*)indexPath {
    // Here we have the magic of the layout.
    NSInteger row = indexPath.row;
    
    NSInteger itemPage = floorf(row/(_rowItemCount*_columnItemCount)); // 第几页
    NSInteger rowPosition = (row/_rowItemCount)%_columnItemCount; // 第几行
    NSInteger columnPosition = row%_rowItemCount; // 第几列
    
    CGFloat x = (columnPosition+1)*_itemGapH + columnPosition*_itemSize.width + itemPage*_boundsSize.width;
    CGFloat y = (rowPosition+1)*_itemGapV + rowPosition*_itemSize.height;
    
//    NSLog(@"row=%@, x=%@, y=%@", @(row), @(x), @(y));
    CGPoint position = CGPointMake(x, y);
    
    // Creating an empty attribute
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect frame = (CGRect){.origin = position, .size = _itemSize};
    attr.frame = frame;
    return attr;
}

#pragma mark Properties
- (void)setItemSize:(CGSize)itemSize {
    if (CGSizeEqualToSize(itemSize, _itemSize)) {
        return;
    }
    _itemSize = itemSize;
    [self invalidateLayout];
}
- (void)setItemMinGapH:(CGFloat)itemMinGapH {
    _itemMinGapH = itemMinGapH;
    if (_itemMinGapH > _itemGapH) {
        [self invalidateLayout];
    }
}
- (void)setItemMinGapV:(CGFloat)itemMinGapV {
    _itemMinGapV = itemMinGapV;
    if (_itemMinGapV > _itemGapV) {
        [self invalidateLayout];
    }
}
- (void)setMaxRowItemCount:(u_int)maxRowItemCount {
    if (_maxRowItemCount != maxRowItemCount) {
        _maxRowItemCount = maxRowItemCount;
        [self invalidateLayout];
    }
}
- (void)setMaxColumnItemCount:(u_int)maxColumnItemCount {
    if (_maxColumnItemCount != maxColumnItemCount) {
        _maxColumnItemCount = maxColumnItemCount;
        [self invalidateLayout];
    }
}






@end
