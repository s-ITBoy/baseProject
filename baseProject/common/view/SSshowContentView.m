//
//  SSshowContentView.m
//  ddz
//
//  Created by F S on 2017/12/11.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSshowContentView.h"
#import <MJRefresh/MJRefresh.h>

@interface SSshowContentView () {
    UILabel* _label;
}
@end

@implementation SSshowContentView

- (instancetype)init {
    if (self = [super init]) {
        _backGroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _font = [UIFont systemFontOfSize:12];
        _msgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        _delay = 1.0;
    }
    return self;
}

- (void)show {
    
    //if (_parent && _tip && ![_tip isKindOfClass:[NSNull class]]) {
    if (_msg && ![_msg isKindOfClass:[NSNull class]]) {
        self.backgroundColor = _backGroundColor ? _backGroundColor :[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        CGFloat alpha = self.alpha;
        self.alpha = 0;
        self.layer.cornerRadius = 5.0f;
        self.tag = 5001;
        
        for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
            if (subView.tag == 5001) {
                [subView removeFromSuperview];
            }
        }
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.mj_w - 10, self.mj_h - 10)];
        _label.backgroundColor = [UIColor clearColor];
        _label.text = _msg;
        _label.numberOfLines = 2;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = _font ? _font : [UIFont systemFontOfSize:12];
        CGSize max = CGSizeMake(300, 300);
        CGSize size = [_msg boundingRectWithSize:max options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_label.font} context:nil].size;
        
        CGFloat height = size.height +10;
        CGFloat width = MAX(size.width, 60);
        _label.mj_h = height;
        _label.textColor = _msgColor ? _msgColor : [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        [self addSubview:_label];
        self.mj_h = height + 10;
        self.mj_w = width + 40;
        if (self.mj_x == 0 && self.mj_y == 0) {
            CGPoint point = [UIApplication sharedApplication].keyWindow.center;
//            point.y = YQMAINSIZE.height - self.height - 130;
            point.y = _y != 0 ? _y : ScreenHeight/2 + 50;
            self.center = point;
        }
        
        _label.frame = CGRectMake(10, 5, self.width - 20, self.height - 10);
        
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = alpha;
        } completion:^(BOOL finished) {
            if (finished) {
                [self performBlock:^{
                    [UIView animateWithDuration:0.5 animations:^{
                        self.alpha = 0;
                    } completion:^(BOOL finished) {
                        //                        if (finished) {
                        [self removeFromSuperview];
                        //                        }
                    }];
                } AfterDelay:(self->_delay ? self->_delay : 0.5)];
            }else{
                SSLog(@"finished = NO");
                [self removeFromSuperview];
                
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

- (void)SSshowMsg:(NSString*_Nullable)msg {
    if (![SShelper isObjNil:msg]) {
        self.backgroundColor = _backGroundColor;
        self.layer.cornerRadius = 5;
        self.tag = 10010101;
        self.alpha = 0;
        
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
        _msg = msg;
        
        CGSize size = [msg boundingRectWithSize:CGSizeMake(ScreenWidth-20, 200) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_font} context:nil].size;
        if (size.height > 20) {
            self.frame = CGRectMake(0, 0, ScreenWidth, size.height+10);
            [self addSubview:lab];
            lab.frame = CGRectMake(0, 0, ScreenWidth-20, size.height);
            
        }else {
            self.frame = CGRectMake(0, 0, size.width+10, size.height+10);
            [self addSubview:lab];
            lab.frame = CGRectMake(0, 0, self.width, self.height);
        }
        self.center = [UIApplication sharedApplication].keyWindow.center;
        
        [UIView animateWithDuration:_delay animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            if (finished) {
                [self performBlock:^{
                    [UIView animateWithDuration:self->_delay animations:^{
                        self.alpha = 0;
                    } completion:^(BOOL finished) {
                        [self removeFromSuperview];
                    }];
                    
                } AfterDelay:self->_delay];
            }
        }];
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
