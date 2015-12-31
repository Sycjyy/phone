//
//  SYCLoadListController.m
//  91助手
//
//  Created by sycjyy on 15/11/30.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCLoadListController.h"
#import "SYCAppBaseViewController.h"

#import "SYCLoadListViewCell.h"
#import "SYCAppSpecialSubViewCell.h"

#import "SYCAppBaseItem.h"
#import "SYCHomePart.h"
#import "SYCAppBaseItem.h"

#import "SYCDataRequestTool.h"
@interface SYCLoadListController ()

@property (nonatomic, strong)NSArray *items;

@end

@implementation SYCLoadListController

-(NSArray *)items{
    if (_items == nil) {
        _items = [NSArray array];
    }
    return _items;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self selectDataSource];
}

- (void)selectDataSource{
    if (self.passItem) {
        self.title = self.passItem.name;
        [SYCDataRequestTool dataRequestWithUrl:self.passItem.url success:^(NSArray *items) {
            self.items = items;
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
        }];
    }else if(self.part){
        self.title = self.part.name;
        [SYCDataRequestTool dataRequestOfHomeSubGroupPart:self.part withUrlStr:self.moreUrl success:^(NSDictionary *group) {
            self.items = group[self.part.name];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYCAppBaseItem *item = self.items[indexPath.row];
    
    if ([self.part.name isEqualToString:@"应用专题"]) {
        SYCAppSpecialSubViewCell *cell = [SYCAppSpecialSubViewCell cellWithTableview:tableView];
        cell.item = item;
        return cell;
    }else{
        SYCLoadListViewCell *cell = [SYCLoadListViewCell cellWithTableview:tableView];
        cell.item = item;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.part.name isEqualToString:@"应用专题"]) {
        return self.view.bounds.size.width / 2 + 65;
    }else{
    return 67;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SYCAppBaseItem *item = self.items[indexPath.row];
    if ([self.part.name isEqualToString:@"应用专题"]) {
        SYCLoadListController *listVc = [[SYCLoadListController alloc] init];
        listVc.passItem = item;
        [self.navigationController pushViewController:listVc animated:YES];
    }else{
        SYCAppBaseViewController *baseVc = [[SYCAppBaseViewController alloc] init];
        baseVc.item = item;
        [self presentViewController:baseVc animated:YES completion:nil];
    }

}

- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
