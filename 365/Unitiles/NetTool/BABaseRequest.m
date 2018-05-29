//
//  BABaseRequest.m
//  365
//
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BABaseRequest.h"

@implementation BABaseRequest

- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(BABaseResponse *response))completion {
    BAWeakSelf(self);
    [[BARequestManager sharedManager] GET:URLString parameters:parameters completion:^(BABaseResponse *response) {
        if (!weakself) return ;
        !completion ?: completion(response);
    }];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(BABaseResponse *response))completion {
    BAWeakSelf(self);
    [[BARequestManager sharedManager] POST:URLString parameters:parameters completion:^(BABaseResponse *response) {
        if (!weakself) return ;
        !completion ?: completion(response);
    }];
}

@end
