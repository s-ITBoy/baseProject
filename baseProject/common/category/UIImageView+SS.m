//
//  UIImageView+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "UIImageView+SS.h"

@implementation UIImageView (SS)

- (instancetype)init {
    if (self = [super init]) {
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

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
