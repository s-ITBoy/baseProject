//
//  UIImageView+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (SS)

- (instancetype)init;

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame and:(UIViewContentMode)contentModel;

- (void)setImgName:(NSString*)imgName;

@end

NS_ASSUME_NONNULL_END
