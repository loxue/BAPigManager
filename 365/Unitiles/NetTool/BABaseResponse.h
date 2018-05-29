//
//  BABaseResponse.h
//  365
//
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BABaseResponse : NSObject

/** <#digest#> */
@property (nonatomic, strong) NSError *error;

/** <#digest#> */
@property (nonatomic, copy) NSString *errorMsg;

/** <#digest#> */
@property (assign, nonatomic) NSInteger statusCode;

/** <#digest#> */
@property (nonatomic, copy) NSMutableDictionary *headers;

/** <#digest#> */
@property (nonatomic, strong) id responseObject;

@end
