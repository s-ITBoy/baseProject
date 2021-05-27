//
//  SSTableView.h
//  baseProject
//
//  Created by apple on 2019/5/26.
//  Copyright © 2019 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///自定义强大的tableView，实现低耦合、高聚合
@interface SSTableView : UITableView
#pragma mark -------- 数据设置 -------------
@property(nonatomic,strong) NSMutableArray* ssDatas;
///声明cell的类
@property (nonatomic, copy) Class (^ss_setCellClassAtIndexPath)(NSIndexPath *indexPath);
///设置section数量(非必须，若设置了，则内部自动设置section个数无效)
@property (nonatomic, copy) NSInteger (^ss_setNumberOfSectionsInTableView)(UITableView *tableView);
///设置对应section中row的数量(非必须，若设置了，则内部自动设置对应section中row的数量无效)
@property (nonatomic, copy) NSInteger (^ss_setNumberOfRowsInSection)(NSUInteger section);
///设置cell的高度(非必须，若设置了，则内部的自动计算高度无效)
@property (nonatomic, copy) CGFloat (^ss_setCellHeightAtIndexPath)(NSIndexPath *indexPath);
///设置返回每个索引的内容
@property (nonatomic, copy) NSString * (^ss_setTitleForHeaderInSection)(NSUInteger section);
///设置返回索引数组
@property (nonatomic, copy) NSArray<NSString *> * (^ss_setSectionIndexTitlesForTableView)(UITableView *tableView);
///设置索引对应的section
@property (nonatomic, copy) NSInteger (^ss_setSectionForSectionIndex)(NSString *title,NSInteger index);
///根据HeaderView类名设置HeaderView，写了此方法则ss_setHeaderViewInSection无效，无需实现ss_setHeaderHInSection，自动计算高度，若设置了，则ss_headerClassName无效
@property (nonatomic, copy) Class (^ss_setHeaderClassInSection)(NSInteger section);
///根据FooterView类名设置FooterView，写了此方法则ss_setFooterViewInSection无效，无需实现ss_setFooterHInSection，自动计算高度，若设置了，则ss_footerClassName无效
@property (nonatomic, copy) Class (^ss_setFooterClassInSection)(NSInteger section);

///设置HeaderView高度，非必须，若设置了则自动设置的HeaderView高度无效
@property (nonatomic, copy) CGFloat (^ss_setHeaderHeightInSection)(NSInteger section);
///设置FooterView高度，非必须，若设置了则自动设置的FooterView高度无效
@property (nonatomic, copy) CGFloat (^ss_setFooterHeightInSection)(NSInteger section);

///控制获取cell回调在获取model之后，默认为NO
@property(nonatomic, assign)BOOL ss_fixCellBlockAfterAutoSetModel;
///当选中cell的时候是否自动调用tableView的deselectRowAtIndexPath，默认为YES
@property(nonatomic, assign)BOOL ss_autoDeselectWhenSelected;


#pragma mark -------- 数据获取 -----------
///获取对应行的cell，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_getCellAtIndexPath)(NSIndexPath *indexPath,id cell,id model);


#pragma mark -------- 事件相关 -----------
///选中某一行，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_didSelectedAtIndexPath)(NSIndexPath *indexPath,id model,id cell);
///取消选中某一行，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_didDeselectedAtIndexPath)(NSIndexPath *indexPath,id model,id cell);
///cell将要展示，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_willDisplayCell)(NSIndexPath *indexPath,id cell);
///cell已经展示，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_didEndDisplayingCell)(NSIndexPath *indexPath,id cell);
///headerView将要展示，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_willDisplayHeaderView)(NSInteger section,id headerView);
///headerView已经展示完毕，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_didEndDisplayingHeaderView)(NSInteger section,id headerView);
///footerView将要展示，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_willDisplayFooterView)(NSInteger section,id footerView);
///footerView已经展示完毕，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_didEndDisplayingFooterView)(NSInteger section,id footerView);

///scrollView滚动事件
@property (nonatomic, copy) void (^ss_scrollViewDidScroll)(UIScrollView *scrollView);
///scrollView缩放事件
@property (nonatomic, copy) void (^ss_scrollViewDidZoom)(UIScrollView *scrollView);
///scrollView滚动到顶部事件
@property (nonatomic, copy) void (^ss_scrollViewDidScrollToTop)(UIScrollView *scrollView);
///scrollView开始拖拽事件
@property (nonatomic, copy) void (^ss_scrollViewWillBeginDragging)(UIScrollView *scrollView);
///scrollView结束拖拽事件
@property (nonatomic, copy) void (^ss_scrollViewDidEndDragging)(UIScrollView *scrollView, BOOL willDecelerate);

///tableView的DataSource 设置为当前控制器即可重写对应数据源方法
@property (nonatomic, weak, nullable) id <UITableViewDataSource> ssDataSource;
///tableView的Delegate 设置为当前控制器即可重写对应代理方法
@property (nonatomic, weak, nullable) id <UITableViewDelegate> ssDelegate;

@end

NS_ASSUME_NONNULL_END
