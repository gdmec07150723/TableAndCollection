//
//  ViewController.m
//  TableViewAndCollection
//
//  Created by INTCO 王伟 on 2017/1/10.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"
#import "CTionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (IBAction)tableViewAction:(UIButton *)sender {
    
    TableViewController * tableVC = [[TableViewController alloc] init];
    
    [self presentViewController:tableVC animated:YES completion:nil];
}
- (IBAction)collectionViewAction:(UIButton *)sender {
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(60, 60);
    CollectionViewController * collectionVC = [[CollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    [self presentViewController:collectionVC animated:YES completion:nil];
}

- (IBAction)reCollectionAction:(UIButton *)sender {
    
    CTionViewController * cVC = [[CTionViewController alloc] init];
    
    [self presentViewController:cVC animated:YES completion:nil];
}

@end
