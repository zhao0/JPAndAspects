//
//  ViewController.m
//  JPAndAspects
//
//  Created by zhao on 16/9/1.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ViewController.h"
#import "JPEngine.h"
#import "Aspects.h"

@interface MyClass : NSObject
- (void)test;
- (void)test2;
@end

@implementation MyClass

- (void)test {
    NSLog(@"MyClass origin log");
}

- (void)test2 {
    NSLog(@"MyClass test2 origin log");
}
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self aspects_hook];
    [self jp_hook];
    MyClass *a = [[MyClass alloc] init];
    [a test];
}

- (void)jp_hook {
    [JPEngine startEngine];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    
    [JPEngine evaluateScript:script];
}

- (void)aspects_hook {
    [MyClass aspect_hookSelector:@selector(test) withOptions:AspectPositionAfter usingBlock:^(id aspects) {
        NSLog(@"aspects log");
    } error:nil];
}

- (void)aspects_hook_test2 {
    [MyClass aspect_hookSelector:@selector(test2) withOptions:AspectPositionAfter usingBlock:^(id aspects) {
        NSLog(@"aspects test2 log");
    } error:nil];
}
@end
