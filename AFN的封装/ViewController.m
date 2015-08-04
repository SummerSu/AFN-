//
//  ViewController.m
//  AFN的封装
//
//  Created by 刘雅楠 on 15/7/27.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ViewController.h"
#import "ShopListCell.h"
#import "ShopListModel.h"
#import "Parameter.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20) style:UITableViewStylePlain];
    
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    NSDictionary *par = [Parameter getLocationShopListWithCityID:@"北京市"];
    
//    [self locationHttpRequestWithParameters:par];
    
    [self locationDatasWithParameters:par];
    
}


//从模型类直接获取数据
- (void)locationDatasWithParameters:(NSDictionary *)parameters{
    NSLog(@"从模型获取数据");
    [ShopListModel getShopListDatasWithUrl:BDUrl_location parameters:parameters andBlock:^(NSArray *datas, NSError *error) {
        
        if (error == nil) {
            self.data = [NSMutableArray arrayWithArray:datas];
        }
        
        [_tableView reloadData];
    }];
}



//获取数据后再解析模型
- (void)locationHttpRequestWithParameters:(NSDictionary *)parameters{
    NSLog(@"请求数据");
    [AFRequest GetRequestWithUrl:BDUrl_location parameters:parameters andBlock:^(NSDictionary * Datas, NSError *error) {
        
        if (error == nil) {
            NSArray *contents = Datas[@"contents"];
            for (NSDictionary *dic in contents) {
                ShopListModel *model = [ShopListModel modelWithDic:dic];
                
                [_data addObject:model];
            }
            
            [_tableView reloadData];
        }
    }];
}

#pragma mark -- TableView的代理方法
- (ShopListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopListCell *cell = [ShopListCell cellWithTableView:tableView];
    ShopListModel *model = _data[indexPath.row];
    cell.model = model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
