//
//  KXShareViewCell.m
//  OpenShareDemo
//
//  Created by JasioWoo on 15/7/28.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import "KXShareViewCell.h"

@interface KXShareViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation KXShareViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setItemFont:(UIFont *)itemFont {
    if (!itemFont) {
        itemFont = [UIFont systemFontOfSize:14.f];
    }
    _itemFont = itemFont;
    _titleLab.font = itemFont;
}
- (void)setItemFontColor:(UIColor *)itemFontColor {
    if (!itemFontColor) {
        itemFontColor = [UIColor colorWithRed:128/255.f green:128/255.f blue:128/255.f alpha:1.f];
    }
    _itemFontColor = itemFontColor;
    _titleLab.textColor = itemFontColor;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLab.text = title;
}

- (void)setThumbImage:(UIImage *)thumbImage {
    if (_thumbImage != thumbImage) {
        _thumbImage = thumbImage;
        self.imageView.image = thumbImage;
    }
}


@end
