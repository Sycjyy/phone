//
//  SYCCateTableView.m
//  91助手
//
//  Created by sycjyy on 15/12/15.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCCateTableView.h"

@interface SYCCateTableView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSArray *items;

@end
@implementation SYCCateTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%@",[NSThread currentThread]);
            NSLog(@"开始加载数据");
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)2.0 *NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                NSLog(@"%@",[NSThread currentThread]);
                NSArray *testArr = @[@"test"];
                self.items = testArr;
                NSLog(@"加载数据完成");
                [self reloadData];
            });
        });
    }
    return self;
}

+ (instancetype)cateViewWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    SYCCateTableView *cateView = [[self alloc] initWithFrame:frame style:style];
    [cateView reloadData];
    return cateView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"游戏与应用";
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UISegmentedControl *cateView = [[UISegmentedControl alloc] initWithItems:@[@"应用",@"游戏"]];
    cateView.frame = CGRectMake(0, 0, 200, 30);
    return cateView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
