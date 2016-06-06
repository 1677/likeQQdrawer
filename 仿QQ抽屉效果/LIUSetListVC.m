//
//  LIUSetListVC.m
//  仿QQ抽屉效果
//
//  Created by 刘晓亮 
//  Copyright © 2016年 刘晓亮. All rights reserved.
//

#import "LIUSetListVC.h"

@interface LIUSetListVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray * dataArray;



@end


@implementation LIUSetListVC


-(NSArray *)dataArray{
    
    if (nil == _dataArray) {
        _dataArray = @[@"开通会员",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的相册",@"我的文件"];
    }
    return _dataArray;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableview = tableview;
    [self.view addSubview:tableview];
    tableview.backgroundColor = [UIColor redColor];
    
    tableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 150)];
    
    tableview.dataSource = self;
    tableview.delegate = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableview.transform = CGAffineTransformMakeTranslation(-100, 0);
}


#pragma mark - UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"reuse";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}



@end
