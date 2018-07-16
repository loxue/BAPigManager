//
//  BASemenCollectionDataCell.m
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BASemenCollectionDataCell.h"

@implementation BASemenCollectionDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableViewCell:(UITableView *)tableView {
    BASemenCollectionDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SemenCollectionDataCellID"];
    if (!cell) {
        cell = [[BASemenCollectionDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SemenCollectionDataCellID"];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return cell;
}


- (void)setCellWithModel:(id)model {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
