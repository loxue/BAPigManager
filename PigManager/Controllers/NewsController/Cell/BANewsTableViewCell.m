//
//  BANewsTableViewCell.m
//  PigManager
//
//  Created by imac on 2018/6/21.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BANewsTableViewCell.h"

@implementation BANewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        switch (self.cellStyle) {
            case 0:
            {
                self.cellStyle = BANewCellStyleNews;
                [self initNewCellSubviews];
            }
                break;
            case 1:
            {
                self.cellStyle = BANewCellStylePig;
                [self initPigCellSubviews];
            }
                
            default:
                break;
        }
    }
    
    return self;
}

- (void)initNewCellSubviews {
    _newsIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 20, 20)];
    _newsIconImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_newsIconImage];
    
    _newsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_newsIconImage.frame)+8, 0, KWindowWidth-(CGRectGetWidth(_newsIconImage.frame)-26), 50)];
    _newsTitleLabel.textColor = [UIResource get3e3e3eColor];
    _newsTitleLabel.font = MXFont15;
    [self addSubview:_newsTitleLabel];
}

- (void)initPigCellSubviews {
    _pigTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, KWindowWidth-10, 20)];
    _pigTitleLabel.textColor = [UIResource get3e3e3eColor];
    _pigTitleLabel.font = MXFont15;
    _pigTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_pigTitleLabel];

    _pigAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 200, 20)];
    _pigAddressLabel.textColor = [UIResource get3e3e3eColor];
    _pigAddressLabel.font = MXFont13;
    _pigAddressLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_pigAddressLabel];
    
    _pigDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, 200, 20)];
    _pigDistanceLabel.textColor = [UIResource get3e3e3eColor];
    _pigDistanceLabel.font = MXFont13;
    _pigDistanceLabel.text = @"pigDistanceLabel";
    _pigDistanceLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_pigDistanceLabel];
}

- (void)setModel:(BANewsModel *)model {
    _pigTitleLabel.text = @"pigTitleLabel";
    _pigAddressLabel.text = @"pigAddressLabel";
    _pigDistanceLabel.text = @"pigDistanceLabel";
    
    
    _newsTitleLabel.text = @"newsTitleLabel";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
