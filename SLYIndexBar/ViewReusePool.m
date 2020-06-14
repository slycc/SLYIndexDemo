//
//  ViewReusePool.m
//  SLYIndexBar
//
//  Created by shirly.shi on 2020/6/13.
//  Copyright © 2020 shirly.shi. All rights reserved.
//  实现重用机制的类

#import "ViewReusePool.h"

@interface ViewReusePool()


/// 等待使用的队列
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;

/// 使用中的队列
@property (nonatomic, strong) NSMutableSet *usingQueue;

@end


@implementation ViewReusePool

-(instancetype)init {
    if (self = [super init]) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}

-(UIView *)dequeueReusableView {
    UIView *view = [_waitUsedQueue anyObject];
    if (!view) {
        return nil;
    }else {
        // 进行队列移动
        [_waitUsedQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}

-(void)addUsingView:(UIView *)view {
    if (!view) {
        return;
    }
    
    // 添加视图到使用中队列
    [_usingQueue addObject:view];
}

-(void)reset {
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        [_usingQueue removeObject:view];
        [_waitUsedQueue addObject:view];
    }
}

@end
