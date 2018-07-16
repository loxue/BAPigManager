//
//  BASemenCollectionDataCell.h
//  PigManager
//
//  Created by imac on 2018/7/13.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BASemenCollectionDataCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleDataLabel;
@property (nonatomic, strong) UILabel *pigSexLabel;
@property (nonatomic, strong) UILabel *pigKindLabel;
@property (nonatomic, strong) UILabel *semenCollectionCountLabel;
@property (nonatomic, strong) UILabel *pigHouseLabel;
@property (nonatomic, strong) UILabel *pigCurrentStateLabel;
@property (nonatomic, strong) UILabel *pigBirthLabel;
@property (nonatomic, strong) UILabel *pigNoteLabel;

@property (nonatomic, strong) UIButton *editBtn;

+ (instancetype)cellWithTableViewCell:(UITableView *)tableView;

- (void)setCellWithModel:(id)model;

@end
