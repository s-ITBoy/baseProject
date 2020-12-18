//
//  SSimgTextBadgeBtn.m
//  baseProject
//
//  Created by F S on 2020/12/18.
//  Copyright © 2020 FL S. All rights reserved.
//

#import "SSimgTextBadgeBtn.h"

@interface SSimgTextBadgeBtn ()
@property(nonatomic,strong) UILabel* badgeLabel;
@end
@implementation SSimgTextBadgeBtn

- (instancetype)init {
    if (self = [super init]) {
        [self setSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setSubView];
    }
    return self;
}

- (void)setSubView {
    self.badgeLabel = [[UILabel alloc] init];
    self.badgeLabel.backgroundColor = [UIColor redColor];
    self.badgeLabel.font = [UIFont systemFontOfSize:10];
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
    self.badgeLabel.hidden = YES;
    [self addSubview:self.badgeLabel];
    self.badgeLabel.layer.cornerRadius = 6;
    self.badgeLabel.layer.masksToBounds = YES;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

//- (CGRect)contentRectForBounds:(CGRect)bounds {
//    return bounds;
//}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, contentRect.size.height*3/5, contentRect.size.width, contentRect.size.height*2/5);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, ssscale(6), contentRect.size.width, contentRect.size.height*3/5 - ssscale(6));
}


- (void)setImgNameStr:(NSString *)imgNameStr {
    _imgNameStr = imgNameStr;
    if (self.buttonType == UIButtonTypeSystem) {
        ///当type为system时，使用此行代码
        [self setImage:[[UIImage imageNamed:imgNameStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else {
        ///当type为custom时，使用此行代码
        [self setImage:[UIImage imageNamed:imgNameStr] forState:UIControlStateNormal];
    }
}

- (void)setBadgeNum:(NSString *)badgeNum {
    _badgeNum = badgeNum;
    if ([SShelper isObjNil:badgeNum] || [badgeNum isEqualToString:@"0"]) {
        self.badgeLabel.hidden = YES;
        return;
    }
    _badgeNum = badgeNum;
    self.badgeLabel.text = badgeNum;
    
    CGFloat width = [badgeNum ss_sizewithFont:[UIFont systemFontOfSize:10]].width + 6;
    if (badgeNum.length == 1) {
        self.badgeLabel.frame = CGRectMake(self.width/2 + self.height*3/5/2 - ssscale(14)/2, ssscale(3), ssscale(14), ssscale(14));
    }else {
        self.badgeLabel.frame = CGRectMake(self.width/2 + self.height*3/5/2 - width/2, ssscale(3), width, ssscale(14));
    }
    self.badgeLabel.hidden = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
