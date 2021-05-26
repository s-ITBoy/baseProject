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
#pragma mark -------- 数据 -------------
@property(nonatomic,strong) NSMutableArray* ssDatas;
///声明cell的类
@property (nonatomic, copy) Class (^ss_setCellClassAtIndexPath)(NSIndexPath *indexPath);

///设置section数量(非必须，若设置了，则内部自动设置section个数无效)
@property (nonatomic, copy) NSInteger (^ss_setNumberOfSectionsInTableView)(UITableView *tableView);
///设置对应section中row的数量(非必须，若设置了，则内部自动设置对应section中row的数量无效)
@property (nonatomic, copy) NSInteger (^ss_setNumberOfRowsInSection)(NSUInteger section);


#pragma mark - 数据获取
///获取对应行的cell，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_getCellAtIndexPath)(NSIndexPath *indexPath,id cell,id model);


#pragma mark - 代理事件相关
///选中某一行，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_didSelectedAtIndexPath)(NSIndexPath *indexPath,id model,id cell);
///取消选中某一行，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^ss_didDeselectedAtIndexPath)(NSIndexPath *indexPath,id model,id cell);


///tableView的DataSource 设置为当前控制器即可重写对应数据源方法
@property (nonatomic, weak, nullable) id <UITableViewDataSource> ssDataSource;
///tableView的Delegate 设置为当前控制器即可重写对应代理方法
@property (nonatomic, weak, nullable) id <UITableViewDelegate> ssDelegate;

@end

NS_ASSUME_NONNULL_END
