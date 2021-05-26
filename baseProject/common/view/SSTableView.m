//
//  SSTableView.m
//  baseProject
//
//  Created by apple on 2019/5/26.
//  Copyright © 2019 FL S. All rights reserved.
//

#import "SSTableView.h"
#import <objc/runtime.h>

#pragma mark - 数据处理配置
///model默认去匹配的cell高度属性名 若不存在则动态生成cellHRunTime的属性名
static NSString *const CELLH = @"cellH";
///cell会自动赋值包含“model”的属性
static NSString *const DATAMODEL = @"model";
///model与cell的index属性，存储当前model与cell所属的indexPath
static NSString *const INDEX = @"indexPath";
///若ZXBaseTableView无法自动获取cell高度（zxdata有值即可），且用户未自定义高度，则使用默认高度
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
@property (nonatomic, strong) NSNumber *cellHight;
@end
@implementation NSObject (SSTableV)

- (void)setCellHight:(NSNumber *)cellHight {
    objc_setAssociatedObject(self, @"cellHight",cellHight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)cellHight {
    return objc_getAssociatedObject(self, @"cellHight");
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
        
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
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
}

- (void)setSsDatas:(NSMutableArray *)ssDatas {
    _ssDatas = ssDatas;
    [self reloadData];
}

-(BOOL)isMultiDatas{
    return self.ssDatas.count && [[self.ssDatas objectAtIndex:0] isKindOfClass:[NSArray class]];
}

-(instancetype)getModelAtIndexPath:(NSIndexPath *)indexPath{
    id model = nil;;
    if([self isMultiDatas]){
        if(indexPath.section < self.ssDatas.count){
            NSArray *sectionArr = self.ssDatas[indexPath.section];
            if(indexPath.row < sectionArr.count){
                model = sectionArr[indexPath.row];
            }else{
                NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
            }
        }else{
            NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
        }
    }else{
        if(indexPath.row < self.ssDatas.count){
            model = self.ssDatas[indexPath.row];
        }else{
            NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
        }
    }
    return model;
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
            [model ss_safeSetValue:indexPath forKey:INDEX];
            [cell ss_safeSetValue:indexPath forKey:INDEX];
            CGFloat cellH = ((UITableViewCell *)cell).frame.size.height;
            if (cellH && ![[model ss_safeValueForKey:INDEX] floatValue]) {
                NSMutableArray *modelProNames = [SSTaGetProName ss_getRecursionPropertyNames:model];
                if([modelProNames containsObject:CELLH]){
                    [model ss_safeSetValue:[NSNumber numberWithFloat:cellH] forKey:CELLH];
                }else{
                    [model setCellHight:[NSNumber numberWithFloat:cellH]];
                }
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
        }
        
        !self.ss_getCellAtIndexPath ? : self.ss_getCellAtIndexPath(indexPath,cell,model);
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deselectRowAtIndexPath:indexPath animated:YES];
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
