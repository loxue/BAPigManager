//
//  BAAddressModel.h
//  PigManager
//  马彦春
//  Created by imac on 2018/7/8.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAAddressModel : NSObject

@end

@class BAProvinceModel, BACityModel, BATownModel;

@interface BAProvinceModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *city;
@property (nonatomic, copy) NSString *code;

@end

@interface BACityModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *town;
@property (nonatomic, copy) NSString *code;

@end


@interface BATownModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;

@end

