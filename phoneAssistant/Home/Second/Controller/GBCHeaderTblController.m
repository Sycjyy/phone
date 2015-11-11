//
//  GBCHeaderTblController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/8.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCHeaderTblController.h"
#import "AFHTTPRequestOperationManager.h"
#import "GBCStatuscell.h"
#import "GBCStatusCellFrame.h"
#import "GBCDetailController.h"


@interface GBCHeaderTblController ()
@property(nonatomic,strong) AFHTTPRequestOperationManager *mgr;
@property(nonatomic,strong) NSMutableArray *arrHome;


@end

@implementation GBCHeaderTblController

- (NSMutableArray *)arrHome
{
    if (_arrHome==nil) {
        _arrHome=[NSMutableArray array];
    }
    return _arrHome;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setButton];
    [self loadData];
}

- (void)setButton
{
    UIButton *leftButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"web_pre_nor"] forState:(UIControlStateNormal)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"web_pre_pre"] forState:(UIControlStateHighlighted)];
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=left;
    [leftButton addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];

}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData
{
    self.mgr=[AFHTTPRequestOperationManager manager];
    [self.mgr GET:self.TargetUrl parameters:nil success:^(AFHTTPRequestOperation * operation, id responseData) {
        NSArray *arr=responseData[@"Result"][@"items"];
        for (NSDictionary *dict in arr) {
            GBCStatusHome *home=[GBCStatusHome statusWithDict:dict];
            GBCStatusCellFrame *cellFrame=[[GBCStatusCellFrame alloc] init];
            cellFrame.statusHome=home;
            [self.arrHome addObject:cellFrame];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrHome.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GBCStatuscell *cell=[GBCStatuscell cellWithTableView:tableView];
    cell.statusCellFrame=self.arrHome[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GBCStatusCellFrame *cellFrame=self.arrHome[indexPath.row];
    return cellFrame.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GBCStatusCellFrame *status=[[GBCStatusCellFrame alloc] init];
    status=self.arrHome[indexPath.row];
    GBCDetailController *detail=[[GBCDetailController alloc] init];
    detail.detailUrl=status.statusHome.detailUrl;
    [self presentViewController:detail animated:YES completion:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
