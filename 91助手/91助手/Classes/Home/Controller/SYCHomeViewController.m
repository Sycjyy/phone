//
//  SYCHomeViewController.m
//  91助手
//
//  Created by sycjyy on 15/11/26.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCHomeViewController.h"
#import "SYCLoadListController.h"
#import "SYCAppBaseViewController.h"
#import "SYCBaiduBarViewController.h"

#import "MJExtension.h"

#import "SYCHomePart.h"
#import "SYCDataRequestTool.h"

#import "SYCLoadListViewCell.h"
#import "SYCAppSpecialViewCell.h"
#import "SYCVLimitAndiMustewCell.h"
#import "SYCHeaderInSection.h"
#import "SYCHeaderInTableView.h"
#import "SYCAppButton.h"
#import "SYCRefreshView.h"

#import "SYCAppBaseItem.h"
#import "SYCAppBaseResult.h"
#import "SYCHeaderValue.h"



@interface SYCHomeViewController ()<SYCHeaderInSectionDelegate,SYCAppSpecialViewCellDelegate,SYCHeaderInTableViewDelegate,SYCVLimitAndiMustewCellDelegate>

@property (nonatomic, strong)NSMutableArray *parts;

@property (nonatomic, strong)NSMutableDictionary * partDict;

@property (nonatomic, strong)NSArray *values;

@property (nonatomic, weak)SYCHeaderInTableView *headerView;

@property (nonatomic, weak)SYCRefreshView *refreshView;
@end

@implementation SYCHomeViewController

#pragma mark - 懒加载
- (NSArray *)values{
    if (_values == nil) {
        _values = [NSArray array];
    }
    return _values;
}

- (NSMutableArray *)parts{
    if (_parts == nil) {
        _parts = [NSMutableArray array];
    }
    return _parts;
}

- (NSMutableDictionary *)partDict{
    if (_partDict == nil) {
        _partDict = [NSMutableDictionary dictionary];
    }
    return _partDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置title
    self.navigationItem.title = @"91助手";
    //cell分割线
    [self.tableView setSeparatorColor:[UIColor redColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    //测试添加刷新view
    SYCRefreshView *refreshView = [[SYCRefreshView alloc] initWithFrame:self.view.frame];
    refreshView.backgroundColor = [UIColor redColor];
    _refreshView = refreshView;
    [self.view addSubview:refreshView];
    
    //设置tableView的头控件
    [self setUpTableHeaderView];
    //加载数据
    [self loadHomePart];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:10 delay:10 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        NSLog(@"animation--one");
        _refreshView.hidden = YES;
    } completion:^(BOOL finished) {
        NSLog(@"animation--two");
        _refreshView.hidden = YES;
    }];
}
#pragma mark - 添加头控件
- (void)setUpTableHeaderView{
    
    SYCHeaderInTableView *headerView = [[SYCHeaderInTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW * 0.5)];
    _headerView = headerView;
    headerView.delegate = self;
    self.tableView.tableHeaderView = headerView;
}
#pragma mark - 加载首页数据
- (void)loadHomePart{
    
    [SYCDataRequestTool dataRequestWithSuccess:^(NSArray *values) {
        self.values = values;
        _headerView.values = values;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
    [SYCDataRequestTool dataRequestOfHomeParam:nil success:^(NSArray *parts) {
            self.parts = (NSMutableArray *)parts;
            for (SYCHomePart *part in self.parts) {
            [self loadAllPartsData:part];
        }
    } failure:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}
#pragma mark - 加载每组的数据
- (void)loadAllPartsData:(SYCHomePart *)part{
    //    NSLog(@"%s",__func__);
    
    [SYCDataRequestTool dataRequestOfHomeSubGroupPart:part withUrlStr:part.act success:^(NSDictionary *group) {
        [self.partDict addEntriesFromDictionary:group];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

#pragma mark - 设置头控件代理
- (void)headerLoadDataWith:(SYCHeaderValue *)value{
    
    SYCBaiduBarViewController *baiduBarVc = [[SYCBaiduBarViewController alloc] init];
    baiduBarVc.value = value;
    
    
//    SYCAppBaseItem *item = [[SYCAppBaseItem alloc] init];
//    item.name = value.Desc;
//    item.url = value.TargetUrl;
//    SYCLoadListController *listVc = [[SYCLoadListController alloc] init];
//    listVc.passItem = item;
//    NSLog(@"%@--%@",listVc.passItem.name,listVc.passItem.url);
    [self.navigationController pushViewController:baiduBarVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.parts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 2 || section == 3 ||section == 4) {
        return 1;
    }
    SYCHomePart *part = self.parts[section];
    NSArray *items = self.partDict[part.name];
    if (items.count > 10) {
        return 10;
    }else{
    return items.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYCHomePart *part = self.parts[indexPath.section];
    NSArray *items = self.partDict[part.name];
    SYCAppBaseItem *item = items[indexPath.row];
    
    if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3) {
        SYCVLimitAndiMustewCell *cell = [SYCVLimitAndiMustewCell cellWithTableview:tableView];
        cell.delegate = self;
        cell.items = items;
        return cell;
    }else if (indexPath.section == 4){
        SYCAppSpecialViewCell *cell = [SYCAppSpecialViewCell cellWithTableview:tableView];
        cell.delegate = self;
        cell.items =items;
        return cell;
    }else{
        SYCLoadListViewCell *cell = [SYCLoadListViewCell cellWithTableview:tableView];
        cell.item = item;
        return cell;
    }
}
#pragma mark - 限时和必备代理
- (void)appButtonLinkToBaseView:(SYCAppBaseItem *)item{
    NSLog(@"%s",__func__);
//    NSLog(@"%@",item);
    SYCAppBaseViewController *baseVc = [[SYCAppBaseViewController alloc] init];
    baseVc.item = item;
    [self presentViewController:baseVc animated:YES completion:^{
        
    }];
//    [self presentViewController:baseVc animated:YES completion:nil];
}
#pragma mark -应用专题代理
- (void)appSpecialWithItem:(SYCAppBaseItem *)item{
    SYCLoadListController *listVc = [[SYCLoadListController alloc] init];
    listVc.passItem = item;
    [self.navigationController pushViewController:listVc animated:YES];
//    [self presentViewController:listVc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3) {
        return 100;
    }else if (indexPath.section == 4){
        return self.view.bounds.size.width * 0.7;
    }else{
        return 67;
    }
}


#pragma mark - 设置组头View
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SYCHomePart *part = self.parts[section];
    CGRect viewRect = CGRectMake(0, 0, ScreenW, 40);
    SYCHeaderInSection *view = [[SYCHeaderInSection alloc] initWithFrame:viewRect];
    view.delegate = self;
    view.part = part;
    view.section = section;
    
    return view;
}
#pragma mark - 组头代理
- (void)headerLoadMoreData:(SYCHomePart *)part andUrl:(NSString *)moreUrl andSection:(NSInteger)section{
    
        SYCLoadListController *moreVc = [[SYCLoadListController alloc] init];
        moreVc.part = part;
        moreVc.moreUrl = moreUrl;
        
        [self.navigationController pushViewController:moreVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%s",__func__);
    
    SYCHomePart *part = self.parts[indexPath.section];
    NSArray *items = self.partDict[part.name];
    SYCAppBaseItem *item = items[indexPath.row];
    
    SYCAppBaseViewController *baseVc = [[SYCAppBaseViewController alloc] init];
    baseVc.item = item;
    
    [self presentViewController:baseVc animated:YES completion:^{
//        UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        view.backgroundColor = [UIColor redColor];
//        view.alpha = 0.8;
//        NSLog(@"one");
//        [baseVc.view insertSubview:view atIndex:baseVc.view.subviews.count];
////        [baseVc.view addSubview:view];
//        
        }];
//        [self.navigationController pushViewController:baseVc animated:YES];
//    }
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end
