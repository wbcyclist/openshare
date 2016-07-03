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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConst;

@end

@implementation KXShareViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLab.text = title;
}

- (void)setThumbImage:(UIImage *)thumbImage {
    if (_thumbImage != thumbImage) {
        _thumbImage = thumbImage;
//        if (self.imageWidthConst.constant != thumbImage.size.width) {
//            self.imageWidthConst.constant = thumbImage.size.width;
//        }
//        if (self.imageHeightConst.constant != thumbImage.size.height) {
//            self.imageHeightConst.constant = thumbImage.size.height;
//        }
        self.imageView.image = thumbImage;
    }
}


@end
