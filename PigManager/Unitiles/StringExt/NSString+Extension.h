
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (NSString *)appendDocumentDir;

- (NSString *)appendCacheDir;

- (NSString *)appendTempDir;

- (CGSize)sizeWithfont:(UIFont *)font maxWidth:(CGFloat)maxW;

- (CGSize)sizeWithfont:(UIFont *)font;

@end
