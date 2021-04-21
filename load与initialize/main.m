//
//  main.m
//  load与initialize
//
//  Created by linker on 2021/4/13.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Person.h"
#import "Man.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
        /**
         调用顺序
         2021-04-13 10:24:36.430625+0800 load与initialize[29887:697783] Person Class = Person
         2021-04-13 10:24:36.480107+0800 load与initialize[29887:697783] I am a Person
         */
        
        NSLog(@"Man Class = %@",NSStringFromClass([Man class]));
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
