//
//  SYCCharViewController.m
//  91助手
//
//  Created by sycjyy on 15/11/26.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCCharViewController.h"

#import "SYCChatViewCell.h"

#import "SYCDataRequestTool.h"
#import "SYCChatItem.h"
#import "UIImageView+WebCache.h"

@interface SYCCharViewController ()

@property (nonatomic, strong)NSArray *items;
@end

@implementation SYCCharViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorColor:[UIColor blueColor]];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    if (self.item) {
        self.title = _item.name;
        [SYCDataRequestTool dataRequestWithChatUrl:self.item.act success:^(NSArray *items) {
            self.items = items;
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
        }];
    }else{
    
        [SYCDataRequestTool dataRequestWithChatUrl:@"http://applebbx.sj.91.com/api/?act=702&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2" success:^(NSArray *items) {
            self.items = items;
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
        }];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,10,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,10,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,80,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,80,0,0)];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self != self.navigationController.viewControllers[0]) {
        return nil;
    }else{
    NSString *titleStr = @"感兴趣的贴吧";
    return titleStr;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYCChatItem *item = self.items[indexPath.row];
    static NSString *ID = @"cell";
    
    SYCChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SYCChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.item = item;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@"six"]];
//    [cell.textLabel setText:item.name];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SYCChatItem *item = self.items[indexPath.row];
    if (self != self.navigationController.viewControllers[0]) {
        return;
    }
    SYCCharViewController *chatVc = [[SYCCharViewController alloc] init];
    chatVc.item = item;
    [self.navigationController pushViewController:chatVc animated:YES];
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
