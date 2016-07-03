//
//  KXShareViewFlowLayout.m
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/28.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import "KXShareViewFlowLayout.h"

@implementation KXShareViewFlowLayout {
    NSInteger _cellCount;
    CGSize _boundsSize;
}

@synthesize itemSize = _itemSize;

- (void)prepareLayout
{
    // Get the number of cells and the bounds size
    if (_itemSize.width==0) {
        _itemSize = CGSizeMake(100, 100);
    }
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    _boundsSize = self.collectionView.bounds.size;
}

- (CGSize)collectionViewContentSize
{
    // We should return the content size. Lets do some math:
    
    NSInteger verticalItemsCount = (NSInteger)floorf((_boundsSize.height+_itemGapV)/(_itemSize.height+_itemGapV));
    NSInteger horizontalItemsCount = (NSInteger)floorf((_boundsSize.width+_itemGapH)/(_itemSize.width+_itemGapH));
    
    NSInteger itemsPerPage = verticalItemsCount * horizontalItemsCount;
    NSInteger numberOfItems = _cellCount;
    NSInteger numberOfPages = (NSInteger)ceilf((CGFloat)numberOfItems / (CGFloat)itemsPerPage);
    
    CGSize size = _boundsSize;
    size.width = numberOfPages * _boundsSize.width;
    return size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // This method requires to return the attributes of those cells that intsersect with the given rect.
    // In this implementation we just return all the attributes.
    // In a better implementation we could compute only those attributes that intersect with the given rect.
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:_cellCount];
    
    for (NSUInteger i=0; i<_cellCount; ++i)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self _layoutForAttributesForCellAtIndexPath:indexPath];
        
        [allAttributes addObject:attr];
    }
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self _layoutForAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    // We should do some math here, but we are lazy.
    return YES;
}

- (UICollectionViewLayoutAttributes*)_layoutForAttributesForCellAtIndexPath:(NSIndexPath*)indexPath
{
    // Here we have the magic of the layout.
    
    NSInteger row = indexPath.row;
    
    CGRect bounds = self.collectionView.bounds;
    CGSize itemSize = self.itemSize;
    
    // Get some info:
    //    NSInteger verticalItemsCount = (NSInteger)floorf(bounds.size.height / itemSize.height);
    //    NSInteger horizontalItemsCount = (NSInteger)floorf(bounds.size.width / itemSize.width);
    NSInteger verticalItemsCount = (NSInteger)floorf((bounds.size.height+_itemGapV)/(_itemSize.height+_itemGapV));
    NSInteger horizontalItemsCount = (NSInteger)floorf((bounds.size.width+_itemGapH)/(_itemSize.width+_itemGapH));
    NSInteger itemsPerPage = verticalItemsCount * horizontalItemsCount;
    NSInteger itemPage = floorf(row/itemsPerPage);//第几页
    
    // Compute the column & row position, as well as the page of the cell.
    NSInteger columnPosition = row%horizontalItemsCount;
    NSInteger rowPosition = (row/horizontalItemsCount)%verticalItemsCount;
    
    CGFloat centerX = bounds.size.width/2 + bounds.size.width*itemPage;
    NSInteger centerN;
    if (horizontalItemsCount > _cellCount) {
        centerN = _cellCount/2;
    } else {
        centerN = horizontalItemsCount/2;
    }
    NSInteger n = columnPosition;
    
    CGPoint position;
    position.x = centerX + (n - centerN)*(_itemSize.width+_itemGapH) - _itemSize.width/2;
    if (horizontalItemsCount > _cellCount) {
        position.y = (bounds.size.height - itemSize.height)/2;
    } else {
        position.y = rowPosition * (itemSize.height + _itemGapV) + self.topOffset;
    }
    
    
    BOOL isEvenNum = horizontalItemsCount > _cellCount ? _cellCount%2==0 : horizontalItemsCount%2==0;
    if (isEvenNum) {
        position.x += (_itemSize.width+_itemGapH)/2;
    }
    
    // Creating an empty attribute
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGRect frame = CGRectZero;
    // And finally, we assign the positions of the cells
    //    frame.origin.x = itemPage * bounds.size.width + columnPosition * itemSize.width;
    //    frame.origin.y = rowPosition * itemSize.height;
    frame.origin = position;
    frame.size = _itemSize;
    
    attr.frame = frame;
    return attr;
}

#pragma mark Properties

- (void)setItemSize:(CGSize)itemSize
{
    _itemSize = itemSize;
    [self invalidateLayout];
}

@end
