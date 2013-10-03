/************
 * NSString+Repeat.m - Returns a string repeated x number of times
 * Author: Ian Glen <ian@ianglen.me>
 ************/

#import "NSString+Repeat.h"

@implementation NSString (Repeat)

+ (NSString *)stringWithRepeatedString:(NSString *)string Times:(NSUInteger)times
{
    return [@"" stringByPaddingToLength:times * [string length] withString:string startingAtIndex:0];
}

@end
