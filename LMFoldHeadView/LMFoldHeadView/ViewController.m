//
//  ViewController.m
//  LMFoldHeadView
//
//  Created by 刘明 on 16/7/29.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "ViewController.h"
#import "LMFoldHeadView.h"
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,LMFoldHeadViewDelegate>

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) NSMutableDictionary *foldInfoDic;


@property (nonatomic, strong)  NSArray *dateArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupContentTableView];
    
    self.title = @"LMFoldHeadView";
    
    //假数据  随便填
    self.dateArray = @[@"折叠内容关键点一:KVC动态记录折叠状态",@"折叠内容关键点二:代理熟练使用",@"折叠内容关键点三:属性的灵活运用"];
    
    for (int i = 0; i< self.dateArray.count; i++) {
        
        NSString *num = [NSString stringWithFormat:@"%zd",i];
        
        [self.foldInfoDic setObject:@"1" forKey:num];
        
    }
}

- (void)setupContentTableView{

    self.contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight) style:UITableViewStylePlain];
    
    [self.view addSubview:self.contentTableView];
    
    self.contentTableView.delegate       = self;
    self.contentTableView.dataSource     = self;
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
}

- (void)foldHeaderInSection:(NSInteger)SectionHeader {
    NSString *key = [NSString stringWithFormat:@"%d",(int)SectionHeader];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [_foldInfoDic setValue:fold forKey:key];
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:SectionHeader];
    [self.contentTableView reloadSections:set withRowAnimation:UITableViewRowAnimationLeft];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
     LMFoldHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headView"];
    
    if (!headView) {
        
        headView = [[LMFoldHeadView alloc] initWithReuseIdentifier:@"headView"];
    }
    
    [headView initWithStatus:YES section:section canFold:YES];
    headView.delegate = self;
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
    headView.openOrClose = folded;
    return headView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dateArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
 
    return folded?self.dateArray.count:0;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.dateArray[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}


- (NSMutableDictionary *)foldInfoDic{
    
    if (!_foldInfoDic) {
        
        _foldInfoDic = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    
    return _foldInfoDic;
}

@end
