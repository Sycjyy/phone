//
//  GBCChatTblController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCChatTblController.h"
#import "UIImageView+WebCache.h"
#import "GBCChatDataModel.h"

@interface GBCChatTblController ()

@property(nonatomic,strong) NSMutableArray *arrChatData;

@end

@implementation GBCChatTblController

- (NSMutableArray *)arrChatData
{
    if (_arrChatData==nil) {
        _arrChatData=[NSMutableArray array];
    }
    return _arrChatData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"聊吧";
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr GET:@"http://applebbx.sj.91.com/api/?act=702&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&spid=2&imei=612976ff-5ec4-4e9c-9c8f-a5689cb586c9&osv=8.4.1&dm=iphone7,2&sv=3.1.3&nt=10&mt=1&pid=2" parameters:nil success:^(AFHTTPRequestOperation * operation, NSDictionary *responseDict) {
        
        NSArray *arr=[NSArray array];
        arr=responseDict[@"Result"];
        for (NSDictionary *dict in arr) {
            GBCChatDataModel *chat=[GBCChatDataModel chatWithDict:dict];
            chat.name=dict[@"name"];
            chat.icon=dict[@"icon"];
            [self.arrChatData addObject:chat];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrChatData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID=@"chat";
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    GBCChatDataModel *chat=self.arrChatData[indexPath.row];
    cell.textLabel.text=chat.name;
    [cell.imageView sd_setImageWithURL:chat.icon placeholderImage:[UIImage imageNamed:@"Icon"]];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title=@"感兴趣的贴吧";
    return title;
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
