//
//  ViewController.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/6.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "ViewController.h"
#import "NXHomePageModel.h"
#import "NXSelectIconViewController.h"


#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

#pragma mark - 懒加载

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:3];
        NXHomePageModel *model = [NXHomePageModel new];
        model.describ = @"使用UIImagePickerView选取头像";
        model.nextVC = @"NXSelectIconViewController";
        
        [_dataSource addObject:model];
        
    }
    return _dataSource;
}


#pragma mark - life cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHight) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"NXHomePageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NXHomePageModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text =model.describ;
    return cell;
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NXHomePageModel *model = self.dataSource[indexPath.row];
    UIViewController *nextVC = [[NSClassFromString(model.nextVC) alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
