//
//  SSCollectionView.h
//  baseProject
//
//  Created by apple on 2021/6/3.
//  Copyright © 2021 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///自定义强大的collectionView，实现低耦合、高聚合（自动动态的给对应的cell做模型数据赋值，模型数据参数命名必须包含”model“字符串）
@interface SSCollectionView : UICollectionView
#pragma mark -------- 数据设置 -------------
///声明cell的类
@property(nonatomic,copy) Class (^ss_setCellClassAtIndexPath)(NSIndexPath* indexPath);
///数据源，内部会根据数据源自动计算section及Item的数量，并依据此自动做数据模型赋值给cell
@property(nonatomic,strong) NSMutableArray* ssDatas;
///设置section数量(非必须，若设置了，则内部自动设置section个数无效)
@property(nonatomic,copy) NSInteger (^ss_setNumberOfSectionsInCollectionView)(UICollectionView* collectionView);
///设置对应section中row的数量(非必须，若设置了，则内部自动设置对应section中row的数量无效)
@property(nonatomic,copy) NSInteger (^ss_setNumberOfItemsInSection)(NSUInteger section);
///设置对应section的HeaderView，非必须
@property(nonatomic,copy) UICollectionReusableView* (^ss_setHeaderViewInSection)(NSInteger section);
///设置对应section的FootView，非必须
@property (nonatomic, copy) UICollectionReusableView* (^ss_setFooterViewInSection)(NSInteger section);

///设置item的size，非必须，若设置了此参数，则flowlayout.itemSize的设置无效
@property(nonatomic,copy) CGSize (^ss_sizeForItemAtIndexPath)(NSIndexPath* indexPath, UICollectionView* collectionView);
///设置上下左右的内缩进，非必须，若设置了此参数，则flowlayout.sectionInset的设置无效
@property(nonatomic,copy) UIEdgeInsets (^ss_insetForSectionAtIndex)(NSInteger section, UICollectionView* collectionView);
///设置cell的行间距，非必须，若设置了此参数，则flowlayout.minimumLineSpacing的设置无效
@property(nonatomic,copy) CGFloat (^ss_minimumLineSpacingForSectionAtIndex)(NSInteger section, UICollectionView* collectionView);
///设置cell的列间距，非必须，若设置了此参数，则flowlayout.minimumInteritemSpacing的设置无效
@property(nonatomic,copy) CGFloat (^ss_minimumInteritemSpacingForSectionAtIndex)(NSInteger section, UICollectionView* collectionView);
///设置分区头视图的size，非必须，若设置了此参数，则flowlayout.headerReferenceSize的设置无效
@property(nonatomic,copy) CGSize (^ss_referenceSizeForHeaderInSection)(NSInteger section, UICollectionView* collectionView);
///设置分区尾试图的size，非必须, 若设置了此参数，则flowlayout.footerReferenceSize的设置无效
@property(nonatomic,copy) CGSize (^ss_referenceSizeForFooterInSection)(NSInteger section, UICollectionView* collectionView);

#pragma mark -------- 数据获取 -----------
///获取对应行的cell，把id改成对应类名即可无需强制转换，非必须
@property(nonatomic,copy) void (^ss_getCellAtIndexPath)(NSIndexPath* indexPath, id cell, id model);
///获取对应section的headerView secArr为对应section的model数组，非必须
@property(nonatomic,copy) void (^ss_getHeaderViewInSection)(NSInteger section,id headerView,id model);
///获取对应section的footerView secArr为对应section的model数组，非必须
@property(nonatomic,copy) void (^ss_getFooterViewInSection)(NSInteger section,id footerView,id model);

#pragma mark -------- 事件相关 -----------
///对应的cell是否可以高亮 非必须
@property(nonatomic,copy) BOOL (^ss_shouldHighlightItemAtIndexPath)(NSIndexPath* indexPath);
///对应的cell高亮时响应此方法 非必须
@property(nonatomic,copy) void (^ss_didHighlightItemAtIndexPath)(NSIndexPath* indexPath);
///对应的cell取消高亮响应此方法 非必须
@property(nonatomic,copy) void (^ss_didUnhighlightItemAtIndexPath)(NSIndexPath* indexPath);
///对应的cell是否可以选中 非必须
@property(nonatomic,copy) BOOL (^ss_shouldSelectItemAtIndexPath)(NSIndexPath* indexPath);
///对应的cell是否可以取消选中 非必须
@property(nonatomic,copy) BOOL (^ss_shouldDeselectItemAtIndexPath)(NSIndexPath* indexPath);
///对应的cell已经点击选中响应此方法 非必须
@property(nonatomic,copy) void (^ss_didSelectItemAtIndexPath)(NSIndexPath* indexPath);
///对应的cell已经取消点击选中响应此方法 非必须
@property(nonatomic,copy) void (^ss_didDeselectItemAtIndexPath)(NSIndexPath* indexPath);
///对应的cell将要展示，非必须，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_willDisplayCell)(NSIndexPath* indexPath, id cell);
///对应的cell已经展示，非必须，把id改成对应类名即可无需强制转换
@property(nonatomic,copy) void (^ss_didEndDisplayingCell)(NSIndexPath* indexPath, id cell);
///对应的section的headView将要显示，非必须
@property(nonatomic,copy) void (^ss_willDisplayHeaderViewInSection)(NSIndexPath* indexPath, UICollectionReusableView* headerView, id model);
///对应的section的footView将要显示，非必须
@property(nonatomic,copy) void (^ss_willDisplayFooterViewInSection)(NSIndexPath* indexPath, UICollectionReusableView* footView, id model);
///scrollView滚动事件，非必须
@property(nonatomic,copy) void (^ss_scrollViewDidScroll)(UIScrollView* scrollView);
///scrollView缩放事件，非必须
@property(nonatomic,copy) void (^ss_scrollViewDidZoom)(UIScrollView* scrollView);
///scrollView滚动到顶部事件，非必须
@property(nonatomic,copy) void (^ss_scrollViewDidScrollToTop)(UIScrollView* scrollView);
///scrollView开始拖拽事件，非必须
@property(nonatomic,copy) void (^ss_scrollViewWillBeginDragging)(UIScrollView* scrollView);
///scrollView结束拖拽事件，非必须
@property(nonatomic,copy) void (^ss_scrollViewDidEndDragging)(UIScrollView* scrollView, BOOL willDecelerate);


///UICollectionView的DataSource 设置为当前控制器即可重写对应数据源代理方法
@property(nonatomic,weak,nullable) id<UICollectionViewDataSource> ssDataSource;
///UICollectionView的Delegate 设置为当前控制器即可重写对应代理方法
@property(nonatomic,weak,nullable) id<UICollectionViewDelegate> ssDelegate;

@end

NS_ASSUME_NONNULL_END
