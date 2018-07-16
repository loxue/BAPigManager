
// 拼接路径分类
#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)appendDocumentDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

- (NSString *)appendCacheDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

- (NSString *)appendTempDir{
    NSString *path = NSTemporaryDirectory();
    return [self appendWithPath:path];
}

- (NSString *)appendWithPath:(NSString *)path{
    return [path stringByAppendingPathComponent:self];
}

- (CGSize)sizeWithfont:(UIFont *)font maxWidth:(CGFloat)maxW {
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];

    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithfont:(UIFont *)font {
    
    return [self sizeWithfont:font maxWidth:0];
}

@end
