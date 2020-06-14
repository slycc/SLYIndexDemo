//
//  SLYIndexTableView.h
//  SLYIndexBar
//
//  Created by shirly.shi on 2020/6/3.
//  Copyright © 2020 shirly.shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLYIndexTableViewDataSource <NSObject>

-(NSArray <NSString *> *)indexTitleForIndexTableView:(UITableView *)tableView;

@end

@interface SLYIndexTableView : UITableView

@property (nonatomic, weak) id <SLYIndexTableViewDataSource> indexDataSource;

@end

