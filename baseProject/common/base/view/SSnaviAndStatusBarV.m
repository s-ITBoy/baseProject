//
//  SSnaviAndStatusBarV.m
//  ddz
//
//  Created by F S on 2017/12/13.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSnaviAndStatusBarV.h"
#import "SSbadgeBtnV.h"

@interface SSnaviAndStatusBarV ()
@property(nonatomic,strong) SSbadgeBtnV* leftBtnV;
@property(nonatomic,strong) UILabel* titleLab;
@end
@implementation SSnaviAndStatusBarV

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setSubV];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setSubV {
    weakly(self);
    self.leftBtnV = [[SSbadgeBtnV alloc] initWithFrame:CGRectMake(0, statusBarHeight+(self.frame.size.height-statusBarHeight)/2-44/2, 64, 44)];
    self.leftBtnV.imageV.image = [UIImage imageNamed:@"navi_back_white"];
    self.leftBtnV.backgroundColor = [UIColor clearColor];
    [self.leftBtnV.imageV sizeToFit];
    [self addSubview:self.leftBtnV];
    self.leftBtnV.badgeBtnBlock = ^{
        if (weakSelf.naviBlock) {
            weakSelf.naviBlock(0);
        }
    };
    
    self.titleLab = [SShelper SSlabel:[UIFont SSCustomBoldFont:15] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:nil];
    self.titleLab.frame = CGRectMake(90*Scale, statusBarHeight, ScreenWidth-2*90*Scale, self.frame.size.height-statusBarHeight);
    [self addSubview:self.titleLab];
    
    UIButton* rightBtn = [UIButton buttonWithType:0];
    [rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(self.frame.size.width-20-15, statusBarHeight+(self.frame.size.height-statusBarHeight)/2-20/2, 20, 20);
    [self addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setBadgeNum:(NSString *)badgeNum {
    _badgeNum = badgeNum;
    self.leftBtnV.badgeNum = badgeNum;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr =titleStr;
    self.titleLab.text = titleStr;
}

- (void)setLeftHIdden:(BOOL)leftHIdden {
    _leftHIdden = leftHIdden;
    self.leftBtnV.hidden = YES;
}

- (void)clickBtn {
    if (self.naviBlock) {
        self.naviBlock(1);
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
