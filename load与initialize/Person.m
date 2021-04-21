//
//  Person.m
//  load与initialize
//
//  Created by linker on 2021/4/13.
//

#import "Person.h"
#import "Man.h"
#import <objc/runtime.h>

static NSString * personName;

@implementation Person

+ (void)load {
    NSLog(@"I am Person..Load Function!");
    
    //实现personSay与manSay的方法交换
    Method personMethod = class_getInstanceMethod([Person class], NSSelectorFromString(@"personSay"));
    Method manMethod = class_getInstanceMethod([Man class], NSSelectorFromString(@"manSay"));
    method_exchangeImplementations(personMethod, manMethod);
    ///这个时候我们在ViewController的函数里面使用Man实例对象调用方法manSay,打印结果为I am a Person
}

- (void)personSay {
    NSLog(@"I am a Person");
}

/**
 runtime向这个类发送初始化消息的时候是线程安全的，所以也不需要在这个方法里面添加太复杂的逻辑，万一死锁呢，通常我们会在这里面对静态变量进行初始化
 */
+ (void)initialize {
    //判断一下防止子类方法没有调用时，父类方法调用多次
    if(self == [self class]) {
        NSLog(@"I am Person..initialize Function!");
        personName = @"PERSON";
    }
    
    /**
        super：
     使用super关键词调用方法，在runtime查找方法的实现时不会从当前类的方法列表进行查找，而是跳过了本类从父类的方法类表中查找。尽管执行的是父类的方法，但是方法的调用者(消息的发送者)依旧是当前类，
     2021-04-13 11:03:10.797807+0800 load与initialize[30745:727345] super class = Person
     2021-04-13 11:03:10.797943+0800 load与initialize[30745:727345] self class = Person
     */
    NSLog(@"super class = %@",NSStringFromClass([super class]));
    NSLog(@"self class = %@",NSStringFromClass([self class]));
}
@end
