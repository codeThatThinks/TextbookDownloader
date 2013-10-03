/************
 * NSString+Repeat.m - Returns a string repeated x number of times
 * Author: Ian Glen <ian@ianglen.me>
 ************/

#import <Foundation/Foundation.h>

@interface NSString (Repeat)

+ (NSString *)stringWithRepeatedString:(NSString *)string Times:(NSUInteger)times;

@end
