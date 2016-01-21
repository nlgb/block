//
//  ViewController.m
//  block基本使用
//
//  Created by sw on 16/1/19.
//  Copyright © 2016年 sw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// block 作为属性
// 和int 类型属性一样
@property(nonatomic,assign) int age;
@property(nonatomic,copy) void(^blockName1)(); // 无参数无返回值的block作为属性
@property(nonatomic,copy) int(^blockName2)(int,int); // 有参数有返回值的block作为属性

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    [self test2];
    // 调用带有block参数的方法
    [self test3:^{
        // block作为参数
        // 这个代码块就为参数的值
        // 所以还需要在block参数所在的方法中对block这个参数进行调用才能够执行block中的代码
        NSLog(@"block作为参数被执行");
    }];
    
    int (^myBlock)(int,int) = ^(int val1,int val2){
        return val1 + val2;
    };
    [self test33:myBlock];
    
    // block作为返回值类型
    void (^block)() = [self test4];
    block();
    
}



// 1.block作为变量
- (void)test1
{
    int age = 10;
    // 和定义int类型变量一样，定义block也是 类型 变量名 = 变量值;
    // 唯一特殊的地方就是block类型变量值为一段代码块
    
    
    // 无参数无返回值类型block
    // 第一种方式
    //    void (^blockName)() = ^(void){
    //        NSLog(@"block 输出");
    //    };
    
    // 第二种方式
    // 省略void
    //    void (^blockName)() = ^(){
    //        NSLog(@"block 输出");
    //    };
    
    // 第三种方式
    // 省略()
    void (^blockName1)() = ^{
        NSLog(@"block 变量值");
    };
    // 调用block
    blockName1();
    
    // 有参数有返回值类型block
    int (^blockName2)(int,int) = ^(int value1,int value2){
        return value1 + value2;
    };
    
    int sum = blockName2(10,15);
    NSLog(@"%d",sum);
    
}

// 2.block作为属性
- (void)test2
{
    // 给block类型属性赋值
    self.blockName1 = ^{
        NSLog(@"给block类型属性赋值");
    };
    
    // 调用block类型属性
    self.blockName1();
    
    self.blockName2 = ^(int value1,int value2){
        return value1 + value2;
    };
    int sum = self.blockName2(20,30);
    NSLog(@"%d",sum);
}

// block 作为参数
- (void)test3:(void(^)())blockName
{
    // 这个方法被调用
    // 说明block已经作为参数被赋值
    // 所以执行block这个参数
    blockName();
}

- (void)test33:(int(^)(int val1,int val2))blockName
{
    // 这个方法被调用
    // 说明block已经作为参数被赋值
    // 所以执行block这个参数
    int sum = blockName(30,50);
    NSLog(@"%d",sum);
    
}

- (void)test
{
    [self test3:^{
        NSLog(@"block");
    }];
}

// block类型作为返回值类型
- (void(^)())test4
{
    //    NSLog(@"block作为返回值类型");
    return ^(){
        NSLog(@"block作为返回值类型");
    };
}

// block使用技巧：
/*
 BLOCK作为属性和BLOCK作为变量的声明方式是一样的。
 类比：
 int age = 10；
 @property(nonatomic,assign) int age;
 推出：
 void(^block)() = ^(){};
 @property(nonatomic,assign) void(^block)();
 
 BLOCK作为参数时候，需要将类型写在（）内部，block名称写在（）后面。block的参数也是类型的一部分，所以也要写在（）内部。
 类比：
 - (void)func:(int)value;
 - (void)func:(void(^)())block;
 
 BLOCK作为返回值只需要写明block的类型，不需要写block名字。
 类比：
 - (int)func;
 - (void(^)())func;
 */
@end
