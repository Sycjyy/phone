//
//  SYCReviewViewController.m
//  91助手
//
//  Created by sycjyy on 15/11/26.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCReviewViewController.h"

#import "SYCDataRequestTool.h"
#import "UIImageView+WebCache.h"

#import "SYCCatebaseItem.h"
#import "SYCCateItem.h"

@interface SYCReviewViewController ()

@property (nonatomic, weak)UISegmentedControl *cateView;

@property (nonatomic, strong)NSArray *items;

@end

@implementation SYCReviewViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUptitleView];
  
    
}

- (void)setUptitleView{
    UISegmentedControl *cateView = [[UISegmentedControl alloc]initWithItems:@[@"应用",@"游戏"]];
    cateView.frame = CGRectMake(0, 0, 250, 30);
    cateView.selectedSegmentIndex = 0;
    
    _cateView = cateView;
    [cateView setTintColor:[UIColor whiteColor]];
    
    [cateView setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} forState:UIControlStateNormal];
    [cateView addTarget:self action:@selector(loadDataToCate:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:cateView];
    [self loadDataToCate:cateView];
}

- (void)loadDataToCate:(UISegmentedControl *)cateView{
    NSLog(@"%s",__func__);
    NSUInteger index = cateView.selectedSegmentIndex;
    NSString *urlStr = nil;
    if (index == 0) {
        urlStr = @"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=213&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&pi=1&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2";
    }else if(index == 1){
        urlStr = @"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=218&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&pi=1&spid=2&imei=612976ff-5ec4-4e9c-9c8f-a5689cb586c9&osv=8.4.1&dm=iphone7,2&sv=3.1.3&nt=10&mt=1&pid=2";
    }
    
    [SYCDataRequestTool dataRequestWithUrlStr:urlStr param:@"cate" success:^(NSArray *items) {
        self.items = items;
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if (error) {
            if ([error.domain isEqualToString:@"NSURLErrorDomain"]) {
                NSLog(@"网络未连接");
            }
        }
    }];
    
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(5,15,5,5)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(5,15,5,5)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SYCCatebaseItem *item = self.items[indexPath.row];
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@"icon_default"]];
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.summary;
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}



@end
