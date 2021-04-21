//
//  AppDelegate.m
//  load与initialize
//
//  Created by linker on 2021/4/13.
//

/**
load方法：
 个人理解：
    从方法名字来看，应该是在一个类进行加载的时候触发，不管这个类有没有触发。只要他被装载了，那么他就会执行这个方法。
    至于他什么时候被装载？我觉得应该是在这个类文件被第一次编译的时候。个人理解的编译其实就是由编译器静态的分析语法等是否符合标准的过程并将符合标准的语法翻译成机器语言（这也就是我们当语法不对的时候会出现报错，这个阶段是静态的，如果这里有些值是需要动态确定的，强烈建议请换个地方初始化吧）。
    尽管没有调用他，但是它们load方法执行了。所以说只要编译就会执行load方法。那么我们怎么知道文件会不会编译呢，其实在创建这个类的时候，Xcode自动已经帮我们把它添加到了Compile Sources里面（这里面的实现文件会在编译器编译阶段进行加载，也就是我们所说的load），具体位置就在Targets->Build Phases->Compile Source里面。
执行顺序：
    那么顺序为什么load方法会是Person优先，其次是Man，最后才是Man+load呢，load的开发文档中有这么两句话直接的阐明了它们的调用顺序
    A class’s +load method is called after all of its superclasses’ +load methods.
    一个类的load方法是在它所有的父类之后执行
    A category +load method is called after the class’s own +load method.
    一个类别的load方法是在自己的load方法之后执行
 总结：
    load方法不需要使用[super load]来显性调用父类的load方法，只要被添加到编译器就有执行
    不管子类有没有写load方法，父类的load都只会执行一次(说这句只是为了区别下面的initialize方法)
    load方法执行时候，系统为脆弱状态，如果我们在load里面需要调用其它类的实例对象(或类对象)的属性或者方法，必须要确保那个依赖类（这个依赖类可不是之前说的父类）的load方法执行完毕
 
 使用场景：
    见Person和Man类
 */

/**
 initialize方法
 个人理解：
    1、这个方法是当某个类第一次收到消息的时候触发其实objc的本质就是消息的传递
    2、这个可以当成一个单例方法，不过还是有些不同的，这里初始化的不是一个实例对象，而是一个类对象，因为类对象其实就是一个单例对象。
    3、如果没有用到该类，就算加载完毕也不会执行该方法的。这里与load是不同的
 执行顺序：
    Superclasses receive this message before their subclasses.
    父类会在子类之前收到这个消息
    The superclass implementation may be called multiple times if subclasses do not implement initialize
    如果子类没有实现这个方法，那么父类的实现将会被执行数次
 总结：
    1、initialize方法也不需要使用[super initialize]来显性调用父类的initialize方法，只有第一次调用该类的时候才会触发。
    2、如果子类实现了initialize方法，那么初始化时各自执行各自的initialize方法，如果子类没有实现initialize方法，那么就会自动调用父类的initialize方法
    3、initialize方法也是在一个安全线程中，也不需要编写复杂逻辑的代码。
 使用场景：
    见Person类
 */

/**
 测试一下
 //第一个呢:在子类的Student.m的load方法中写法如下,Person的load方法不实现:
 +(void)load
 {
     [Student class];
     [Person class];
 }
 第一个:load(Person) >> load(Student) >> initialize(Person) >> initalize(Student) (>>早于)
 第一次调用Person以及Student类对象是在Student 的load方法里面，那么父类Person会首先收到执行load的消息，所以第一个执行。
 还是a的前缀，第一次调用Person以及Student类对象是在Student 的load方法里面，所以Student的load方法是执行在他们所有的initialize方法之前的。
 initialize方法的执行顺序就是父类比子类先执行，所以最终顺序就是load(Person) >> load(Student) >> initialize(Person) >> initalize(Student)
 
 
 //第二个呢：在父类的Person.m的load方法中写法如下，Student的load方法不实现
 +(void)load
 {
     [Student class];
     [Person class];
 }
 第二个呢:load(Person) >> initalize(Person) >> initialize(Student) >> load(Student) (>>早于)
 第一次调用Person以及Student类对象是在Person 的load方法里面，那么父类Person会首先执行load的消息，所以第一个执行。
 在Person的load里面(这个时候Student的load方法是没有执行的，因为必须等到父类的load方法执行完毕之后才会执行子类的load方法，不信看上面的顺序描述呀)。
 在Person的load方法里面优先调用了Student对象，但根据initalize方法的执行顺序，所以Person的initalize方法优先，其次是Student的initalize方法
 */

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
