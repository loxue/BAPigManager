//
//  BABaseRequest.h
//  365
//
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BABaseResponse;

@interface BABaseRequest : NSObject

- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(BABaseResponse *response))completion;

- (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(BABaseResponse *response))completion;

@end
