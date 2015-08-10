//
//  ExpandTableViewController.m
//  ExpandTableView
//
//  Created by long on 15/7/14.
//  Copyright (c) 2015年 long. All rights reserved.
//

#import "ExpandTableViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation GroupDataModel

@synthesize groupTitle;
@synthesize groupData;

@end

@interface ExpandTableViewController () {

    UITableView *tableView;
    NSMutableArray *selectedArr;//控制列表是否被打开
}

@end

@implementation ExpandTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    // style必须是UITableViewStylePlain
    tableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.delegate   = self;
    tableView.dataSource = self;
    
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.tableHeaderView = [[UIView alloc] init];
    tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tableView];
    
    selectedArr = [[NSMutableArray alloc] init];
    
    [self loadGroupData];
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _arrayData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *indexStr = [NSString stringWithFormat:@"%ld", section];
    
    BOOL isFolder = [selectedArr containsObject:indexStr];
    NSInteger number = 0;
    if (!isFolder) {
        return 0;
    }else{
        GroupDataModel * array = [_arrayData objectAtIndex:section];
        return array.groupData.count;
    }
    
    return number;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UserCell";
    
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //只需要给当前分组展开的section 添加用户信息即可
    if ([selectedArr containsObject:[NSString stringWithFormat:@"%ld", indexPath.section]]) {
        GroupDataModel *group = [_arrayData objectAtIndex:indexPath.section];
        cell.textLabel.text = [group.groupData objectAtIndex:indexPath.row];
    }

    return cell;
}

#pragma mark -- Table view delegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor colorWithRed:232.0f/255  green:235.0f/255 blue:239.0f/255 alpha:1.0f];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 50)];
    
    GroupDataModel *group = [_arrayData objectAtIndex:section];
    titleLabel.text = group.groupTitle;
    
    [view addSubview:titleLabel];
    
    UILabel *buttomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5f, SCREEN_WIDTH, 0.5)];
    buttomLine.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 20, 18, 14, 7)];
    NSString *string = [NSString stringWithFormat:@"%ld",section];
    if ([selectedArr containsObject:string]) {
        imageView.frame = CGRectMake(self.view.frame.size.width - 25, 24, 14, 7);
        imageView.image=[UIImage imageNamed:@"pub_custom_folder.png"];
    }else{
        
        imageView.frame = CGRectMake(self.view.frame.size.width - 20, 18, 7, 14);
        imageView.image=[UIImage imageNamed:@"pub_custom_unfolder.png"];
        
    }
    [view addSubview:imageView];
    [view addSubview:buttomLine];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    button.tag = section;
    [button addTarget:self action:@selector(openSectioin:) forControlEvents:UIControlEventTouchDown];
    [view addSubview:button];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterSection:(NSInteger)section {
    
    return 0.0f;
}

-(void)openSectioin:(UIButton *)sender
{
    NSString *string = [NSString stringWithFormat:@"%ld", sender.tag];
    
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    if ([selectedArr containsObject:string])
    {
        [selectedArr removeObject:string];
    }
    else
    {
        [selectedArr addObject:string];
    }
    
    [tableView reloadData];
}

- (void)setArrayData:(NSArray *)arrayData {
    
    _arrayData = arrayData;
    [tableView reloadData];
}

- (void) loadGroupData {
    
    GroupDataModel *model0 = [[GroupDataModel alloc] init];
    model0.groupTitle = @"陕西省";
    model0.groupData = @[@"西安", @"宝鸡", @"咸阳", @"延安"];
    
    GroupDataModel *model1 = [[GroupDataModel alloc] init];
    model1.groupTitle = @"甘肃省";
    model1.groupData = @[@"兰州", @"平凉", @"天水", @"白银"];
    
    GroupDataModel *model2 = [[GroupDataModel alloc] init];
    model2.groupTitle = @"青海省";
    model2.groupData = @[@"西宁", @"德令哈", @"格尔木"];
    
    GroupDataModel *model3 = [[GroupDataModel alloc] init];
    model3.groupTitle = @"新疆省";
    model3.groupData = @[@"乌鲁木齐", @"阿克苏", @"阿勒泰", @"博乐"];
    
    GroupDataModel *model4 = [[GroupDataModel alloc] init];
    model4.groupTitle = @"西藏省";
    model4.groupData = @[@"拉萨", @"日喀则"];
    
    _arrayData = @[model0, model1, model2, model3, model4];
}

@end
