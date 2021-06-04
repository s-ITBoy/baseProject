//
//  SSCollectionView.m
//  baseProject
//
//  Created by apple on 2021/6/3.
//  Copyright © 2021 FL S. All rights reserved.
//

#import "SSCollectionView.h"
#import <objc/runtime.h>

#pragma mark ----- 数据处理配置 -------
///model默认去匹配的cell高度属性名 若不存在则动态生成cellHRunTime的属性名
static NSString *const CELLH = @"cellH";
///cell会自动赋值包含“model”的属性
static NSString *const DATAMODEL = @"model";
///model与cell的index属性，存储当前model与cell所属的indexPath
static NSString *const INDEX = @"indexPath";
///headerView与footerView的section属性，存储当前headerView与footerView所属的section
static NSString *const SECTION = @"section";

@interface SSCoGetProName : NSObject
+ (NSMutableArray*)ss_getRecursionPropertyNames:(id)obj;
@end

@interface SSCoGetProName ()
@property(nonatomic, strong) NSMutableDictionary* proCacheMapper;
@end
@implementation SSCoGetProName

+ (instancetype)shareInstance {
    static SSCoGetProName* ssInstance = nil ;
    if (ssInstance == nil) {
        ssInstance = [[self alloc] init];
    }
    return ssInstance;
}

+ (NSMutableArray *)ss_getPropertyNames:(id)obj {
    NSMutableDictionary* cacheMapper = [SSCoGetProName shareInstance].proCacheMapper;
    NSString* objCls = NSStringFromClass([obj class]);
    if ([cacheMapper.allKeys containsObject:objCls]) {
        return [cacheMapper[objCls] mutableCopy];
    }
    NSMutableArray* propertyNamesArr = [NSMutableArray array];
    u_int count;
    objc_property_t* properties  = class_copyPropertyList([obj class],&count);
    for (NSUInteger i = 0;i < count;i++) {
        const char *propertyNameChar = property_getName(properties[i]);
        NSString *propertyNameStr = [NSString stringWithUTF8String: propertyNameChar];
        [propertyNamesArr addObject:propertyNameStr];
        
    }
    [cacheMapper setValue:[propertyNamesArr mutableCopy] forKey:objCls];
    return propertyNamesArr ;
}

+ (NSMutableArray *)ss_getRecursionPropertyNames:(id)obj {
    NSMutableArray* propertyNamesArr = [self ss_getPropertyNames:obj];
    if ([self isSysClass:obj]) return propertyNamesArr;
    Class class = [obj superclass];
    while (true) {
        if (![self isSysClass:[class new]]) {
            NSMutableArray* superclassproArr = [self ss_getPropertyNames:class];
            [propertyNamesArr addObjectsFromArray:superclassproArr];
        }else {
            break;
        }
        NSObject* obj = [class new];
        class = obj.superclass;
    }
    return propertyNamesArr;
}

+ (BOOL)superclassIsSysClass:(id)obj {
    return !([NSBundle bundleForClass:[obj superclass]] == [NSBundle mainBundle]);
}

+ (BOOL)isSysClass:(id)obj {
    return !([NSBundle bundleForClass:[obj class]] == [NSBundle mainBundle]);
}

- (NSMutableDictionary *)proCacheMapper {
    if (!_proCacheMapper) {
        _proCacheMapper = [NSMutableDictionary dictionary];
    }
    return _proCacheMapper;
}

@end

@interface NSObject (SSCollectionV)
///获取collectionView中当前cell/model对应的indexPath
@property(strong, nonatomic)NSIndexPath* ss_indexPathInCollectionView;
///获取collectionView中当前headerView/footerView/cell/model对应的section
@property(assign, nonatomic)NSUInteger ss_sectionInCollectionView;
@end
@implementation NSObject (SSCollectionV)

- (void)setSs_indexPathInCollectionView:(NSIndexPath *)ss_indexPathInCollectionView {
    objc_setAssociatedObject(self, @"ss_indexPathInCollectionView", ss_indexPathInCollectionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSIndexPath *)ss_indexPathInCollectionView {
    return objc_getAssociatedObject(self, @"ss_indexPathInCollectionView");
}

- (void)setSs_sectionInCollectionView:(NSUInteger)ss_sectionInCollectionView {
    objc_setAssociatedObject(self, @"ss_sectionInCollectionView", [NSNumber numberWithInteger:ss_sectionInCollectionView], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSUInteger)ss_sectionInCollectionView {
    return [objc_getAssociatedObject(self, @"ss_sectionInCollectionView") unsignedIntegerValue];
}


-(id)ss_safeValueForKey:(NSString *)key {
    if ([self hasKey:key]) {
        return [self valueForKey:key];
    }
    return nil;
}

-(void)ss_safeSetValue:(id)value forKey:(NSString *)key {
    if([self hasKey:key]) {
        [self setValue:value forKey:key];
    }
}

-(BOOL)hasKey:(NSString *)key {
    return [self respondsToSelector:NSSelectorFromString(key)];
}

@end

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
    
    self.backgroundColor = [UIColor clearColor];
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
        [cell ss_safeSetValue:indexPath forKey:INDEX];
        [model ss_safeSetValue:indexPath forKey:INDEX];
        [cell setValue:indexPath forKey:@"ss_indexPathInCollectionView"];
        [model setValue:indexPath forKey:@"ss_indexPathInCollectionView"];
        [cell setValue:[NSNumber numberWithInteger:indexPath.section] forKey:@"ss_sectionInCollectionView"];
        [model setValue:[NSNumber numberWithInteger:indexPath.section] forKey:@"ss_sectionInCollectionView"];
        
        NSArray* cellProNames = [SSCoGetProName ss_getRecursionPropertyNames:cell];
        BOOL cellContainsModel = NO;
        for (NSString *proStr in cellProNames) {
            if([proStr.uppercaseString containsString:DATAMODEL.uppercaseString]){
                [cell ss_safeSetValue:model forKey:proStr];
                cellContainsModel = YES;
                break;
            }
        }
    }
    !self.ss_getCellAtIndexPath ? : self.ss_getCellAtIndexPath(indexPath, cell, model);
    
    return cell;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(collectionView:shouldHighlightItemAtIndexPath:)]) {
        return [self.ssDelegate collectionView:collectionView shouldHighlightItemAtIndexPath:indexPath];
    }
    if (self.ss_shouldHighlightItemAtIndexPath) {
        return self.ss_shouldHighlightItemAtIndexPath(indexPath);
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(collectionView:didHighlightItemAtIndexPath:)]) {
        [self.ssDelegate collectionView:collectionView didHighlightItemAtIndexPath:indexPath];
    }
    if (self.ss_didHighlightItemAtIndexPath) {
        self.ss_didHighlightItemAtIndexPath(indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(collectionView:didUnhighlightItemAtIndexPath:)]) {
        [self.ssDelegate collectionView:collectionView didUnhighlightItemAtIndexPath:indexPath];
    }
    if (self.ss_didUnhighlightItemAtIndexPath) {
        self.ss_didUnhighlightItemAtIndexPath(indexPath);
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(collectionView:shouldSelectItemAtIndexPath:)]) {
        return [self.ssDelegate collectionView:collectionView shouldSelectItemAtIndexPath:indexPath];
    }
    if (self.ss_shouldSelectItemAtIndexPath) {
        return self.ss_shouldSelectItemAtIndexPath(indexPath);
    }
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(collectionView:shouldDeselectItemAtIndexPath:)]) {
        return [self.ssDelegate collectionView:collectionView shouldDeselectItemAtIndexPath:indexPath];
    }
    if (self.ss_shouldDeselectItemAtIndexPath) {
        self.ss_shouldDeselectItemAtIndexPath(indexPath);
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.ssDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
    if (self.ss_didSelectItemAtIndexPath) {
        self.ss_didSelectItemAtIndexPath(indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(collectionView:didDeselectItemAtIndexPath:)]) {
        [self.ssDelegate collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
    }
    if (self.ss_didDeselectItemAtIndexPath) {
        self.ss_didDeselectItemAtIndexPath(indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(collectionView:willDisplayCell:forItemAtIndexPath:)]) {
        [self.ssDelegate collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    }
    if (self.ss_willDisplayCell) {
        self.ss_willDisplayCell(indexPath, cell);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(collectionView:didEndDisplayingCell:forItemAtIndexPath:)]) {
        [self.ssDelegate collectionView:collectionView didEndDisplayingCell:cell forItemAtIndexPath:indexPath];
    }
    if (self.ss_didEndDisplayingCell) {
        self.ss_didEndDisplayingCell(indexPath, cell);
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:)]) {
        [self.ssDelegate collectionView:collectionView willDisplaySupplementaryView:view forElementKind:elementKind atIndexPath:indexPath];
    }
    if (self.ss_willDisplaySupplementaryView) {
        self.ss_willDisplaySupplementaryView(indexPath, view, elementKind);
    }
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

//防止越界处理
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
