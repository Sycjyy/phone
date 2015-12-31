//
//  SYCSearchViewController.m
//  91助手
//
//  Created by sycjyy on 15/11/26.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height


#import "SYCSearchViewController.h"

#import "SYCSearchSubView.h"
#import "SYCSearchBar.h"
#import "SYCCateTableView.h"

#import "NSArray+archive.h"

@interface SYCSearchViewController ()<UITextFieldDelegate,SYCSearchSubViewDelegate>

@property (nonatomic, weak)UITextField *searchBar;

@property (nonatomic, strong)NSMutableArray *recordBtn;

@property (nonatomic, weak)SYCSearchSubView *historyView;

@property (nonatomic, weak)SYCCateTableView *cateView;

@property (nonatomic, assign)CGRect hisRect;
@end

@implementation SYCSearchViewController

- (NSMutableArray *)recordBtn{
    if (_recordBtn == nil) {
        _recordBtn = [NSMutableArray array];
    }
    return _recordBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    SYCSearchBar *searchBar = [SYCSearchBar searchBarWithFrame:CGRectMake(0, 0, screenW - 30,35)];
    searchBar.delegate = self;
    _searchBar = searchBar;
    [self.navigationItem setTitleView:searchBar];
    
    [self setUpAllChildView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(justToSearchBar) name:@"testone" object:nil];
    
}


- (void)setUpAllChildView{
    NSLog(@"%s",__func__);
    NSArray *btnArr = @[@"输入法",@"播放器",@"黄历天气",@"相机",@"视频",@"QQ",@"浏览器",@"百度",@"91助手",@"导航",@"小说"];
    SYCSearchSubView *hotView = [SYCSearchSubView subViewsOfHotSearchWithFrame:CGRectMake(20, 0, screenW - 40, 300) andArray:btnArr];
    hotView.searchDelegate = self;
    [self.view addSubview:hotView];
    
    CGRect hisRect = CGRectMake(20, CGRectGetMaxY(hotView.frame), screenW - 40, 300);
    _hisRect = hisRect;
    _recordBtn = [NSArray unArchiveArray];
    if (_recordBtn.count != 0) {
        SYCSearchSubView *historyView = [SYCSearchSubView subViewsOfHistorySearchWithFrame:hisRect andArray:self.recordBtn];
        _historyView = historyView;
        [self.view addSubview:historyView];    
    }
}
#pragma mark - 点击热门搜索或搜索历史按钮方法（代理）
- (void)searchBarJumpToCateView:(UIButton *)btn{
    NSLog(@"%@",btn.titleLabel.text);
    _searchBar.text = btn.titleLabel.text;
    _recordBtn = [self updateWithStr:_searchBar.text];
    [NSArray saveWithObject:_recordBtn];
    self.searchBar.rightView.hidden = NO;
    NSLog(@"跳转到聊吧与应用");
    [self addTableView];
}
//添加tableView
- (void)addTableView{
    CGRect cateFrame = CGRectMake(0, 64, screenW, screenH - 120);
    SYCCateTableView *cateView = [[SYCCateTableView alloc] initWithFrame:cateFrame style:UITableViewStylePlain];
    [cateView addObserver:self forKeyPath:@"items" options:NSKeyValueObservingOptionNew context:nil];
    [cateView reloadData];
    _cateView = cateView;
    [self.view addSubview:cateView];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"%s---%@",__func__,change);
}
#pragma mark - 搜索历史的删除按钮
- (void)searchBarDeleteRecordArray{
    //这里会出现问题 有待修改
    [_historyView removeFromSuperview];
    [self.recordBtn removeAllObjects];
}
#pragma mark - 点击导航栏里右侧的删除按钮
- (void)justToSearchBar{
    _searchBar.text = nil;
    _searchBar.rightView.hidden = YES;
    [_cateView removeObserver:self forKeyPath:@"items" context:nil];
    [_cateView removeFromSuperview];
    [_historyView removeFromSuperview];
    _recordBtn = [NSArray unArchiveArray];
    SYCSearchSubView *historyView = [SYCSearchSubView subViewsOfHistorySearchWithFrame:_hisRect andArray:_recordBtn];
    historyView.searchDelegate = self;
    _historyView = historyView;
    [self.view addSubview:historyView];
}


- (NSMutableArray *)updateWithStr:(NSString *)string{
    for (NSString *str in _recordBtn) {
        if ([string isEqualToString:str]) {
            [_recordBtn removeObject:str];
            break;
        }
    }
    [_recordBtn insertObject:string atIndex:0];
    return _recordBtn;
}


#pragma mark - textField将要开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(backToPre)];
    [self.navigationItem setRightBarButtonItem:item];
//    self.searchBar.rightView.hidden = NO;
     NSLog(@"%s",__func__);
    return YES;
}
#pragma mark - 点击取消按钮方法
- (void)backToPre{
    
    NSLog(@"%s",__func__);
    _searchBar.rightView.hidden = YES;
    [self.searchBar endEditing:YES];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    _searchBar.rightView.hidden = NO;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.navigationItem.rightBarButtonItem = nil;
     NSLog(@"%s",__func__);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text || ![textField.text isEqualToString:@" "]) {
        _recordBtn = [self updateWithStr:textField.text];
        [NSArray saveWithObject:_recordBtn];
    }
//    _searchBar.rightView.hidden = YES;
    NSLog(@"跳转到应用和游戏");
    [self addTableView];
    
    [textField resignFirstResponder];
    NSLog(@"%s",__func__);
    return NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
