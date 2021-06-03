//
//  SSCollectionView.h
//  baseProject
//
//  Created by apple on 2021/6/3.
//  Copyright © 2021 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSCollectionView : UICollectionView

@property(nonatomic,strong) NSMutableArray* ssDatas;
///声明cell的类
@property(nonatomic,copy) Class (^ss_setCellClassAtIndexPath)(NSIndexPath* indexPath);
///设置section数量(非必须，若设置了，则内部自动设置section个数无效)
@property(nonatomic,copy) NSInteger (^ss_setNumberOfSectionsInCollectionView)(UICollectionView* collectionView);
///设置对应section中row的数量(非必须，若设置了，则内部自动设置对应section中row的数量无效)
@property(nonatomic,copy) NSInteger (^ss_setNumberOfItemsInSection)(NSUInteger section);


///UICollectionView的DataSource 设置为当前控制器即可重写对应数据源代理方法
@property(nonatomic,weak,nullable) id<UICollectionViewDataSource> ssDataSource;
///UICollectionView的Delegate 设置为当前控制器即可重写对应代理方法
@property(nonatomic,weak,nullable) id<UICollectionViewDelegate> ssDelegate;

@end

NS_ASSUME_NONNULL_END
