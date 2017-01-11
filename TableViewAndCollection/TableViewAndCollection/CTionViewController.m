//
//  CTionViewController.m
//  TableViewAndCollection
//
//  Created by INTCO 王伟 on 2017/1/10.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "CTionViewController.h"
#import "HeaderReusableView.h"
#import "LJCollectionViewFlowLayout.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define CELL_ID @"cellIdentiffier"
#define HEADER_ID @"headerIdentifier"
#define TABLECELL @"tableCell"
@interface CTionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
/** 左侧tableview */
@property (nonatomic,strong) UITableView * leftTableView;

@property(nonatomic,weak)  UICollectionView * collectionView;

@property (nonatomic,strong) NSArray * hArray;
@property (nonatomic,strong) NSArray * lArray;
/** 上滑标志 */
@property (nonatomic,assign) BOOL upFlag;
@end

@implementation CTionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setSubViews];
}
/** collection 的头部显示 */
-(NSArray *)hArray{
    if (_hArray == nil) {
        _hArray = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20];
    }
    return _hArray;
}
/** leftTable 的数据 */
-(NSArray *)lArray{

    if (_lArray == nil) {
        _lArray = @[@1];
    }
    return _lArray;
}
- (void) loadData{

    
}
#pragma mark - 懒加载tableview
-(UITableView *)leftTableView{

    if (_leftTableView == nil) {
        _leftTableView = [[UITableView  alloc] initWithFrame:CGRectMake(0, 64, 80, HEIGHT-64) style:UITableViewStylePlain];
        
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TABLECELL];
    }
    return _leftTableView;
}
- (void) setSubViews{
    // 借助 layout 实现header 漂浮
     LJCollectionViewFlowLayout * flowLayout = [[LJCollectionViewFlowLayout   alloc] init];
//    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.minimumLineSpacing  = 20;
    flowLayout.minimumInteritemSpacing = 30;
    flowLayout.headerReferenceSize = CGSizeMake(WIDTH-80, 30);
    
//     > 设置section 的上 下 左 右 间距
    flowLayout.sectionInset  = UIEdgeInsetsMake(20, 10, 0, 10);
   
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(80, 64, WIDTH-80, HEIGHT-64) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor grayColor];
    //>注册 cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
    //> 注册 header
    [collectionView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_ID];
    
    collectionView.dataSource = self;
    collectionView.delegate   = self;
    [self.view addSubview:collectionView];
    // > 添加tableView
    [self.view addSubview:self.leftTableView];
    
    
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 21;
}
#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TABLECELL];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.hArray[indexPath.row]];
    return cell;
}
#pragma mark - 选中左侧cell
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    // 根据左侧 滚动右侧
    [self collectionScrollBaseLeft:indexPath.row];
}

#pragma mark - 联合滚动
#pragma mark *** 根据左侧table 调整右侧collection的位置
- (void) collectionScrollBaseLeft:(NSInteger )index{
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index]  atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
}
#pragma mark *** 根据右侧的滚动，同步改变左侧的状态
- (void) leftSeclectChangeBaseCollectionDraging:(NSInteger)index{

    if (_collectionView.dragging) {
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
}
// ===========------collection 代理方法-----============
#pragma mark - collection代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 21;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.section);
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    cell.backgroundColor   = [UIColor cyanColor];
 
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    HeaderReusableView * header;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_ID forIndexPath:indexPath];
        header.title.text = [NSString stringWithFormat:@"%@",self.hArray[indexPath.section]];
    }
    return header;
}
#pragma mark *** collection 的 header即将显示
-(void) collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(nonnull UICollectionReusableView *)view forElementKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath{

    /** 根据header消失 “+1”即可? no */
//    NSLog(@"ttttt%ld",indexPath.section);
    if (!self.upFlag && collectionView.dragging) {//滑动导致的下滑
        NSLog(@"向下滑动");
        [self leftSeclectChangeBaseCollectionDraging:indexPath.section];
    }
    
//    NSLog(@"section:%ld",indexPath.section);
}
#pragma mark *** collection 的header消失
- (void) collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath{

    if (self.upFlag && collectionView.dragging) {// 滑动导致的上滑
        [self leftSeclectChangeBaseCollectionDraging:indexPath.section+1];
    }
    
}
#pragma mark - 判断屏幕的滚动方向 （上 、 下）
// 根据scroll 的滚动判断
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{

    static CGFloat lastOffsetY = 0;
    // 判断滑动的是 colletionView
    if (scrollView == self.collectionView) {
        
        self.upFlag = scrollView.contentOffset.y >lastOffsetY?YES:NO;
        
        lastOffsetY = scrollView.contentOffset.y;
    }
    
}


@end
