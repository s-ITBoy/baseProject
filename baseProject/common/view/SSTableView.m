//
//  SSTableView.m
//  baseProject
//
//  Created by apple on 2019/5/26.
//  Copyright © 2019 FL S. All rights reserved.
//

#import "SSTableView.h"
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
///若SSTableView无法自动获取cell高度（zxdata有值即可），且用户未自定义高度，则使用默认高度
static CGFloat const CELLDEFAULTH = 44;

@interface SSTaGetProName : NSObject
+ (NSMutableArray*)ss_getRecursionPropertyNames:(id)obj;
@end

@interface SSTaGetProName ()
@property(nonatomic,strong) NSMutableDictionary* proCacheMapper;
@end

@implementation SSTaGetProName

+ (instancetype)shareInstance {
    static SSTaGetProName* s_instance_dj_singleton = nil ;
    if (s_instance_dj_singleton == nil) {
        s_instance_dj_singleton = [[self alloc] init];
    }
    return (SSTaGetProName*)s_instance_dj_singleton;
}

+ (NSMutableArray *)ss_getPropertyNames:(id)obj {
    NSMutableDictionary *cacheMapper = [SSTaGetProName shareInstance].proCacheMapper;
    NSString *objCls = NSStringFromClass([obj class]);
    if ([cacheMapper.allKeys containsObject:objCls]) {
        return [cacheMapper[objCls] mutableCopy];
    }
    NSMutableArray *propertyNamesArr = [NSMutableArray array];
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([obj class],&count);
    for (NSUInteger i = 0;i < count;i++) {
        const char *propertyNameChar = property_getName(properties[i]);
        NSString *propertyNameStr = [NSString stringWithUTF8String: propertyNameChar];
        [propertyNamesArr addObject:propertyNameStr];
        
    }
    [cacheMapper setValue:[propertyNamesArr mutableCopy] forKey:objCls];
    return propertyNamesArr ;
}

+ (NSMutableArray *)ss_getRecursionPropertyNames:(id)obj {
    NSMutableArray *propertyNamesArr = [self ss_getPropertyNames:obj];
    if ([self isSysClass:obj]) return propertyNamesArr;
    Class class = [obj superclass];
    while (true) {
        if (![self isSysClass:[class new]]) {
            NSMutableArray *superclassproArr = [self ss_getPropertyNames:class];
            [propertyNamesArr addObjectsFromArray:superclassproArr];
        }else {
            break;
        }
        NSObject *obj = [class new];
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

@interface NSObject (SSTableV)
//@property (nonatomic, strong) NSNumber *ss_cellHRunTime;
///获取tableView中当前cell/model对应的indexPath
@property(strong, nonatomic)NSIndexPath *ss_indexPathInTableView;
///获取tableView中当前headerView/footerView/cell/model对应的section
@property(assign, nonatomic)NSUInteger ss_sectionInTableView;

@end
@implementation NSObject (SSTableV)

- (void)setSs_cellHRunTime:(NSNumber *)ss_cellHRunTime {
    objc_setAssociatedObject(self, @"ss_cellHRunTime",ss_cellHRunTime, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSNumber *)ss_cellHRunTime {
    return objc_getAssociatedObject(self, @"ss_cellHRunTime");
}

- (void)setSs_indexPathInTableView:(NSIndexPath *)ss_indexPathInTableView {
    objc_setAssociatedObject(self, @"ss_indexPathInTableView", ss_indexPathInTableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSIndexPath *)ss_indexPathInTableView {
    return objc_getAssociatedObject(self, @"ss_indexPathInTableView");
}

- (void)setSs_sectionInTableView:(NSUInteger)ss_sectionInTableView {
    objc_setAssociatedObject(self, @"ss_sectionInTableView", [NSNumber numberWithInteger:ss_sectionInTableView], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSUInteger)ss_sectionInTableView {
    return [objc_getAssociatedObject(self, @"ss_sectionInTableView") unsignedIntegerValue];
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

@interface SSTableView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation SSTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setSStableView];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setSStableView];
    }
    return self;
}

- (void)setSStableView {
    self.ssDatas = [NSMutableArray array];
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    ///ios11以后 解决上拉加载后屏幕自动滚动偏移问题 需加上下面三行代码
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.delegate = self;
    self.dataSource = self;
    
    self.ss_fixCellBlockAfterAutoSetModel = NO;
    self.ss_autoDeselectWhenSelected = YES;
//    self.ss_isAdaptiveCellHeight = YES;
}

#pragma mark -------- set -----------
- (void)ss_setCell:(UITableViewCell*)cell {
    
}

- (void)setSsDatas:(NSMutableArray *)ssDatas {
    _ssDatas = ssDatas;
    [self reloadData];
}

- (BOOL)isMultiDatas {
    return self.ssDatas.count && [[self.ssDatas objectAtIndex:0] isKindOfClass:[NSArray class]];
}

- (void)setSs_isAdaptiveCellHeight:(BOOL)ss_isAdaptiveCellHeight {
    ss_isAdaptiveCellHeight = ss_isAdaptiveCellHeight;
    if (ss_isAdaptiveCellHeight) {
        self.estimatedRowHeight = 10;
        self.ss_setCellHeightAtIndexPath = ^CGFloat(NSIndexPath * _Nonnull indexPath) {
            return UITableViewAutomaticDimension;
        };
    }
}

- (void)setSs_RowHeight:(CGFloat)ss_RowHeight {
    _ss_RowHeight = ss_RowHeight;
    self.ss_setCellHeightAtIndexPath = ^CGFloat(NSIndexPath * _Nonnull indexPath) {
        return ss_RowHeight;
    };
}

#pragma mark ------------ UITableView ---------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.ssDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.ssDataSource numberOfSectionsInTableView:tableView];
    }else {
        if (self.ss_setNumberOfSectionsInTableView) {
            return self.ss_setNumberOfSectionsInTableView(tableView);
        }
        return [self isMultiDatas] ? self.ssDatas.count : 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.ssDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.ssDataSource tableView:tableView numberOfRowsInSection:section];
    }else {
        if (self.ss_setNumberOfRowsInSection) {
            return self.ss_setNumberOfRowsInSection(section);
        }
        return [self isMultiDatas] ? [[self.ssDatas SSarrayAtIndex:section] count] : self.ssDatas.count;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.ssDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }else {
        id model = [self getModelAtIndexPath:indexPath];
        NSString* className = nil;
        Class cellClass = nil;
        if (self.ss_setCellClassAtIndexPath) {
            cellClass = self.ss_setCellClassAtIndexPath(indexPath);
            className = NSStringFromClass(cellClass);
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
        if (!cell) {
            if (cellClass) {
                cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:className];
            }else {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:className];
                cell.textLabel.text = @"Undefined Cell";
            }
        }
        if (model) {
            [cell ss_safeSetValue:indexPath forKey:INDEX];
            [model ss_safeSetValue:indexPath forKey:INDEX];
            [cell setValue:indexPath forKey:@"ss_indexPathInTableView"];
            [model setValue:indexPath forKey:@"ss_indexPathInTableView"];
            [cell setValue:[NSNumber numberWithInteger:indexPath.section] forKey:@"ss_sectionInTableView"];
            [model setValue:[NSNumber numberWithInteger:indexPath.section] forKey:@"ss_sectionInTableView"];
            CGFloat cellH = ((UITableViewCell *)cell).frame.size.height;
            if (cellH && ![[model ss_safeValueForKey:INDEX] floatValue]) {
                if([model respondsToSelector:NSSelectorFromString(CELLH)]){
                    [model ss_safeSetValue:[NSNumber numberWithFloat:cellH] forKey:CELLH];
                }else{
                    [model setValue:[NSNumber numberWithFloat:cellH] forKey:@"ss_cellHRunTime"];
                }
            }
            if (!self.ss_fixCellBlockAfterAutoSetModel) {
                !self.ss_getCellAtIndexPath ? : self.ss_getCellAtIndexPath(indexPath,cell,model);
            }
            NSArray *cellProNames = [SSTaGetProName ss_getRecursionPropertyNames:cell];
            BOOL cellContainsModel = NO;
            for (NSString *proStr in cellProNames) {
                if([proStr.uppercaseString containsString:DATAMODEL.uppercaseString]){
                    [cell ss_safeSetValue:model forKey:proStr];
                    cellContainsModel = YES;
                    break;
                }
            }
        }else {
            if (!self.ss_fixCellBlockAfterAutoSetModel) {
                !self.ss_getCellAtIndexPath ? : self.ss_getCellAtIndexPath(indexPath,cell,model);
            }
        }
        if (self.ss_fixCellBlockAfterAutoSetModel) {
            !self.ss_getCellAtIndexPath ? : self.ss_getCellAtIndexPath(indexPath,cell,model);
        }
        [self ss_setCell:cell];
        return cell;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.ssDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [self.ssDataSource tableView:tableView titleForHeaderInSection:section];
    }else {
        if (self.ss_setTitleForHeaderInSection) {
            return self.ss_setTitleForHeaderInSection(section);
        }
    }
    return nil;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([self.ssDataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.ssDataSource sectionIndexTitlesForTableView:tableView];
    }else {
        if (self.ss_setSectionIndexTitlesForTableView) {
            return self.ss_setSectionIndexTitlesForTableView(tableView);
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if ([self.ssDataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.ssDataSource tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }else {
        if (self.ss_setSectionForSectionIndex) {
            return self.ss_setSectionForSectionIndex(title,index);
        }
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        return UITableViewAutomaticDimension;
    }
    if ([self.ssDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.ssDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }else {
        if (self.ss_setCellHeightAtIndexPath) {
            return self.ss_setCellHeightAtIndexPath(indexPath);
        }else {
            id model = [self getModelAtIndexPath:indexPath];
            if(model) {
                CGFloat cellH = [[model ss_safeValueForKey:CELLH] floatValue];
                if(cellH) {
                    return cellH;
                }else {
                    return [[model valueForKey:@"ss_cellHRunTime"] floatValue];
                }
            }else {
                return CELLDEFAULTH;
            }
        }
        
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.ssDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }else {
        if (self.ss_willDisplayCell) {
            self.ss_willDisplayCell(indexPath, cell);
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.ssDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }else {
        if (self.ss_didEndDisplayingCell) {
            self.ss_didEndDisplayingCell(indexPath, cell);
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ss_autoDeselectWhenSelected) {
        [self deselectRowAtIndexPath:indexPath animated:YES];
    }
    if([self.ssDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.ssDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }else {
        id model = [self getModelAtIndexPath:indexPath];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        !self.ss_didSelectedAtIndexPath ? : self.ss_didSelectedAtIndexPath(indexPath,model,cell);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ssDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [self.ssDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }else {
        id model = [self getModelAtIndexPath:indexPath];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        !self.ss_didDeselectedAtIndexPath ? : self.ss_didDeselectedAtIndexPath(indexPath,model,cell);
    }
}

//滑动编辑
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ss_editActionsForRowAtIndexPath) {
        return self.ss_editActionsForRowAtIndexPath(indexPath);
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ss_editActionsForRowAtIndexPath) {
        NSArray *rowActionsArr = self.ss_editActionsForRowAtIndexPath(indexPath);
        if(rowActionsArr && ![rowActionsArr isKindOfClass:[NSNull class]] && rowActionsArr.count){
            return YES;
        }
    }
    return NO;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* headView = nil;
    if ([self.ssDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        headView = [self.ssDelegate tableView:tableView viewForHeaderInSection:section];
    }else {
        headView = [self getHeadViewOrFootViewInSection:section isHeadView:YES];
    }
    NSMutableArray* secArr = self.ssDatas.count ? [self isMultiDatas] ? self.ssDatas[section] :self.ssDatas : nil;
    !self.ss_getHeaderViewInSection ? : self.ss_getHeaderViewInSection(section,headView,secArr);
    [headView ss_safeSetValue:[NSNumber numberWithInteger:section] forKey:SECTION];
    [headView setValue:[NSNumber numberWithInteger:section] forKey:@"ss_sectionInTableView"];
    
    return secArr.count ? headView : nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* footView = nil;
    if ([self.ssDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        footView = [self.ssDelegate tableView:tableView viewForFooterInSection:section];
    }else {
        footView = [self getHeadViewOrFootViewInSection:section isHeadView:NO];
    }
    NSMutableArray* secArr = self.ssDatas.count ? [self isMultiDatas] ? self.ssDatas[section] :self.ssDatas : nil;
    !self.ss_getFooterViewInSection ? : self.ss_getFooterViewInSection(section,footView,secArr);
    [footView ss_safeSetValue:[NSNumber numberWithInteger:section] forKey:SECTION];
    [footView setValue:[NSNumber numberWithInteger:section] forKey:@"ss_sectionInTableView"];
    
    return secArr.count ? footView : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.ssDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.ssDelegate tableView:tableView heightForHeaderInSection:section];
    }else {
        if (self.ss_setHeaderClassInSection) {
            if (self.ss_setHeaderHeightInSection) {
                if (section < self.ssDatas.count || section == 0) {
                    return self.ss_setHeaderHeightInSection(section);
                }
            }else {
                if (section < self.ssDatas.count || section == 0) {
                    UIView *headerView = [self getHeadViewOrFootViewInSection:section isHeadView:YES];
                    return headerView.frame.size.height;
                }
            }
            return CGFLOAT_MIN;
        }else {
            if (self.ss_setHeaderHeightInSection) {
                return self.ss_setHeaderHeightInSection(section);
            }
            return CGFLOAT_MIN;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.ssDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.ssDelegate tableView:tableView heightForFooterInSection:section];
    }else {
        if (self.ss_setFooterClassInSection) {
            if (self.ss_setFooterHeightInSection) {
                if (section < self.ssDatas.count || section == 0) {
                    return self.ss_setFooterHeightInSection(section);
                }
            }else {
                if (section < self.ssDatas.count || section == 0) {
                    UIView *footView = [self getHeadViewOrFootViewInSection:section isHeadView:NO];
                    return footView.frame.size.height;
                }
            }
            return CGFLOAT_MIN;
        }else {
            if (self.ss_setFooterHeightInSection) {
                return self.ss_setFooterHeightInSection(section);
            }
            return CGFLOAT_MIN;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self.ssDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.ssDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }else {
        if (self.ss_willDisplayHeaderView) {
            self.ss_willDisplayHeaderView(section, view);
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    if([self.ssDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]){
        [self.ssDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }else{
        !self.ss_didEndDisplayingHeaderView ? : self.ss_didEndDisplayingHeaderView(section,view);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self.ssDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [self.ssDelegate tableView:tableView willDisplayFooterView:view forSection:section];
    }else {
        if (self.ss_willDisplayFooterView) {
            self.ss_willDisplayFooterView(section, view);
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
    if([self.ssDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]){
        [self.ssDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }else{
        !self.ss_didEndDisplayingFooterView ? : self.ss_didEndDisplayingFooterView(section,view);
    }
}

#pragma mark ------ UIScrollView ---------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //滚动事件
    if ([self.ssDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.ssDelegate scrollViewDidScroll:scrollView];
    }else {
        if (self.ss_scrollViewDidScroll) {
            self.ss_scrollViewDidScroll(scrollView);
        }
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    //缩放事件
    if ([self.ssDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.ssDelegate scrollViewDidZoom:scrollView];
    }else {
        !self.ss_scrollViewDidZoom ? : self.ss_scrollViewDidZoom(scrollView);
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    //滚动到顶部
    if ([self.ssDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.ssDelegate scrollViewDidScrollToTop:scrollView];
    }else {
        if (self.ss_scrollViewDidScrollToTop) {
            self.ss_scrollViewDidScrollToTop(scrollView);
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //开始拖拽
    if ([self.ssDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.ssDelegate scrollViewWillBeginDragging:scrollView];
    }else {
        if (self.ss_scrollViewWillBeginDragging) {
            self.ss_scrollViewWillBeginDragging(scrollView);
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //结束拖拽
    if ([self.ssDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.ssDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }else {
        if (self.ss_scrollViewDidEndDragging) {
            self.ss_scrollViewDidEndDragging(scrollView, decelerate);
        }
    }
}

#pragma mark ------- 获取对应indexPath的数据model --------
- (instancetype)getModelAtIndexPath:(NSIndexPath *)indexPath {
    id model = nil;;
    if ([self isMultiDatas]) {
        if (indexPath.section < self.ssDatas.count) {
            NSArray *sectionArr = self.ssDatas[indexPath.section];
            if (indexPath.row < sectionArr.count) {
                model = sectionArr[indexPath.row];
            }else {
                NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
            }
        }else {
            NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
        }
    }else {
        if (indexPath.row < self.ssDatas.count) {
            model = self.ssDatas[indexPath.row];
        }else {
            NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
        }
    }
    return model;
}

#pragma mark ----------- 根据section获取对应的headVeiw/footView -------------
- (UIView*)getHeadViewOrFootViewInSection:(NSInteger)section isHeadView:(BOOL)isHeadView {
    UIView* view = nil;
    Class viewClass = [self getHeadClassOrFootViewInSection:section isHeadView:isHeadView];
    if (!viewClass) {
        return nil;
    }
    view = [[viewClass alloc] init];
    return view;
}

- (Class)getHeadClassOrFootViewInSection:(NSInteger)section isHeadView:(BOOL)isHeadView {
    if (isHeadView) {
        if (self.ss_setHeaderClassInSection) {
            return self.ss_setHeaderClassInSection(section);
        }
    }else {
        if (self.ss_setFooterClassInSection) {
            return self.ss_setFooterClassInSection(section);
        }
    }
    return nil;
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
