//
//  ViewReusePool.h
//  SLYIndexBar
//
//  Created by shirly.shi on 2020/6/13.
//  Copyright © 2020 shirly.shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewReusePool : NSObject


/// 从重用池中取出一个可重用的view
- (UIView *)dequeueReusableView;


/// 向重用池中添加一个视图
- (void)addUsingView:(UIView *)view;


/// 重置方法，将当前使用中的视图移动到可重用队列中
- (void)reset;

@end

