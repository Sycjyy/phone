//
//  GBCHomeTblController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//
#define screeenW [UIScreen mainScreen].bounds.size.width
#define screeenH [UIScreen mainScreen].bounds.size.height

#import "GBCHomeTblController.h"
#import "GBCHeaderTblController.h"
#import "GBCHomeNavController.h"
#import "GBCTblHeaderViewModel.h"
#import "GBCYyztModel.h"
#import "GBCHomeModel.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "GBCStatusCellFrame.h"
#import "GBCStatusHome.h"
#import "GBCStatuscell.h"
#import "GBCFreeCell.h"
#import "GBCYyztCell.h"
#import "GBCMoreTblViewController.h"
#import "GBCYyztMoreController.h"
#import "GBCDetailController.h"


@interface GBCHomeTblController () <UIScrollViewDelegate,GBCYyztCellDelegate,GBCFreeCellShowDetailDelegate>
@property (nonatomic,strong) AFHTTPRequestOperationManager *mgr;
@property (nonatomic,strong) NSMutableArray *arrHeader;
@property (nonatomic,strong) NSMutableArray *arrHome;
@property (nonatomic,strong) NSMutableArray *arrXsmf;
@property (nonatomic,strong) NSMutableArray *arrXsmfCell;
@property (nonatomic,strong) NSMutableArray *arrZjbb;
@property (nonatomic,strong) NSMutableArray *arrZjbbCell;
@property (nonatomic,strong) NSMutableArray *arrYyzt;
@property (nonatomic,strong) NSMutableArray *arrJptj;
@property (nonatomic,strong) NSMutableArray *arrHmcr;
@property (nonatomic,strong) NSMutableArray *arrBjtj;

@property (nonatomic,weak) UIScrollView *scroll;
@property (nonatomic,weak) UIPageControl *page;
@property (nonatomic,assign) NSUInteger picNum;

@end

@implementation GBCHomeTblController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView=[[UITableView alloc] initWithFrame:self.tableView.frame style:(UITableViewStyleGrouped)];
    tableView.sectionFooterHeight=0;
    self.tableView=tableView;

    [self.navigationItem setTitle:@"91助手"];
    [self loadHeaderViewData];
    [self loadHomeData];
    [self loadXsmfData];
    [self loadJptjData];
    [self loadZjbbData];
    [self loadYyztData];
    [self loadHmcrData];
    [self loadBjtjData];
    
}

- (void)loadHeaderViewData
{
    //加载数据
    self.mgr=[AFHTTPRequestOperationManager manager];
    [self.mgr GET:@"http://applebbx.sj.91.com/softs.ashx?adlt=1&spid=2&osv=8.2&places=1&imei=DC3D9A43-F22F-47D2-9CB1-F51AACEC1B47&dm=iPhone4,1&sv=3.1.3&act=222&pid=2&cuid=65f2d2d79dc229b68a466e6ca57dae2379b5af3a&nt=10&mt=1" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDict)
     {
         NSArray *arr=responseDict[@"Result"][0][@"Value"];
         self.picNum=arr.count;
         self.arrHeader=[NSMutableArray array];
         for (NSDictionary *dict in arr) {
             GBCTblHeaderViewModel *header=[GBCTblHeaderViewModel HeadWithDict:dict];
             [self.arrHeader addObject:header];
         }
         [self createScrollBtn];
         //重新加载tableview
         [self.tableView reloadData];

     } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         NSLog(@"%@",error.localizedDescription);
     }];
}

- (void)createScrollBtn
{
    //设置scrollview的高
    CGFloat height=150;
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screeenW, height)];
    self.scroll = scroll;
    //监听滚动
    scroll.delegate=self;
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.contentSize=CGSizeMake(screeenW*self.picNum, height);
    scroll.bounces=NO;
    scroll.pagingEnabled=YES;
    
    for (int i=0; i<self.picNum; i++) {
        GBCTblHeaderViewModel *header=self.arrHeader[i];
        
        UIButton *headerBtn=[[UIButton alloc] init];
        headerBtn.frame=CGRectMake(i*screeenW, 0, screeenW, height);
        NSURL *url=[NSURL URLWithString:header.LogoUrl];
        
        NSData *urlData=[NSData dataWithContentsOfURL:url];
        [headerBtn setBackgroundImage:[UIImage imageWithData:urlData] forState:(UIControlStateNormal)];
        [headerBtn setBackgroundImage:[UIImage imageWithData:urlData] forState:(UIControlStateHighlighted)];
        [scroll addSubview:headerBtn];
        headerBtn.tag=i;
        [headerBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        self.scroll=scroll;
    }
    self.tableView.tableHeaderView=scroll;
    //创建UIPageControl
    UIPageControl *pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(screeenW/2-50, 120, 100, 30)];
    self.page=pageControl;
    //设置总页数
    pageControl.numberOfPages=3;
    //设置非当前页面的颜色
    pageControl.pageIndicatorTintColor=[UIColor blackColor];
    //设置当前页面的颜色
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    [self.view addSubview:pageControl];
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeImg) userInfo:nil repeats:YES];

}

- (void)btnClick:(UIButton *)btn
{
    GBCHeaderTblController *headerView=[[GBCHeaderTblController alloc] init];
    GBCTblHeaderViewModel *header=self.arrHeader[btn.tag];
    headerView.TargetUrl=header.TargetUrl;
    headerView.title=header.Desc;
    [self.navigationController pushViewController:headerView animated:YES];
}

// 主页数据加载
- (void)loadHomeData
{
    self.mgr=[AFHTTPRequestOperationManager manager];
    [self.mgr GET:@"http://applebbx.sj.91.com/api/?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=1&imei=612976ff-5ec4-4e9c-9c8f-a5689cb586c9&spid=2&osv=8.4.1&dm=iphone7,2&sv=3.1.3&nt=10&mt=1&pid=2" parameters:nil success:^(AFHTTPRequestOperation * operation, NSDictionary *responseDict ) {
        NSArray *arr=responseDict[@"Result"][0][@"parts"];
        self.arrHome=[NSMutableArray array];
        for (NSDictionary *dict in arr) {
            GBCHomeModel *home=[GBCHomeModel homeWithDict:dict];
            [self.arrHome addObject:home];
            }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

#pragma mark - 限时免费数据加载
- (void)loadXsmfData
{
    self.mgr=[AFHTTPRequestOperationManager manager];
    [self.mgr GET:@"http://applebbx.sj.91.com/api/?act=246&spid=2&pid=2&mt=1&top=15" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseData) {
        NSArray *arr=responseData[@"Result"][@"items"];
        self.arrXsmf=[NSMutableArray array];
        self.arrXsmfCell=[NSMutableArray array];
        for (NSDictionary *dict in arr) {
            GBCStatusHome *xsmf=[GBCStatusHome statusWithDict:dict];
            GBCStatusCellFrame *cellFrame=[[GBCStatusCellFrame alloc] init];
            cellFrame.statusHome=xsmf;
            [self.arrXsmf addObject:xsmf];
            [self.arrXsmfCell addObject:cellFrame];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

#pragma mark - 精品推荐数据加载
- (void)loadJptjData
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr GET:@"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=244&imei=612976ff-5ec4-4e9c-9c8f-a5689cb586c9&spid=2&osv=8.4.1&dm=iphone7,2&sv=3.1.3&top=20&mt=1&nt=10&pid=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDict) {
        NSArray *arr=responseDict[@"Result"][@"items"];
        self.arrJptj=[NSMutableArray array];
        for (NSDictionary *dict in arr) {
            GBCStatusHome *jptj=[GBCStatusHome statusWithDict:dict];
            GBCStatusCellFrame *cellFrame=[[GBCStatusCellFrame alloc] init];
            cellFrame.statusHome=jptj;
            [self.arrJptj addObject:cellFrame];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}
#pragma mark - 装机必备数据加载
- (void)loadZjbbData
{
    self.mgr=[AFHTTPRequestOperationManager manager];
    [self.mgr GET:@"http://applebbx.sj.91.com/api/?act=236&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=15&mt=1&nt=10&pid=2" parameters:nil success:^(AFHTTPRequestOperation * operation, id responseDict) {
        NSArray *arr=responseDict[@"Result"][@"items"];
        self.arrZjbb=[NSMutableArray array];
        self.arrZjbbCell=[NSMutableArray array];
        for (NSDictionary *dict in arr) {
            GBCStatusHome *zjbb=[GBCStatusHome statusWithDict:dict];
            GBCStatusCellFrame *cellFrame=[[GBCStatusCellFrame alloc] init];
            cellFrame.statusHome=zjbb;
            [self.arrZjbb addObject:zjbb];
            [self.arrZjbbCell addObject:cellFrame];
        }
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError * error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}
#pragma mark - 应用专题数据加载
- (void)loadYyztData
{
    self.mgr=[AFHTTPRequestOperationManager manager];
    [self.mgr GET:@"http://applebbx.sj.91.com/soft/phone/tag.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=212&imei=612976ff-5ec4-4e9c-9c8f-a5689cb586c9&spid=2&osv=8.4.1&dm=iphone7,2&sv=3.1.3&nt=10&mt=1&pid=2" parameters:nil success:^(AFHTTPRequestOperation * operation, id responseDict) {
        NSArray *arr=responseDict[@"Result"];
        self.arrYyzt=[NSMutableArray array];
        for (NSDictionary *dict in arr) {
            GBCYyztModel *yyzt=[GBCYyztModel yyztWithDict:dict];
            [self.arrYyzt addObject:yyzt];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

#pragma mark - 黑马闯入数据加载
- (void)loadHmcrData
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr GET:@"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=245&imei=612976ff-5ec4-4e9c-9c8f-a5689cb586c9&spid=2&osv=8.4.1&dm=iphone7,2&sv=3.1.3&top=10&mt=1&nt=10&pid=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDict) {
        NSArray *arr=responseDict[@"Result"][@"items"];
        self.arrHmcr=[NSMutableArray array];
        for (NSDictionary *dict in arr) {
            GBCStatusHome *hmcr=[GBCStatusHome statusWithDict:dict];
            GBCStatusCellFrame *cellFrame=[[GBCStatusCellFrame alloc] init];
            cellFrame.statusHome=hmcr;
            [self.arrHmcr addObject:cellFrame];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}
#pragma mark - 编辑推荐数据加载
- (void)loadBjtjData
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr GET:@"http://applebbx.sj.91.com/soft/phone/list.aspx?skip=10&mt=1&spid=2&osv=8.4.1&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&dm=iPhone7,2&sv=3.1.3&act=244&nt=10&pid=2&top=10" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDict) {
        NSArray *arr=responseDict[@"Result"][@"items"];
        self.arrBjtj=[NSMutableArray array];
        for (NSDictionary *dict in arr) {
            GBCStatusHome *bjtj=[GBCStatusHome statusWithDict:dict];
            GBCStatusCellFrame *cellFrame=[[GBCStatusCellFrame alloc] init];
            cellFrame.statusHome=bjtj;

            [self.arrBjtj addObject:cellFrame];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offPoint=scrollView.contentOffset;
    NSUInteger page=(offPoint.x+self.view.bounds.size.width/2)/self.view.bounds.size.width;
    self.page.currentPage=page;
}

- (void)changeImg
{
    NSInteger pagePic=self.page.currentPage;
    if (pagePic==2) {
        pagePic=0;
    }
    else{
        pagePic++;
    }
    //根据图片索引设置当前scrollview的偏移量
    CGPoint point=CGPointMake(pagePic*screeenW, 0);
    //添加动画效果
    if (point.x==0) {
        self.scroll.contentOffset=point;
    }
    else
    {
        [self.scroll setContentOffset:point animated:YES];
    }
    self.page.currentPage=pagePic;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建一个view
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screeenW, 30)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel *titleLal=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
    //创建一个按钮
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-50, 5, 30, 20)];
    btn.tag=section;
    //设置按钮普通状态下的文字
    [btn setTitle:@"更多" forState:(UIControlStateNormal)];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    //设置按钮普通状态下的颜色
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(loadMoreView:) forControlEvents:UIControlEventTouchUpInside];
    //将子控件添加到新建的view中
    [view addSubview:titleLal];
    [view addSubview:btn];

    GBCHomeModel *home=self.arrHome[section];
    titleLal.text=home.name;
    return view;
}

- (void)loadMoreView:(UIButton *)btn
{
    GBCHomeModel *header=self.arrHome[btn.tag];
    
    if (btn.tag==3) {
        GBCYyztMoreController *yyztMore=[[GBCYyztMoreController alloc] init];
        yyztMore.arrYyzt=self.arrYyzt;
        yyztMore.title=header.name;
        [self.navigationController pushViewController:yyztMore animated:YES];
    }else{
    
        GBCMoreTblViewController *more=[[GBCMoreTblViewController alloc] init];
        more.title=header.name;
        if (btn.tag==0){
            more.arrMore=self.arrXsmfCell;
            
        }else if (btn.tag==1){
            more.arrMore=self.arrJptj;
            
        }else if (btn.tag==2){
            more.arrMore=self.arrZjbbCell;
            
        }else if (btn.tag==4){
            more.arrMore=self.arrHmcr;
            
        }else if (btn.tag==5){
            more.arrMore=self.arrBjtj;
            
        }
        [self.navigationController pushViewController:more animated:YES];
    }

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrHome.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==3) {
        return 1;
    }
    else{
    GBCHomeModel *home=self.arrHome[section];
    NSUInteger count=[home.uiType intValue];
    return count;
    }
}

#pragma mark - tableview代理方法 设置每组Header的高度 必须设置 否则不显示
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        GBCFreeCell *cell=[[GBCFreeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
        cell.arrXsmf=self.arrXsmf;
        cell.delegate=self;
        return cell;
    }
    
    else if (indexPath.section==1) {
        GBCStatuscell *cell=[GBCStatuscell cellWithTableView:tableView];
        cell.statusCellFrame=self.arrJptj[indexPath.row];
        return cell;
    }
    
    else if (indexPath.section==2) {
        GBCFreeCell *cell=[[GBCFreeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
        cell.arrXsmf=self.arrZjbb;
        cell.delegate=self;
        return cell;
        
    }
    else if (indexPath.section==3) {
        GBCYyztCell *cell=[[GBCYyztCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
        cell.arrYyzt=self.arrYyzt;
        cell.startNum=indexPath.row*2;
        cell.endNum=(indexPath.row+1)*4;
        cell.delegate=self;
        return cell;
    }
    else if (indexPath.section==4){
        GBCStatuscell *cell=[GBCStatuscell cellWithTableView:tableView];
        cell.statusCellFrame=self.arrHmcr[indexPath.row];
        return cell;
    }
    else if (indexPath.section==5){
        GBCStatuscell *cell=[GBCStatuscell cellWithTableView:tableView];
        cell.statusCellFrame=self.arrBjtj[indexPath.row];
        return cell;
    }
    else{
        UITableViewCell *cell;
        return cell;
    }
}

//每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0||indexPath.section==2) {
        return 85;
    }
    else if(indexPath.section==1) {
        GBCStatusCellFrame *cellFrame=self.arrJptj[indexPath.row];
        return cellFrame.cellHeight;
    }
    else if (indexPath.section==3){
        return 215;
    }
    else if (indexPath.section==4){
        GBCStatusCellFrame *cellFrame=self.arrHmcr[indexPath.row];
        return cellFrame.cellHeight;
    }
    else if (indexPath.section==5){
        GBCStatusCellFrame *cellFrame=self.arrBjtj[indexPath.row];
        return cellFrame.cellHeight;
    }
    else
    {
        return 0;
    }
}

- (void)sendArray:(NSArray *)array tag:(NSUInteger)tag
{
    GBCHeaderTblController *header=[[GBCHeaderTblController alloc] init];
    GBCYyztModel *yyzt=[[GBCYyztModel alloc] init];
    yyzt=array[tag];
    header.title=yyzt.name;
    header.TargetUrl=yyzt.url;
    [self.navigationController pushViewController:header animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GBCStatusCellFrame *status=[[GBCStatusCellFrame alloc] init];
    if (indexPath.section==1) {
        status=self.arrJptj[indexPath.row];
    }else if (indexPath.section==4){
        status=self.arrHmcr[indexPath.row];
    }
    else if (indexPath.section==5){
        status=self.arrBjtj[indexPath.row];
    }
    [self showDetailView:status.statusHome.detailUrl];
}
- (void)showDetailView:(NSString *)detailUrl
{
    GBCDetailController *detail=[[GBCDetailController alloc] init];
    detail.detailUrl=detailUrl;
    [self.navigationController presentViewController:detail animated:YES completion:nil];
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
