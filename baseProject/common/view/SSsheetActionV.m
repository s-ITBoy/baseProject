//
//  SSsheetActionV.m
//  baseProject
//
//  Created by F S on 2020/12/9.
//  Copyright © 2020 FL S. All rights reserved.
//

#import "SSsheetActionV.h"

@interface SSsheetActionV ()
@property(nonatomic,strong) NSArray* titlesArr;
@property(nonatomic,strong,nullable) UIFont* font;
@end
@implementation SSsheetActionV
- (NSArray *)titlesArr {
    if (!_titlesArr) {
        _titlesArr = [NSArray array];
    }
    return _titlesArr;
}

- (instancetype)initWithArr:(NSArray*)titleArr titleFont:(UIFont*_Nullable)font frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titlesArr = titleArr;
        self.font = font;
        [self setSubV];
    }
    return self;
}

- (void)setSubV {
    self.clipsToBounds = YES;
    
    for (int i = 0; i < self.titlesArr.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = i+1;
        btn.frame = CGRectMake(0, i*ssscale(56), self.width, ssscale(56));
        [btn setTitle:self.titlesArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.font = self.font ? self.font : [UIFont SSCustomFont18];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(clickBtns:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(0, self.titlesArr.count*ssscale(56)+ssscale(8), self.width, ssscale(56));
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    cancelBtn.titleLabel.font = self.font ? self.font : [UIFont SSCustomFont18];
    cancelBtn.tag = 0;
    [self addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(clickBtns:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtns:(UIButton*)button {
    if (self.SSsheetActionBLock) {
        self.SSsheetActionBLock(button.tag);
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
