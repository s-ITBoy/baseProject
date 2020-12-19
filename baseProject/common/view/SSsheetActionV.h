//
//  SSsheetActionV.h
//  baseProject
//
//  Created by F S on 2020/12/9.
//  Copyright © 2020 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///自定义alertActionSheetView
@interface SSsheetActionV : UIView
///0：表示取消
@property(nonatomic,copy) void (^SSsheetActionBLock) (NSInteger index);
///取消不需要加入titleArr,它会自动加入view中
- (instancetype)initWithArr:(NSArray*)titleArr titleFont:(UIFont*_Nullable)font frame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
