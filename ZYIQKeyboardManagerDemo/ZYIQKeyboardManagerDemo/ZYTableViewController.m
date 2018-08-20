//
//  ZYTableViewController.m
//  ZYIQKeyboardManagerDemo
//
//  Created by 郑奕 on 2018/8/19.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYTableViewController.h"
#import "ZYScrollAndViewViewController.h"

@interface ZYTableViewController ()<UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ZYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Delegate
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableViewCell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZYScrollAndViewViewController *viewController = [[ZYScrollAndViewViewController alloc] initWithNibName:@"ZYScrollAndViewViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark - getter
-(NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"scrollView+view"];
    }
    return _dataSource;
}



@end
