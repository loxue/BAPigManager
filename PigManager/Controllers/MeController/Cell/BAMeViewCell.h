//
//  BAMeViewCell.h
//  PigManager
//  马彦春
//  Created by imac on 2018/7/4.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAMeViewCell : UITableViewCell

+ (instancetype)cellWithTableViewCell:(UITableView *)tableView;

- (void)setCellWithModel:(id)model;

@end
