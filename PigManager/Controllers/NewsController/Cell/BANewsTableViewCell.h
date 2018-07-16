//
//  BANewsTableViewCell.h
//  PigManager
//
//  Created by imac on 2018/6/21.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BANewsModel.h"

typedef enum : NSUInteger {
    BANewCellStyleNews  = 0,
    BANewCellStylePig   = 1
} BANewCellStyle;

@interface BANewsTableViewCell : UITableViewCell

@property (nonatomic, assign) BANewCellStyle cellStyle;

// style=0
@property (nonatomic, strong) UIImageView *newsIconImage;
@property (nonatomic, strong) UILabel *newsTitleLabel;

// style=0
@property (nonatomic, strong) UILabel *pigTitleLabel;
@property (nonatomic, strong) UILabel *pigAddressLabel;
@property (nonatomic, strong) UILabel *pigDistanceLabel;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setModel:(BANewsModel *)model;

@end
