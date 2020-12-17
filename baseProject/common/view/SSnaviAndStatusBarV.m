//
//  SSnaviAndStatusBarV.m
//  ddz
//
//  Created by F S on 2017/12/13.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSnaviAndStatusBarV.h"
#import "SSbadgeBtn.h"

@interface SSnaviAndStatusBarV ()<UITextFieldDelegate>
///导航标题
@property(nonatomic,strong) UILabel* titleLab;

@property(nonatomic,strong) SSbadgeBtn* leftBtn;
@property(nonatomic,strong) SSbadgeBtn* rightBtn;

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
    
    _rightBtn = [[SSbadgeBtn alloc] initWithFrame:CGRectMake(self.frame.size.width-28-12, statusBarHeight+(self.frame.size.height-statusBarHeight)/2-28/2, 28, 28)];
    _rightBtn.tag = 1;
    [self addSubview:_rightBtn];
    _rightBtn.hidden = YES;
    [_rightBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _searchTFD = [SShelper SStextField:nil andTextColor:[UIColor SScolorWithHex666666] andFont:[UIFont SSCustomFont14]];
    _searchTFD.frame = CGRectMake(_leftBtn.maxXX-ssscale(15), statusBarHeight+7, self.frame.size.width-_leftBtn.maxXX-ssscale(5)-12-28-5, 30);
    [_searchTFD SSsetlayerOfViewRadius:self.searchTFD.height/2 andLineWidth:1 andLineCorlor:[UIColor clearColor]];
    _searchTFD.returnKeyType = UIReturnKeySearch;
    _searchTFD.delegate = self;
    [_searchTFD addTarget:self action:@selector(searchTFD:) forControlEvents:UIControlEventEditingDidEndOnExit];
    _searchTFD.hidden = YES;
    [self addSubview:_searchTFD];
    
    [self bringSubviewToFront:self.leftBtn];
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr =titleStr;
    self.titleLab.text = titleStr;
}

- (void)setIsHiddenSearchTFD:(BOOL)isHiddenSearchTFD {
    _isHiddenSearchTFD = isHiddenSearchTFD;
    self.searchTFD.hidden = isHiddenSearchTFD;
}

- (void)setSearchPlaceHolder:(NSString *)searchPlaceHolder {
    _searchPlaceHolder = searchPlaceHolder;
    self.searchTFD.placeholder = searchPlaceHolder;
}

- (void)setSearchLeftViewImgStr:(NSString *)searchLeftViewImgStr {
    _searchLeftViewImgStr = searchLeftViewImgStr;
    UIImageView* imgV = [SShelper SSimgeView:CGRectMake(0, 0, 38, 18) imgName:searchLeftViewImgStr];
    self.searchTFD.leftView = imgV;
    self.searchTFD.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setSearchBorderColor:(UIColor *)searchBorderColor {
    _searchBorderColor = searchBorderColor;
    self.searchTFD.layer.borderColor = searchBorderColor.CGColor;
}

- (void)setBadgeNum:(NSString *)badgeNum {
    _badgeNum = badgeNum;
    self.leftBtn.badgeNum = badgeNum;
}

- (void)setLeftbtnImgStr:(NSString *)leftbtnImgStr {
    _leftbtnImgStr = leftbtnImgStr;
    self.leftBtn.imgNameStr = leftbtnImgStr;
}

- (void)setLeftHIdden:(BOOL)leftHIdden {
    _leftHIdden = leftHIdden;
    self.leftBtn.hidden = YES;
}

- (void)setRightBtnImgStr:(NSString *)rightBtnImgStr {
    _rightBtnImgStr = rightBtnImgStr;
    self.rightBtn.imgNameStr = rightBtnImgStr;
//    [self.rightBtn setImage:[UIImage imageNamed:rightBtnImgStr] forState:UIControlStateNormal];
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

- (void)searchTFD:(UITextField*)textFD {
    if ([SShelper isObjNil:textFD.text]) {
        return;
    }
    if (self.SSnaviSearchBlock) {
        self.SSnaviSearchBlock(textFD.text);
    }
}

- (void)dealloc {
    _searchTFD.delegate = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
