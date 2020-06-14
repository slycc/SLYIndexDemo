//
//  ViewController.m
//  SLYIndexBar
//
//  Created by shirly.shi on 2020/6/3.
//  Copyright © 2020 shirly.shi. All rights reserved.
//

#import "ViewController.h"
#import "SLYIndexTableView.h"

/// 是否是全面屏/刘海屏
#undef  kIsAllScreen
#define kIsAllScreen isAllScreen()

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SLYIndexTableViewDataSource>

@property (nonatomic, strong) SLYIndexTableView *indexTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *reloadButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.indexTableView];
    [self.view addSubview:self.reloadButton];
    
    
}


#pragma mark - tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"self.dataArray == %@",self.dataArray);
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    
    cell.textLabel.text = [self.dataArray[indexPath.row] stringValue];
    
    return cell;
    
}

-(NSArray<NSString *> *)indexTitleForIndexTableView:(UITableView *)tableView {
    static BOOL change = NO;
    
    if (change) {
        change = NO;
        return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K"];
    }else {
        change = YES;
        return @[@"A",@"B",@"C",@"D",@"E",@"F"];
    }
}


-(void)buttonClick:(UIButton *)sender {
    NSLog(@"reload data");
    [self.indexTableView reloadData];
}

#pragma mark - tool
bool isAllScreen(){
    static BOOL isAllScreen;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;
            isAllScreen = (!UIEdgeInsetsEqualToEdgeInsets(safeAreaInsets, UIEdgeInsetsZero) && safeAreaInsets.bottom > 0);
        } else {
            isAllScreen = NO;
        }
    });
    return isAllScreen;
}

#pragma mark - setter & getter
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 100; i++) {
            [_dataArray addObject:@(i)];
        }
        NSLog(@"tmpArray  ==  %@",_dataArray);
    }
    return _dataArray;
}
-(SLYIndexTableView *)indexTableView {
    if (!_indexTableView) {
        _indexTableView = [[SLYIndexTableView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height)];
        _indexTableView.backgroundColor = [UIColor whiteColor];
        _indexTableView.delegate = self;
        _indexTableView.dataSource = self;
        _indexTableView.indexDataSource = self;
        
    }
    return _indexTableView;
}

-(UIButton *)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (kIsAllScreen?20:0) + 50)];
        _reloadButton.backgroundColor = [UIColor yellowColor];
        [_reloadButton setTitle:@"reload data" forState:UIControlStateNormal];
        [_reloadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _reloadButton;;
}


@end
