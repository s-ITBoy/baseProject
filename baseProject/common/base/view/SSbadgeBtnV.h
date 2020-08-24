//
//  SSbadgeBtnV.h
//  leeMail
//
//  Created by F S on 2017/7/9.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SSClickBadgeBtnBlock)(void);
///自动以带右上角角标的按钮视图
@interface SSbadgeBtnV : UIView
@property(nonatomic,strong) UIImageView* imageV;
@property(nonatomic,strong) NSString* badgeNum;

@property(nonatomic,copy) SSClickBadgeBtnBlock badgeBtnBlock;

@end

NS_ASSUME_NONNULL_END
