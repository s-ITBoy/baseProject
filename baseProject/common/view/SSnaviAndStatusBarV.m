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
@property(nonatomic,strong) UIImageView* centerImgV;
@property(nonatomic,strong) SSbadgeBtn* leftBtn;
@property(nonatomic,strong) SSbadgeBtn* rightBtn;

@property(nonatomic,assign) SSnaviType naviType;

@end
@implementation SSnaviAndStatusBarV

- (instancetype)init {
    if (self = [super init]) {
        [self setSubV];
        self.naviType = SSnaviTypeShowDefault;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setSubV];
        self.naviType = SSnaviTypeShowDefault;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setSubViewWith:_naviType];
}

- (void)setSubViewWith:(SSnaviType)naviType {
    switch (naviType) {
        case SSnaviTypeShowDefault:{
            self.leftBtn.frame = CGRectMake(0, statusBarHeight+(self.frame.size.height-statusBarHeight)/2-44/2, 65, 44);
            self.leftBtn.imgNameStr = @"navi_back";
            self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 8);
            self.titleLab.frame = CGRectMake(90*Scale, statusBarHeight, ScreenWidth-2*90*Scale, self.frame.size.height-statusBarHeight);
            self.rightBtn.frame = CGRectMake(self.frame.size.width-28-12, statusBarHeight+(self.frame.size.height-statusBarHeight)/2-28/2, 28, 28);
            
            [self addSubview:self.leftBtn];
            [self addSubview:self.titleLab];
            [self addSubview:self.rightBtn];
        }
            break;
        case SSnaviTypeShowSearch:{
            self.leftBtn.frame = CGRectMake(0, statusBarHeight+(self.frame.size.height-statusBarHeight)/2-44/2, 65, 44);
            self.leftBtn.imgNameStr = @"navi_back";
            self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 8);
            _searchTFD.frame = CGRectMake(_leftBtn.maxXX-ssscale(15), statusBarHeight+7, self.frame.size.width-_leftBtn.maxXX-ssscale(5)-12-28-5, 30);
            
            [self addSubview:self.leftBtn];
            [self addSubview:self.searchTFD];
            _searchTFD.placeholder = @"sfsslfjslfjs";
        }
            break;
        case SSnaviTypeShowOnlyPicture:{
            self.leftBtn.frame = CGRectMake(0, statusBarHeight+(self.frame.size.height-statusBarHeight)/2-44/2, 65, 44);
            self.rightBtn.frame = CGRectMake(self.frame.size.width-28-12, statusBarHeight+(self.frame.size.height-statusBarHeight)/2-28/2, 28, 28);
            
            [self addSubview:self.leftBtn];
            [self addSubview:self.rightBtn];
        }
            break;
        case SSnaviTypeShowCustom:{
            
        }
            break;
            
        default:
            break;
    }
}

- (void)setSubV {
    self.backgroundColor = [UIColor clearColor];
    
    self.leftBtn = [[SSbadgeBtn alloc] init];
    self.leftBtn.tag = 0;
    self.leftBtn.backgroundColor = [UIColor clearColor];
    [self.leftBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLab = [SShelper SSlabel:[UIFont SSCustomBoldFont:15] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:nil];
    self.centerImgV = [[UIImageView alloc] init];
    self.centerImgV.contentMode = UIViewContentModeScaleAspectFit;
    
    _rightBtn = [[SSbadgeBtn alloc] init];
    _rightBtn.tag = 1;
    _rightBtn.hidden = YES;
    [_rightBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _searchTFD = [SShelper SStextField:nil andTextColor:[UIColor blackColor] andFont:[UIFont SSCustomFont14]];
    _searchTFD.textAlignment = NSTextAlignmentCenter;
    [_searchTFD SSsetlayerOfViewRadius:self.searchTFD.height/2 andLineWidth:1 andLineCorlor:[UIColor clearColor]];
    _searchTFD.returnKeyType = UIReturnKeySearch;
    _searchTFD.delegate = self;
    [_searchTFD addTarget:self action:@selector(searchTFD:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)setType:(SSnaviType)type {
    _type = type;
    self.naviType = type;
}

- (void)setNaviType:(SSnaviType)naviType {
    _naviType = naviType;
//    [self setSubViewWith:_naviType];
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr =titleStr;
    self.titleLab.text = titleStr;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLab.textColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleLab.font = titleFont;
}

- (void)setSearchTextColor:(UIColor *)searchTextColor {
    _searchTextColor = searchTextColor;
    self.searchTFD.textColor = searchTextColor;
}

- (void)setSearchTextFont:(UIFont *)searchTextFont {
    _searchTextFont = searchTextFont;
    self.searchTFD.font = searchTextFont;
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

- (void)setLeftbtnImgStr:(NSString *)leftbtnImgStr {
    _leftbtnImgStr = leftbtnImgStr;
    self.leftBtn.imgNameStr = leftbtnImgStr;
}

- (void)setCenterImgStr:(NSString *)centerImgStr {
    _centerImgStr = centerImgStr;
    [self.centerImgV setImgName:centerImgStr];
}

- (void)setRightBtnImgStr:(NSString *)rightBtnImgStr {
    _rightBtnImgStr = rightBtnImgStr;
    self.rightBtn.imgNameStr = rightBtnImgStr;
//    [self.rightBtn setImage:[UIImage imageNamed:rightBtnImgStr] forState:UIControlStateNormal];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
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
