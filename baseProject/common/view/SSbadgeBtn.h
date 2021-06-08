//
//
//  Created by F S on 2017/12/13.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///自定义按钮（带右上角角标，支持设置图片在文字右侧）
@interface SSbadgeBtn : UIButton
///图标字段名
@property(nonatomic,strong) NSString* imgNameStr;
@property(nonatomic,strong) NSString* badgeNum;
///是否让图片在文字右侧 YES:是；NO:不是 （默认在左侧 即NO）
@property(nonatomic,assign) BOOL isSetImgOnRight;
@end

NS_ASSUME_NONNULL_END
