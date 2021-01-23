//
//  SSshowContentView.m
//  ddz
//
//  Created by F S on 2017/12/11.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSshowContentView.h"

@interface SSshowContentView () {
    UILabel* _label;
}
@property(nonatomic,assign) SSloadingModel model;
///加载菊花的父视图 / 背景视图
@property(nonatomic,strong) UIView* bgView;
///
@property(nonatomic,strong) UIActivityIndicatorView* indicatorView;
@property(nonatomic,strong) UILabel* loadingLab;

@end

@implementation SSshowContentView
#pragma mark ------- 懒加载 ----------
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ssscale(80), ssscale(80))];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.8f alpha:0.6f];
        _bgView.layer.cornerRadius = 5;
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}
- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        if (@available(iOS 13.0, *)) {
            _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        }else {
            _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
        _indicatorView.transform = CGAffineTransformMakeScale(1.8, 1.8);
    }
    return _indicatorView;
}
- (UILabel *)loadingLab {
    if (!_loadingLab) {
        _loadingLab = [[UILabel alloc] init];
        _loadingLab.textAlignment = NSTextAlignmentCenter;
        _loadingLab.font = [UIFont systemFontOfSize:15];
        _loadingLab.text = @"加载中";
    }
    return _loadingLab;
}

//FIXME:----------
- (instancetype)init {
    if (self = [super init]) {
        _backGroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _font = [UIFont systemFontOfSize:12];
        _msgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        _duration = 0.5;
        _delay = 0.5;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _backGroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _font = [UIFont systemFontOfSize:12];
        _msgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        _duration = 0.5;
        _delay = 0.5;
    }
    return self;
}

- (void)setSubWith:(NSString*)msg canClick:(BOOL)canClick {
    self.backgroundColor = _backGroundColor;
    self.layer.cornerRadius = 5;
    self.tag = 10010101;
//    self.alpha = 0;
    
    for (UIView* view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == 10010101) {
            [view removeFromSuperview];
        }
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    UILabel* lab = [[UILabel alloc] init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 2;
    lab.font = _font;
    lab.textColor = _msgColor;
    lab.text = msg;
    [self addSubview:lab];
    _label = lab;
    
    if (canClick) {
        self.alpha = 0;
        CGSize size = [msg boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 200) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_font} context:nil].size;
            if (size.height > 20) {
                self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, size.height+10);
                lab.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-20, size.height);
                
            }else {
                self.frame = CGRectMake(0, 0, size.width+10, size.height+10);
                lab.frame = CGRectMake(0, 0, size.width+10, size.height+10);
            }
        self.center = [UIApplication sharedApplication].keyWindow.center;
    }else {
        lab.alpha = 0;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = [UIColor clearColor];
        lab.backgroundColor = _backGroundColor;

            CGSize size = [msg boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 200) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_font} context:nil].size;
            if (size.height > 20) {
        //        self.frame = CGRectMake(0, 0, ScreenWidth, size.height+10);
                lab.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-20, size.height);

            }else {
        //        self.frame = CGRectMake(0, 0, size.width+10, size.height+10);
                lab.frame = CGRectMake(0, 0, size.width+10, size.height+10);
            }
    }
}

- (void)setSubWith:(NSString*)msg canCli:(BOOL)canClick {
    self.backgroundColor = _backGroundColor;
    self.layer.cornerRadius = 5;
    self.tag = 10010101;
    
    for (UIView* view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == 10010101) {
            [view removeFromSuperview];
        }
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    UILabel* lab = [[UILabel alloc] init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 2;
    lab.font = _font;
    lab.textColor = _msgColor;
    lab.text = msg;
    lab.alpha = 0;
    [self addSubview:lab];
    _label = lab;
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [UIColor clearColor];
    lab.backgroundColor = _backGroundColor;

    CGSize size = [msg boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 200) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_font} context:nil].size;
    if (size.height > 20) {
//        self.frame = CGRectMake(0, 0, ScreenWidth, size.height+10);
        lab.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-20, size.height);

    }else {
//        self.frame = CGRectMake(0, 0, size.width+10, size.height+10);
        lab.frame = CGRectMake(0, 0, size.width+10, size.height+10);
    }
    lab.center = self.center;
}

#pragma mark -------- 提示语 界面点击效果不被遮挡 提示语出现时仍可点击-----------



#pragma mark -------- 提示语 界面点击效果被遮挡 提示语出现时不可点击-----------

- (void)SSshowMsg:(NSString*_Nullable)msg {
    if (![SShelper isObjNil:msg]) {
        [self setSubWith:msg canClick:NO];
        
        [UIView animateWithDuration:_duration animations:^{
//            self.alpha = 1;
            self->_label.alpha = 1;
        } completion:^(BOOL finished) {
            if (finished) {
                [self performBlock:^{
                    [UIView animateWithDuration:self->_duration animations:^{
//                        self.alpha = 0;
                        self->_label.alpha = 0;
                    } completion:^(BOOL finished) {
                        [self removeFromSuperview];
                    }];
                    
                } AfterDelay:self->_delay];
            }else {
                [self removeFromSuperview];
            }
        }];
    }
}

- (void)SSshowMsg:(NSString*_Nullable)msg FinishBlock:(void (^)(void))block {
    if (![SShelper isObjNil:msg]) {
        [self setSubWith:msg canClick:NO];
        
        [UIView animateWithDuration:_duration animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            if (finished) {
                [self performBlock:^{
                    [UIView animateWithDuration:self->_duration animations:^{
                        self.alpha = 0;
                    } completion:^(BOOL finished) {
                        [self removeFromSuperview];
                        block();
                    }];
                    
                } AfterDelay:self->_delay];
            }
        }];
    }
}

- (void)SSshowMsg:(NSString*_Nullable)msg delay:(CGFloat)delay FinishBlock:(void (^)(void))block {
    if (![SShelper isObjNil:msg]) {
        [self setSubWith:msg canClick:NO];
        [UIView animateWithDuration:_duration animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            if (finished) {
                [self performBlock:^{
                    [UIView animateWithDuration:self->_duration animations:^{
                        self.alpha = 0;
                    } completion:^(BOOL finished) {
                        [self removeFromSuperview];
                        block();
                    }];
                    
                } AfterDelay:delay];
            }
        }];
    }
}

- (void)performBlock:(void(^)(void))block AfterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(fireBlock:) withObject:block afterDelay:delay];
}

- (void)fireBlock:(void (^)(void))block {
    block();
}

#pragma mark -------- 网络请求时的 加载菊花 -----------

- (void)setLoadingText:(NSString *)loadingText {
    _loadingText = loadingText;
    self.loadingLab.text = loadingText;
}

- (void)setLoadingTextFont:(UIFont *)loadingTextFont {
    _loadingTextFont = loadingTextFont;
    self.loadingLab.font = loadingTextFont;
}

- (void)setLoadingTextColor:(UIColor *)loadingTextColor {
    _loadingTextColor = loadingTextColor;
    self.loadingLab.textColor = loadingTextColor;
}

- (void)setCustomView:(UIView *)customView {
    _customView = customView;
}

- (void)setSubWithModel:(SSloadingModel)model {
    self.backgroundColor = [UIColor clearColor];
    self.tag = 10010101;
    
    for (UIView* view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == 10010101) {
            [view removeFromSuperview];
        }
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self addSubview:self.bgView];
    
    switch (model) {
        case SSloadingModelActivityIndicator:{
            self.bgView.center = self.center;
            
            [self.bgView addSubview:self.indicatorView];
            self.indicatorView.center = CGPointMake(self.bgView.bounds.size.width/2, self.bgView.bounds.size.height/2);
            
            [self.indicatorView startAnimating];
        }
            break;
        case SSloadingModelActivityIndicatorAndText:{
            CGFloat width = [self.loadingLab.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.loadingLab.font,NSFontAttributeName, nil]].width + 20;
            width = MAX(ssscale(100), width);
            
            self.bgView.frame = CGRectMake(0, 0, width, width);
            self.bgView.center = self.center;
            
            [self.bgView addSubview:self.indicatorView];
            self.indicatorView.center = CGPointMake(self.bgView.bounds.size.width/2, self.bgView.bounds.size.height/2 - 15);
            
            [self.bgView addSubview:self.loadingLab];
            self.loadingLab.frame = CGRectMake(0, 0, width, ssscale(20));
            self.loadingLab.center = CGPointMake(self.bgView.bounds.size.width/2, self.bgView.bounds.size.height/2 + 25);
            
            [self.indicatorView startAnimating];
        }
            break;
        case SSloadingModelText:{
            CGFloat width = [self.loadingLab.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.loadingLab.font,NSFontAttributeName, nil]].width + 20;
            width = MAX(ssscale(80), width);
            
            self.bgView.frame = CGRectMake(0, 0, width, width);
            self.bgView.center = self.center;
            
            [self.bgView addSubview:self.loadingLab];
            self.loadingLab.frame = CGRectMake(0, 0, width, width);
        }
            break;
        case SSloadingModelCustomize:{
            if (self.customView) {
                CGRect frame = CGRectMake(0, 0, self.customView.frame.size.width, self.customView.frame.size.height);
                self.bgView.frame = frame;
                self.bgView.center = self.center;
                
                [self.bgView addSubview:self.customView];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)SSshowLoadingSSHUD {
    [self SSshowLoadingSSHUD:1];
}

- (void)SSshowLoadingSSHUD:(SSloadingModel)model {
    _model = model;
    [self setSubWithModel:model];
}

- (void)SShiddenLoadingSSHUD {
    if (_model == SSloadingModelActivityIndicator || _model == SSloadingModelActivityIndicatorAndText) {
        [self.indicatorView stopAnimating];
    }
    [self removeFromSuperview];
}

- (void)SShiddenAllLoading {
    for (UIView* view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == 10010101) {
            SSshowContentView* showView = (SSshowContentView*)view;
            if (showView.model == SSloadingModelActivityIndicator || showView.model == SSloadingModelActivityIndicatorAndText) {
                [self.indicatorView stopAnimating];
            }
            [view removeFromSuperview];
        }
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
