//
//  GBCReviewTblController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCReviewTblController.h"
#import "UIImageView+WebCache.h"
#import "GBCReviewDataModel.h"
#import "MJRefresh.h"

@interface GBCReviewTblController ()
@property(nonatomic,strong)NSMutableArray *arrReviewData;

@end

@implementation GBCReviewTblController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView addHeaderWithTarget:self action:@selector(setStart)];
    [self.tableView headerBeginRefreshing];
    
}

- (void)setStart
{
    UISegmentedControl *seg=[[UISegmentedControl alloc] initWithItems:@[@"应用",@"游戏"]];
    seg.frame=CGRectMake(0, 0, 250, 30);
    [seg setTintColor:[UIColor whiteColor]];
    
    seg.selectedSegmentIndex=0;
    
    NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [seg setTitleTextAttributes:dict forState:(UIControlStateNormal)];
    self.navigationItem.titleView=seg;
    
    [self loadData:seg];
    [seg addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventValueChanged];
}

/**
 *  数据请求并获取的方法
 */
- (void)sendUrl:(NSString *)urlStr
{
    self.arrReviewData=nil;
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * operation, NSDictionary *dict)
     {
         NSArray *arr=[NSArray array];
         arr=dict[@"Result"];
         self.arrReviewData=[NSMutableArray array];
         for (NSDictionary *dict in arr) {
             GBCReviewDataModel *review=[GBCReviewDataModel ReviewWithDict:dict];
             review.name=dict[@"name"];
             review.icon=dict[@"icon"];
             review.summary=dict[@"summary"];
             [self.arrReviewData addObject:review];
         }
         [self.tableView reloadData];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error.localizedDescription);
     }];
    [self.tableView headerEndRefreshing];
}

//加载数据
- (void)loadData:(UISegmentedControl *)seg
{
    NSInteger index=seg.selectedSegmentIndex;
    NSString *application=@"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=213&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&pi=1&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2";
    NSString *game=@"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=218&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&pi=1&spid=2&imei=612976ff-5ec4-4e9c-9c8f-a5689cb586c9&osv=8.4.1&dm=iphone7,2&sv=3.1.3&nt=10&mt=1&pid=2";
    if (index==0) {
        [self sendUrl:application];
    }
    if (index==1) {
        [self sendUrl:game];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrReviewData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID=@"ID";
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
    }
    GBCReviewDataModel *review=self.arrReviewData[indexPath.row];
    cell.textLabel.text=review.name;
    cell.detailTextLabel.text=review.summary;
    
    [cell.imageView sd_setImageWithURL:review.icon placeholderImage:[UIImage imageNamed:@"defPic"]];
    
    return cell;
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
