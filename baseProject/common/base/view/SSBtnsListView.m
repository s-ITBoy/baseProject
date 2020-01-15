//
//  SSBtnsListView.m
//  ddz
//
//  Created by FL S on 2019/12/15.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSBtnsListView.h"
#import <Masonry.h>

@interface SSBtnsListView ()
@property(nonatomic,strong) UIButton* selectedBtn;
@property(nonatomic,strong) UILabel* sliderLabel;;

@property(nonatomic,assign) CGFloat widthForSlider;
@property(nonatomic,assign) CGFloat heigthForSlider;
@property(nonatomic,assign) CGFloat sliderBottom;
@end
@implementation SSBtnsListView


- (void)setSliderWidth:(CGFloat)sliderWidth {
    _sliderWidth = sliderWidth;
    self.widthForSlider = sliderWidth;
}

- (void)setSliderHeigth:(CGFloat)sliderHeigth {
    _sliderHeigth = sliderHeigth;
    self.heigthForSlider = sliderHeigth;
}

- (void)setSliderToBottom:(CGFloat)sliderToBottom {
    _sliderToBottom = sliderToBottom;
    self.sliderBottom = sliderToBottom;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.widthForSlider = 15;
        self.heigthForSlider = 2;
        self.sliderBottom = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton* button = [UIButton buttonWithType:0];
//        [button setBackgroundColor:[UIColor greenColor]];
        button.tag = i;
        if (i==self.selectedINdex) {
            button.selected = YES;
            self.selectedBtn = button;
        }else {
            button.selected = NO;
        }
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:self.titleColor?self.titleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:self.titleSelectedColor?self.titleSelectedColor:[UIColor blackColor] forState:UIControlStateSelected];
        button.titleLabel.font = self.titleFont ? self.titleFont : [UIFont systemFontOfSize:14];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY).mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i*self.frame.size.width/self.titleArray.count);
            make.width.mas_equalTo(self.frame.size.width/self.titleArray.count);
        }];
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    self.sliderLabel = [UILabel new];
    self.sliderLabel.backgroundColor = self.sliderColor ? self.sliderColor : [UIColor blackColor];
    [self addSubview:self.sliderLabel];
    [self.sliderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.sliderBottom);
        make.height.mas_equalTo(self.heigthForSlider);
        make.centerX.mas_equalTo(self.selectedBtn.mas_centerX);
        //        make.width.mas_equalTo(self.selectedBtn.mas_width).mas_equalTo(-15);
        make.width.mas_equalTo(self.widthForSlider);
    }];
    
    UILabel* line = [UILabel new];
    line.backgroundColor = self.separatoeColor ? self.separatoeColor : [UIColor clearColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)clickBtn:(UIButton*)button {
    if (self.selectedBtn.tag == button.tag) {
        button.selected = YES;
    }else{
        self.selectedBtn.selected = NO;
        button.selected = YES;
        self.selectedBtn = button;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.sliderLabel.centerx = self.selectedBtn.centerx;
    }];
    self.selectedINdex = button.tag;
    if (self.selectedBlock) {
        self.selectedBlock(button.tag);
    }
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

///适配iOS 11 --iOS 10及以下 自定义titleView会添加在navigationBar上，iOS 11 添加在UINavigationBarContentView上。
- (CGSize)intrinsicContentSize{
    return UILayoutFittingExpandedSize;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
