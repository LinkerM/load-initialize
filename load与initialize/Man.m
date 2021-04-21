//
//  Man.m
//  load与initialize
//
//  Created by linker on 2021/4/13.
//

#import "Man.h"

@implementation Man

+ (void)load {
    NSLog(@"I am Man..Load Function!");
}

- (void)manSay {
    NSLog(@"I am a man");
}

/**
 子类不实现initialize时，父类会执行数次
 2021-04-13 10:49:46.732304+0800 load与initialize[30481:716870] I am Person..initialize Function!
 2021-04-13 10:49:46.732433+0800 load与initialize[30481:716870] I am Person..initialize Function!
 */

//+ (void)initialize
//{
//    { NSLog(@"I am a Man..initialize Function!"); }
//}
@end
