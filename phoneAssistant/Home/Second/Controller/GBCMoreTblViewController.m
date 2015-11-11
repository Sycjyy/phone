//
//  GBCMoreTblViewController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/25.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCMoreTblViewController.h"
#import "GBCStatuscell.h"
#import "GBCStatusCellFrame.h"
#import "GBCDetailController.h"


@interface GBCMoreTblViewController ()
@property (nonatomic,copy) NSString *navTitle;

@end

@implementation GBCMoreTblViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setButton];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrMore.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GBCStatuscell *cell=[GBCStatuscell cellWithTableView:tableView];
    cell.statusCellFrame=self.arrMore[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GBCStatusCellFrame *cellFrame=self.arrMore[indexPath.row];
    
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GBCStatusCellFrame *status=[[GBCStatusCellFrame alloc] init];
    status=self.arrMore[indexPath.row];
    NSLog(@"%@",status.statusHome.detailUrl);
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
