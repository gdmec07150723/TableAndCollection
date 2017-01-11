//
//  TableViewController.m
//  TableViewAndCollection
//
//  Created by INTCO 王伟 on 2017/1/10.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "TableViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

static NSString * cID = @"cellID";
@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubViews];
}
- (void) setSubViews{

    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64) style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate   = self;
    
    [self.view addSubview:tableView];
}

// > 代理方法
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.text  = @"欲穷千里目，更上一层楼";
    }
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSInteger num = 1;
    UIView * header = [[UIView   alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    header.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 120, 40)];
    label.textAlignment = NSTextAlignmentCenter;

    label.text      = [NSString stringWithFormat:@"头视图-%ld",num++];
//    label.backgroundColor = [UIColor redColor];
    [header addSubview:label];
    return header;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Top  Bottom Middle
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

@end
