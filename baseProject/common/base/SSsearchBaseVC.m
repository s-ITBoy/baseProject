//
//  SSsearchBaseVC.m
//  baseProject
//
//  Created by F S on 2020/12/16.
//  Copyright © 2020 FL S. All rights reserved.
//

#import "SSsearchBaseVC.h"
#import "SSnaviAndStatusBarV.h"
#import <Masonry.h>
//#import "DJsearchResultVC.h"

@interface SScollectHeaderReuseV : UICollectionReusableView
@property(nonatomic,strong) UIImageView* leftImgV;
@property(nonatomic,strong) UILabel* titleLab;
@property(nonatomic,strong) UIButton* rightBtn;
@end
@implementation SScollectHeaderReuseV
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.leftImgV = [SShelper SSimgeView:CGRectMake(ssscale(12), self.height/2-ssscale(20)/2, ssscale(20), ssscale(20)) imgName:nil];
        [self addSubview:self.leftImgV];
        
        self.titleLab = [SShelper SSlabel:[UIFont SSfont16] textAlignment:NSTextAlignmentLeft textColor:[UIColor SScolorWithHex666666] backgroundColor:nil];
        self.titleLab.frame = CGRectMake(self.leftImgV.maxXX+ssscale(12), 0, ssscale(90), self.height);
        [self addSubview:self.titleLab];
        
        self.rightBtn = [UIButton buttonWithType:0];
        self.rightBtn.frame = CGRectMake(self.width-ssscale(12)-ssscale(20), self.height/2-ssscale(20)/2, ssscale(20), ssscale(20));
        self.rightBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:self.rightBtn];
    }
    return self;
}

@end

@interface SSsearchBaseCollectCell : UICollectionViewCell
@property(nonatomic,strong) UILabel* titleLab;
@end
///到左边的距离
CGFloat heightForCell = 10;
@implementation SSsearchBaseCollectCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor SScolorWithHexString:@"#EBEEEF"];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        
        self.titleLab = [SShelper SSlabel:[UIFont SSfont12] textAlignment:NSTextAlignmentCenter textColor:[UIColor SScolorWithHex666666] backgroundColor:nil];
        [self addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
//        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

///返回当前cell
- (CGSize)sizeForCell {
    return CGSizeMake([self.titleLab sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + heightForCell*2, ssscale(26));
}

@end

@interface SSsearchBaseVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) SSnaviAndStatusBarV* naviView;
@property(nonatomic,strong) UICollectionView* collectV;
@property(nonatomic,strong) NSMutableArray* dataMuArr;
@end

@implementation SSsearchBaseVC
#pragma mark ------- 懒加载 ---------
- (SSnaviAndStatusBarV *)naviView {
    if (!_naviView) {
        _naviView = [[SSnaviAndStatusBarV alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, statusBarHeight+NaviBarHeight)];
        _naviView.backgroundColor = [UIColor whiteColor];
        _naviView.leftbtnImgStr = @"navi_back";
        _naviView.isHiddenSearchTFD = NO;
        [_naviView.searchTFD becomeFirstResponder];
//        _naviView.searchPlaceHolder = SSlocalStr(@"category_head_placeH", nil);
//        _naviView.searchLeftViewImgStr = @"search_left";
//        _naviView.searchBorderColor = [UIColor SSthemeGreen];
        
        _naviView.isHiddenrightBtn = NO;
        _naviView.rightBtnImgStr = @"navi_shopCar";
    }
    return _naviView;
}
- (UICollectionView *)collectV{
    if (!_collectV) {
        UICollectionViewFlowLayout* flowlayout = [[UICollectionViewFlowLayout alloc] init];
        _collectV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, statusBarHeight+NaviBarHeight, ScreenWidth, ScreenHeight-statusBarHeight-NaviBarHeight-tabBarBottomH) collectionViewLayout:flowlayout];
        _collectV.backgroundColor = [UIColor clearColor];
        _collectV.delegate = self;
        _collectV.dataSource = self;
        [_collectV registerClass:[SScollectHeaderReuseV class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SScollectHeaderReuseV class])];
        [_collectV registerClass:[SSsearchBaseCollectCell class] forCellWithReuseIdentifier:NSStringFromClass([SSsearchBaseCollectCell class])];
    }
    return _collectV;
}
- (NSMutableArray *)dataMuArr {
    if (!_dataMuArr) {
        _dataMuArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataMuArr;
}

///FIXME:--------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.hidden == NO) {
        self.navigationController.navigationBar.hidden = YES;
    }
//    [SShelper statusBarTextColor:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubV];
}

- (void)setSubV {
    weakly(self);
    [self.view addSubview:self.naviView];
    self.naviView.naviBlock = ^(NSInteger index) {
        if (index == 0) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    self.naviView.SSnaviSearchBlock = ^(NSString * _Nonnull text) {
        [weakSelf searchWithStr:text];
    };
    [self.view addSubview:self.collectV];
    
    for (int i=0; i<5; i++) {
        [self.dataMuArr addObject:@"qwer"];
    }
    [self.collectV reloadData];
}

#pragma mark ----------- UICollectionView --------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataMuArr.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSsearchBaseCollectCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSsearchBaseCollectCell class]) forIndexPath:indexPath];
    cell.titleLab.text = @"qwer";
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSsearchBaseCollectCell *cell = (SSsearchBaseCollectCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (!cell) {
        cell = [[SSsearchBaseCollectCell alloc] init];
    }
    cell.titleLab.text = @"qwer";
    return [cell sizeForCell];
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        SScollectHeaderReuseV *headerView = (SScollectHeaderReuseV *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SScollectHeaderReuseV class]) forIndexPath:indexPath];
        
        headerView.titleLab.text = @"历史搜索";
        headerView.leftImgV.image = [UIImage imageNamed:@"history"];
        [headerView.rightBtn setBackgroundImage:[UIImage imageNamed: @"lajitong"] forState:UIControlStateNormal];
        headerView.rightBtn.tag = indexPath.section;
        [headerView.rightBtn addTarget:self action:@selector(refreshOrDelete:) forControlEvents:UIControlEventTouchUpInside];
        
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    [self searchWithStr:@"qwer"];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

//FIXME: ---------按钮响应事件 --------------
- (void)refreshOrDelete:(UIButton*)btn{
    [self.view endEditing:YES];
    if (btn.tag == 0) {
        [self.dataMuArr removeAllObjects];
        [self.collectV reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }
}

- (void)searchWithStr:(NSString*)text {
//    DJsearchResultVC* result = [[DJsearchResultVC alloc] init];
//    result.keyStr = text;
//    [self.navigationController pushViewController:result animated:YES];
}

- (void)dealloc{
    self.collectV.delegate = nil;
    self.collectV.dataSource = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
