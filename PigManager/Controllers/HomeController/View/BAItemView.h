//
//  BAItemView.h
//  PigManager
//
//  Created by imac on 2018/7/6.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BAItemTappedBlock)(NSInteger index);

@interface BAItemView : UIView

@property (nonatomic, assign) BAItemTappedBlock block;

- (UIImageView *)customImageFrame:(CGRect)imageFrame
                     displayImage:(UIImage *)displayImage;

- (UILabel *)customLabelFrame:(CGRect)labelFrame
                    LabelFont:(UIFont *)labelFont
             labelTextAligent:(NSTextAlignment)labelAlignment
                   labelColor:(UIColor *)labelColor
                   labelTitle:(NSString *)labelTitle;

- (instancetype)initWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
                    withImage:(NSString *)imageName
                     tapBlock:(BAItemTappedBlock *)block;

- (void)show;
- (void)dismiss;

@end
