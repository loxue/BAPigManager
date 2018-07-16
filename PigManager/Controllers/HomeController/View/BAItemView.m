//
//  BAItemView.m
//  PigManager
//
//  Created by imac on 2018/7/6.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAItemView.h"

@implementation BAItemView

- (instancetype)initWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
                    withImage:(NSString *)imageName
                     tapBlock:(BAItemTappedBlock *)block
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customImageFrame:frame
                  displayImage:[UIImage imageNamed:imageName]];
        [self customLabelFrame:frame
                     LabelFont:MXFont12
              labelTextAligent:NSTextAlignmentCenter
                    labelColor:[UIResource get0faae2Color]
                    labelTitle:title];
    }
    return self;
}

- (UILabel *)customLabelFrame:(CGRect)labelFrame
                    LabelFont:(UIFont *)labelFont
             labelTextAligent:(NSTextAlignment)labelAlignment
                   labelColor:(UIColor *)labelColor
                   labelTitle:(NSString *)labelTitle
{
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.font = labelFont;
    label.textColor = labelColor;
    label.textAlignment = labelAlignment;
    label.text = labelTitle;
    return label;
}

- (UIImageView *)customImageFrame:(CGRect)imageFrame
                    displayImage:(UIImage *)displayImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    imageView.image = displayImage;
    return imageView;
}

- (void)show {
    
}

- (void)dismiss {
    [self removeFromSuperview];
}

@end
