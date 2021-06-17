//
//  SSTableView.h
//  baseProject
//
//  Created by apple on 2019/5/26.
//  Copyright © 2019 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///自定义强大的tableView，实现低耦合、高聚合（自动动态的给对应的cell做模型数据赋值，模型数据参数命名必须包含”model“字符串）
@interface SSTableView : UITableView
#pragma mark -------- 数据设置 -------------
///声明cell的类
@property(nonatomic,copy) Class (^ss_setCellClassAtIndexPath)(NSIndexPath* indexPath);
///数据源，内部会根据数据源自动计算section及Item的数量，并依据此自动做数据模型赋值给cell,且根据模型数据中的cellH字段，自动设置行高，若无此字段，则自动cell的行高为cell.frame.size.height
@property(nonatomic,strong) NSMutableArray* ssDatas;
///设置section数量(非必须，若设置了，则内部自动设置section个数无效)
@property(nonatomic,copy) NSInteger (^ss_setNumberOfSectionsInTableView)(UITableView* tableView);
///设置对应section中row的数量(非必须，若设置了，则内部自动设置对应section中row的数量无效)
@property(nonatomic,copy) NSInteger (^ss_setNumberOfRowsInSection)(NSUInteger section);
///设置cell的高度(非必须，若设置了，则内部的自动计算高度无效)
@property(nonatomic,copy) CGFloat (^ss_setCellHeightAtIndexPath)(NSIndexPath* indexPath);
///设置返回每个索引的内容
@property(nonatomic,copy) NSString* (^ss_setTitleForHeaderInSection)(NSUInteger section);
///设置返回索引数组
@property(nonatomic,copy) NSArray<NSString*>* (^ss_setSectionIndexTitlesForTableView)(UITableView* tableView);
///设置索引对应的section
@property(nonatomic,copy) NSInteger (^ss_setSectionForSectionIndex)(NSString* title, NSInteger index);
///根据HeaderView类名设置HeaderView
@property(nonatomic,copy) Class (^ss_setHeaderClassInSection)(NSInteger section);
///根据FooterView类名设置FooterView
@property(nonatomic,copy) Class (^ss_setFooterClassInSection)(NSInteger section);
///设置HeaderView高度，非必须，若设置了则自动设置的HeaderView高度无效
@property(nonatomic,copy) CGFloat (^ss_setHeaderHeightInSection)(NSInteger section);
///设置FooterView高度，非必须，若设置了则自动设置的FooterView高度无效
@property(nonatomic,copy) CGFloat (^ss_setFooterHeightInSection)(NSInteger section);

///当选中cell的时候是否自动调用tableView的deselectRowAtIndexPath，默认为YES
@property(nonatomic,assign) BOOL ss_autoDeselectWhenSelected;
///是否自适应行高，非必须，若设置了则无需其它的行高设置（比如ss_setCellHeightAtIndexPath等）
@property(nonatomic,assign) BOOL ss_isAdaptiveCellHeight;
///行高，用于固定值得cell，若设置了，则无需其它的行高设置
@property(nonatomic,assign) CGFloat ss_RowHeight;


#pragma mark -------- 数据获取 -----------
///获取对应行的cell，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_getCellAtIndexPath)(NSIndexPath* indexPath, id cell, id model);
///获取对应section的headerView，把id改成对应类名即可无需强制转换，secArr为对应section的model数组
@property(nonatomic,copy) void (^ss_getHeaderViewInSection)(NSUInteger section, id headerView, NSMutableArray* secArr);
///获取对应section的footerView，把id改成对应类名即可无需强制转换，secArr为对应section的model数组
@property(nonatomic,copy) void (^ss_getFooterViewInSection)(NSUInteger section, id footerView, NSMutableArray* secArr);

#pragma mark -------- 事件相关 -----------
///选中某一行，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_didSelectedAtIndexPath)(NSIndexPath* indexPath, id model, id cell);
///取消选中某一行，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_didDeselectedAtIndexPath)(NSIndexPath* indexPath, id model, id cell);
///滑动编辑(例如：侧滑删除等)
@property(nonatomic,copy) NSArray<UITableViewRowAction*>* (^ss_editActionsForRowAtIndexPath)(NSIndexPath* indexPath);
///是否可编辑 非必须，当实现了滑动编辑ss_editActionsForRowAtIndexPath 则全部cell可编辑；也可设置此参数针对性的设置是否可编辑
@property(nonatomic,copy) BOOL (^ss_canEditRowAtIndexPath)(NSIndexPath* indexPath, id model);
///cell将要展示，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_willDisplayCell)(NSIndexPath* indexPath, id cell);
///cell已经展示，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_didEndDisplayingCell)(NSIndexPath* indexPath, id cell);
///headerView将要展示，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_willDisplayHeaderView)(NSInteger section, id headerView);
///headerView已经展示完毕，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_didEndDisplayingHeaderView)(NSInteger section, id headerView);
///footerView将要展示，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_willDisplayFooterView)(NSInteger section, id footerView);
///footerView已经展示完毕，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_didEndDisplayingFooterView)(NSInteger section, id footerView);
///scrollView滚动事件
@property(nonatomic,copy) void (^ss_scrollViewDidScroll)(UIScrollView* scrollView);
///scrollView缩放事件
@property(nonatomic,copy) void (^ss_scrollViewDidZoom)(UIScrollView* scrollView);
///scrollView滚动到顶部事件
@property(nonatomic,copy) void (^ss_scrollViewDidScrollToTop)(UIScrollView* scrollView);
///scrollView开始拖拽事件
@property(nonatomic,copy) void (^ss_scrollViewWillBeginDragging)(UIScrollView* scrollView);
///scrollView结束拖拽事件
@property(nonatomic,copy) void (^ss_scrollViewDidEndDragging)(UIScrollView* scrollView, BOOL willDecelerate);

///tableView的DataSource 设置为当前控制器即可重写对应数据源代理方法
@property(nonatomic,weak,nullable) id<UITableViewDataSource> ssDataSource;
///tableView的Delegate 设置为当前控制器即可重写对应代理方法
@property(nonatomic,weak,nullable) id<UITableViewDelegate> ssDelegate;

@end

NS_ASSUME_NONNULL_END
