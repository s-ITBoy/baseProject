//
//  UIImageView+SS.m
//  baseProject
//
//  Created by apple on 2021/5/21.
//  Copyright © 2021 FL S. All rights reserved.
//

#import "UIImageView+SS.h"

@implementation UIImageView (SS)

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame and:(UIViewContentMode)contentModel {
    if (self = [super initWithFrame:frame]) {
        self.contentMode = contentModel;
    }
    return self;
}

- (void)setImgName:(NSString*)imgName {
    self.image = [UIImage imageNamed:imgName];
}

@end
