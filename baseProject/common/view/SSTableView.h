//
//  SSTableView.h
//  baseProject
//
//  Created by apple on 2021/5/26.
//  Copyright © 2021 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///自定义强大的tableView，实现低耦合、高聚合
@interface SSTableView : UITableView

@property(nonatomic,strong) NSMutableArray* ssDatas;

@end

NS_ASSUME_NONNULL_END
