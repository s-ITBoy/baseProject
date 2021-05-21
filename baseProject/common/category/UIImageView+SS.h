//
//  UIImageView+SS.h
//  baseProject
//
//  Created by apple on 2021/5/21.
//  Copyright © 2021 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (SS)

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame and:(UIViewContentMode)contentModel;

- (void)setImgName:(NSString*)imgName;

@end

NS_ASSUME_NONNULL_END
