//
//  BAMeViewCell.m
//  PigManager
//
//  Created by imac on 2018/7/4.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BAMeViewCell.h"

@implementation BAMeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableViewCell:(UITableView *)tableView {
    BAMeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeCellID"];
    if (!cell) {
        cell = [[BAMeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeCellID"];
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
