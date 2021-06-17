//
//  SSthirdVC.m
//  baseProject
//
//  Created by F S on 2017/1/16.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSthirdVC.h"
#import "SSwindowView.h"
#import "SStipsAndHUD.h"
#import <Masonry.h>
#import "SSTableView.h"
#import "SSrightCollectCell.h"
#import "SSCollectionView.h"

@interface sstestModel : NSObject
@property(nonatomic,copy) NSString* name;
@property(nonatomic,assign) CGFloat cellH;
@end
@implementation sstestModel


@end

@interface sstestCell_1 : UITableViewCell
@property(nonatomic,strong) UILabel* testLab;
//@property(nonatomic,copy) sstestModel* model;
//@property(nonatomic,copy) NSString* modelStr;
@property(nonatomic,strong) NSDictionary* dicModel;

@end
@implementation sstestCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.testLab = [UILabel SSlabel:[UIFont SSfontWith:30] textColor:[UIColor SStitleColor51] backgroundColor:nil];
        self.testLab.numberOfLines = 0;
        [self addSubview:self.testLab];
        [self.testLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.bottom.right.mas_equalTo(-10);
        }];
    }
    return self;
}

//- (void)setModel:(sstestModel *)model {
//    _model = model;
//    self.testLab.text = model.name;
//}

//- (void)setModelStr:(NSString *)modelStr {
//    _modelStr = modelStr;
//    self.testLab.text = modelStr;
//}
- (void)setDicModel:(NSDictionary *)dicModel {
    _dicModel = dicModel;
    self.testLab.text = [dicModel SSstringForDicKey:@"name"];
}


@end

@interface SSthirdVC ()
//<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) SSTableView* stableV;
@property(nonatomic,strong) UICollectionView* rightcollectV;
@property(nonatomic,strong) NSArray* rightArray;

@property(nonatomic,strong) SSCollectionView* sscollctionV;
@end

@implementation SSthirdVC
#pragma mark ------ 懒加载 ----------
- (SSCollectionView *)sscollctionV {
    if (!_sscollctionV) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
//        flowLayout.minimumInteritemSpacing = 0;
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, ssscale(10), 0, ssscale(10));
//        flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
        flowLayout.itemSize = CGSizeMake(ssscale(86.5), ssscale(87.5));
//        flowLayout.itemSize = CGSizeMake((ScreenWidth-ScreenWidth*9/40)/3, 45);
//        flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth-ScreenWidth*0.7867, 55);
        _sscollctionV = [[SSCollectionView alloc] initWithFrame:CGRectMake(ScreenWidth*0.2133, 0, ScreenWidth*0.7867, ScreenHeight-statusBarHeight-NaviBarHeight-tabBarBottomH) collectionViewLayout:flowLayout];
    }
    return _sscollctionV;
}
- (UICollectionView *)rightcollectV{
    if (!_rightcollectV) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, ssscale(10), 0, ssscale(10));
        flowLayout.itemSize = CGSizeMake(ssscale(86.5), ssscale(87.5));
//        flowLayout.itemSize = CGSizeMake((ScreenWidth-ScreenWidth*9/40)/3, 45);
//        flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth-ScreenWidth*0.7867, 55);
        _rightcollectV = [[UICollectionView alloc] initWithFrame:CGRectMake(ScreenWidth*0.2133, 0, ScreenWidth*0.7867, ScreenHeight-statusBarHeight-NaviBarHeight-tabBarBottomH) collectionViewLayout:flowLayout];
        
        _rightcollectV.backgroundColor = [UIColor whiteColor];
//        _rightcollectV.delegate = self;
//        _rightcollectV.dataSource = self;
        [_rightcollectV registerClass:[SSrightCollectCell class] forCellWithReuseIdentifier:NSStringFromClass([SSrightCollectCell class])];
    }
    return _rightcollectV;
}
- (NSArray *)rightArray{
    if (!_rightArray) {
//        _rightArray = [NSArray array];
        _rightArray = @[@"家装",@"家装",@"家装",@"家装",@"家装",@"家装",@"家装",@"家装"];
    }
    return _rightArray;
}
- (SSTableView *)stableV {
    if (!_stableV) {
        _stableV = [[SSTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIHEIGHT-TabBarHeight) style:UITableViewStylePlain];
        _stableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _stableV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    
    [self setSStable];
//    [self.view addSubview:self.rightcollectV];
//    [self.rightcollectV reloadData];
    
//    [self.view addSubview:self.sscollctionV];
//    self.sscollctionV.ss_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nonnull indexPath) {
//        return [SSrightCollectCell class];
//    };
//    self.sscollctionV.ssDatas = [@[@"家装",@"家装",@"家装",@"家装",@"家装",@"家装",@"家装",@"家装"] mutableCopy];
}

- (void)testtipsHUD {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 88, 100, 50)];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtn {
    SStipsAndHUD* show = [[SStipsAndHUD alloc] init];
    show.backGroundColor = [UIColor whiteColor];
//    show.circleColor = [UIColor greenColor];
    [show SSshowLoadingSSHUD:4];
    
}

- (void)setSStable {
    [self ss_initUseSSTableView];
    self.ss_stableV.ss_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nonnull indexPath) {
        return [sstestCell_1 class];
    };
    self.ss_stableV.ss_willDisplayCell = ^(NSIndexPath * _Nonnull indexPath, sstestCell_1*  _Nonnull cell) {
        
    };
    self.ss_stableV.ss_editActionsForRowAtIndexPath = ^NSArray<UITableViewRowAction *> * _Nonnull(NSIndexPath * _Nonnull indexPath) {
        UITableViewRowAction *delAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//            [weakSelf.tableView.zxDatas removeObjectAtIndex:indexPath.row];
//            [weakSelf.tableView reloadData];
        }];
        if(indexPath.row == 0){
            return nil;
        }
        return @[delAction];
    };

    self.ss_stableV.ss_isAdaptiveCellHeight = YES;
    [self getdata];
}

- (void)getdata {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray* arr = [NSMutableArray array];
        for (NSUInteger i = 0;i < 3;i++) {
//            sstestModel* model = [[sstestModel alloc] init];
//            model.name = [NSString stringWithFormat:@"数字_%ld",i];
//            model.cellH = 90;
//            [arr addObject:model];
            
            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
            dic[@"name"] = [NSString stringWithFormat:@"数字_%ld",i];
//            dic[@"cellH"] = @(80);
            [arr addObject:dic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ss_stableV.ssDatas = [arr mutableCopy];
        });
    });
}

//#pragma mark --- UICollectionViewDelegate DataSource
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.rightArray.count;
//}
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
//    SSrightCollectCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSrightCollectCell class]) forIndexPath:indexPath];
////    cell.dic = [self.rightArray SSdicAtIndex:indexPath.item];
//
//    return cell;
//}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [self.view endEditing:YES];
////    self.searchTF.text = @"";
////    SSsearchResultVC* search = [[SSsearchResultVC alloc] init];
////    search.keyword = [[self.rightArray SSdicAtIndex:indexPath.item] SSstringForDicKey:@"opt_name"];
////    search.hidesBottomBarWhenPushed = YES;
////    [self.navigationController pushViewController:search animated:YES];
//
////    SSnewSecondVC* new = [[SSnewSecondVC alloc] init];
////    [self.navigationController pushViewController:new animated:YES];
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    UICollectionViewFlowLayout* flowlayout = (UICollectionViewFlowLayout*)collectionViewLayout;
//    if (flowlayout.minimumLineSpacing < 6) {
//        return 5;
//    }
//    return 15;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
