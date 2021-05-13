//
//  SSnaviAndStatusBarV.h
//  ddz
//
//  Created by F S on 2017/12/13.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSbadgeBtn.h"

@interface SSbadgeBtn ()
@property(nonatomic,strong) UILabel* badgeLabel;
@end
@implementation SSbadgeBtn

- (instancetype)init {
    if (self = [super init]) {
        [self setSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor clearColor];
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
    
    CGFloat width = [badgeNum ss_sizewithFont:[UIFont systemFontOfSize:10]].width + 6;
    if (badgeNum.length == 1) {
        self.badgeLabel.text = [NSString stringWithFormat:@" %@ ",badgeNum];
        self.badgeLabel.frame = CGRectMake(self.width-ssscale(14)/2, ssscale(-5), ssscale(14), ssscale(14));
    }else {
        self.badgeLabel.text = badgeNum;
        self.badgeLabel.frame = CGRectMake(self.width-width/2, ssscale(-5), width, ssscale(14));
    }
    self.badgeLabel.hidden = NO;
}

- (void)setIsSetImgOnRight:(BOOL)isSetImgOnRight {
    _isSetImgOnRight = isSetImgOnRight;
    if (isSetImgOnRight) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0,self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.bounds.size.width, 0, self.imageView.bounds.size.width);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
