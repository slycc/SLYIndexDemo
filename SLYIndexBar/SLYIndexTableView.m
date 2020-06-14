//
//  SLYIndexTableView.m
//  SLYIndexBar
//
//  Created by shirly.shi on 2020/6/3.
//  Copyright © 2020 shirly.shi. All rights reserved.
//

#import "SLYIndexTableView.h"
#import "ViewReusePool.h"

@interface SLYIndexTableView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) ViewReusePool *reusePool;

@end

@implementation SLYIndexTableView

-(void)reloadData {
    [super reloadData];
    
    // 避免索引条随着table滚动
    [self.superview insertSubview:self.containerView aboveSubview:self];
    
    [self.reusePool reset];
    
    [self reloadIndexBar];
}

- (void)reloadIndexBar {
    
    // 获取字母索引条的显示内容
    NSArray <NSString *> *arrayTitles = nil;
    if ([self.indexDataSource respondsToSelector:@selector(indexTitleForIndexTableView:)]) {
        arrayTitles = [self.indexDataSource indexTitleForIndexTableView:self];
    }
    
    // 判断字母索引条是否为空
    if (!arrayTitles || arrayTitles.count == 0) {
        self.containerView.hidden = YES;
    }
    
    
    for (int i = 0; i<arrayTitles.count; i++) {
        
        NSString *title = arrayTitles[i];
        
        // 从重用池中取一个button出来
        UIButton *button = (UIButton *)[self.reusePool dequeueReusableView];
        
        // 如果没有可重用的button, 就重新创建一个
        if (!button) {
            button = [[UIButton alloc] initWithFrame:CGRectZero];
            button.backgroundColor = [UIColor whiteColor];
            
            // 把button添加到使用中队列
            [self.reusePool addUsingView:button];
            NSLog(@"button 新创建");
        }else{
            NSLog(@"button 重用了");
        }
        
        [self.containerView addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        CGFloat bWidth = 60;
        CGFloat bHeight = self.frame.size.height / arrayTitles.count;
        button.frame = CGRectMake(0, i * bHeight, bWidth, bHeight);
    }
    
}

-(ViewReusePool *)reusePool {
    if (!_reusePool) {
        _reusePool = [[ViewReusePool alloc] init];
    }
    return _reusePool;
}

-(UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor purpleColor];
        CGFloat bWidth = 60;
        _containerView.frame = CGRectMake(self.frame.size.width -bWidth , self.frame.origin.y, bWidth, self.frame.size.height);
    }
    return _containerView;
}

@end
