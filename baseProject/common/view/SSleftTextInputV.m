//
//  SSleftTextInputV.m
//  baseProject
//
//  Created by F S on 2017/1/2.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSleftTextInputV.h"

@interface SSleftTextInputV ()
@property(nonatomic,strong) UILabel* leftLab;

@end
@implementation SSleftTextInputV

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setSubV];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSubV {
    UIView* bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    bgV.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgV];
    
    _leftLab = [SShelper SSlabel:[UIFont SSCustomFont14] textAlignment:NSTextAlignmentLeft textColor:[UIColor SScolorWithHex333333] backgroundColor:nil];
    _leftLab.frame = CGRectMake(ssscale(12), 0, ssscale(60), bgV.height);
    [bgV addSubview:_leftLab];
    
    _textFD = [SShelper SStextField:nil andTextColor:[UIColor SScolorWithHex333333] andFont:[UIFont SSCustomFont14]];
    _textFD.frame = CGRectMake(_leftLab.maxXX, 0, bgV.width-_leftLab.maxXX, bgV.height);
//    _textFD.keyboardType = UIKeyboardTypeASCIICapable;
    _textFD.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgV addSubview:_textFD];
}

- (void)setKeyBoardType:(UIKeyboardType)keyBoardType {
    _keyBoardType = keyBoardType;
    _textFD.keyboardType = keyBoardType;
}

- (void)setLeftStr:(NSString *)leftStr {
    _leftStr = leftStr;
    _leftLab.text = leftStr;
}

- (void)setPlaceHoderStr:(NSString *)placeHoderStr {
    _placeHoderStr = placeHoderStr;
    _textFD.placeholder = placeHoderStr;
}

- (void)setLeftWidth:(CGFloat)leftWidth {
    _leftWidth = leftWidth;
    self.leftLab.width = leftWidth;
    self.textFD.XX = self.leftLab.maxXX;
    self.textFD.width = self.width-_leftLab.maxXX;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
