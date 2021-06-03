//
//  SSCollectionView.m
//  baseProject
//
//  Created by apple on 2021/6/3.
//  Copyright © 2021 FL S. All rights reserved.
//

#import "SSCollectionView.h"

@interface SSCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) NSMutableArray* registerExistArr;
@end
@implementation SSCollectionView
#pragma mark --------- 懒加载 ---------
- (NSMutableArray *)registerExistArr {
    if (!_registerExistArr) {
        _registerExistArr = [NSMutableArray array];
    }
    return _registerExistArr;
}

///FIXME:------------
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self setSSCollectionView];
    }
    return self;
}

- (void)setSSCollectionView {
    self.ssDatas = [NSMutableArray arrayWithCapacity:0];
    
    self.delegate = self;
    self.dataSource = self;
}

- (BOOL)isMultiDatas {
    return self.ssDatas.count && [[self.ssDatas objectAtIndex:0] isKindOfClass:[NSArray class]];
}

- (void)setSsDatas:(NSMutableArray *)ssDatas {
    _ssDatas = ssDatas;
    [self reloadData];
}

#pragma mark ---------- UICollectionView -----------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.ssDataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        return [self.ssDataSource numberOfSectionsInCollectionView:collectionView];
    }
    if (self.ss_setNumberOfSectionsInCollectionView) {
        return self.ss_setNumberOfSectionsInCollectionView(collectionView);
    }
    return [self isMultiDatas] ? self.ssDatas.count : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.ssDataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        return [self.ssDataSource collectionView:collectionView numberOfItemsInSection:section];
    }
    if (self.ss_setNumberOfItemsInSection) {
        return self.ss_setNumberOfItemsInSection(section);
    }
    return [self isMultiDatas] ? [[self arrAtindex:section frome:self.ssDatas] count] : self.ssDatas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDataSource respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]) {
        return [self.ssDataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    NSString* className = nil;
    Class cellClass = nil;
    if (self.ss_setCellClassAtIndexPath) {
        cellClass = self.ss_setCellClassAtIndexPath(indexPath);
        className = NSStringFromClass(cellClass);
        if (![self.registerExistArr containsObject:className]) {
            [self registerClass:cellClass forCellWithReuseIdentifier:className];
            [self.registerExistArr addObject:className];
        }
    }
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:indexPath];
    id model = [self getModelAtIndexPath:indexPath];
    if (model) {
        
    }
    
    return cell;
}





#pragma mark ------- 获取对应indexPath的数据model --------
- (instancetype)getModelAtIndexPath:(NSIndexPath *)indexPath {
    id model = nil;
    if ([self isMultiDatas]) {
        if (indexPath.section < self.ssDatas.count) {
            NSArray* arr = [self arrAtindex:indexPath.section frome:self.ssDatas];
            if (indexPath.item < arr.count) {
                model = [arr objectAtIndex:indexPath.item];
            }else {
                NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
            }
        }else {
            NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
        }
    }else {
        if (indexPath.item < self.ssDatas.count) {
            model = [self.ssDatas objectAtIndex:indexPath.item];
        }else {
            NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
        }
    }
    return model;
}

- (NSArray*)arrAtindex:(NSInteger)index frome:(NSArray*)array {
    id object = [array objectAtIndex:index];
    if ([object isKindOfClass:[NSArray class]]) {
        return object;
    }
    return @[];
}

- (void)dealloc {
    self.delegate = nil;
    self.dataSource = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
