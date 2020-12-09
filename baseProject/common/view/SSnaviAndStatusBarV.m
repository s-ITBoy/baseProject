//
//  SSnaviAndStatusBarV.m
//  ddz
//
//  Created by F S on 2017/12/13.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSnaviAndStatusBarV.h"
#import "SSbadgeBtn.h"

@interface SSnaviAndStatusBarV ()
@property(nonatomic,strong) SSbadgeBtn* leftBtn;
@property(nonatomic,strong) UIButton* rightBtn;
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
    self.leftBtn = [[SSbadgeBtn alloc] initWithFrame:CGRectMake(0, statusBarHeight+(self.frame.size.height-statusBarHeight)/2-44/2, 65, 44)];
    self.leftBtn.imgNameStr = @"navi_back_white";
    self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 12);
    self.leftBtn.tag = 0;
    self.leftBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.leftBtn];
    [self.leftBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLab = [SShelper SSlabel:[UIFont SSCustomBoldFont:15] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:nil];
    self.titleLab.frame = CGRectMake(90*Scale, statusBarHeight, ScreenWidth-2*90*Scale, self.frame.size.height-statusBarHeight);
    [self addSubview:self.titleLab];
    
    _rightBtn = [UIButton buttonWithType:0];
    _rightBtn.tag = 1;
//    [_rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _rightBtn.frame = CGRectMake(self.frame.size.width-20-15, statusBarHeight+(self.frame.size.height-statusBarHeight)/2-20/2, 20, 20);
    [self addSubview:_rightBtn];
    _rightBtn.hidden = YES;
    [_rightBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setBadgeNum:(NSString *)badgeNum {
    _badgeNum = badgeNum;
    self.leftBtn.badgeNum = badgeNum;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr =titleStr;
    self.titleLab.text = titleStr;
}

- (void)setLeftbtnImgStr:(NSString *)leftbtnImgStr {
    _leftbtnImgStr = leftbtnImgStr;
    self.leftBtn.imgNameStr = @"navi_btn_left";
}

- (void)setLeftHIdden:(BOOL)leftHIdden {
    _leftHIdden = leftHIdden;
    self.leftBtn.hidden = YES;
}

- (void)setRightBtnImgStr:(NSString *)rightBtnImgStr {
    _rightBtnImgStr = rightBtnImgStr;
    [self.rightBtn setImage:[UIImage imageNamed:rightBtnImgStr] forState:UIControlStateNormal];
}

- (void)setIsHiddenrightBtn:(BOOL)isHiddenrightBtn {
    _isHiddenrightBtn = isHiddenrightBtn;
    self.rightBtn.hidden = isHiddenrightBtn;
}

- (void)clickBtn:(UIButton*)button {
    if (self.naviBlock) {
        self.naviBlock(button.tag);
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
