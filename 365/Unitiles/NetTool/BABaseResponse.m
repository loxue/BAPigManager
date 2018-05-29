//
//  BABaseResponse.m
//  365
//
//  Created by imac on 2018/5/28.
//  Copyright © 2018年 intj. All rights reserved.
//

#import "BABaseResponse.h"

@implementation BABaseResponse

- (NSString *)description {
    return [NSString stringWithFormat:@"\n状态吗: %zd,\n错误: %@,\n响应头: %@,\n响应体: %@", self.statusCode, self.error, self.headers, self.responseObject];
}

- (void)setError:(NSError *)error {
    _error = error;
    self.statusCode = error.code;
    self.errorMsg = error.localizedDescription;
}

@end
