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
        _duration = 0.5;
        _delay = 0.5;
    }
    return self;
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
        
        [UIView animateWithDuration:_duration animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            if (finished) {
                [self performBlock:^{
                    [UIView animateWithDuration:self->_duration animations:^{
                        self.alpha = 0;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
