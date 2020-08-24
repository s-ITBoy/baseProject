//
//  SSgoldAnimationImgV.m
//  baseProject
//
//  Created by F S on 2017/4/16.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSgoldAnimationImgV.h"

#pragma mark - Setting Methods
@implementation ShootSetting

+ (ShootSetting *)defaultSetting{
    ShootSetting *defaultSetting = [[ShootSetting alloc] init];
    defaultSetting.totalCount = 10;
    defaultSetting.timeSpace = 0.1;
    defaultSetting.duration = 1;
    defaultSetting.animationType = ShootAnimationTypeCurve;
    return defaultSetting;
}
@end

@interface SSgoldAnimationImgV ()<CAAnimationDelegate>
@property (nonatomic, strong) NSMutableArray *coinTagArray;
@property (nonatomic, assign) CGPoint point;
@end

@implementation SSgoldAnimationImgV
- (instancetype)initWithFrame:(CGRect)frame andEndPoint:(CGPoint)point{
    if (self = [super initWithFrame:frame]){
        _coinTagArray = [[NSMutableArray alloc] init];
        self.setting = [ShootSetting defaultSetting];
        //目的地的位置
        self.point = CGPointMake(point.x - frame.origin.x, point.y - frame.origin.y);
//        self.point = point;
    }
    return self;
}

- (void)startAnimation{
    for(int i = 0; i < self.setting.totalCount; i ++){
        //延时 注意时间要乘i 这样才会生成一串，要不然就是拥挤在一起的
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*self.setting.timeSpace * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self initCoinViewWithInt:i];
        });
    }
}

- (void)initCoinViewWithInt:(int)i{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.setting.iconImage ?: self.image];
    //设置中心位置
    imageView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    //初始化金币的位置
    imageView.tag = i + 1000; //设置tag时尽量设置大点的数值
    //将tag添加到数组，用于判断移除
    [self.coinTagArray addObject:[NSNumber numberWithInt:(int)imageView.tag]];
    [self addSubview:imageView];
    [self setAnimationWithLayer:imageView];
}

- (void)setAnimationWithLayer:(UIView *)imageView{
    
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)];
    
    switch (self.setting.animationType) {
        case ShootAnimationTypeLine://直线
            [movePath addLineToPoint:self.point];
            break;
        case ShootAnimationTypeCurve://曲线
            //抛物线
            [movePath addQuadCurveToPoint:self.point controlPoint:CGPointMake(self.point.x, self.center.y)];
            break;
        default:
            break;
    }
    
    //位移动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //移动路径
    animation.path = movePath.CGPath;
    animation.duration = self.setting.duration;
    animation.autoreverses = NO;
    animation.repeatCount = 1;
    animation.calculationMode = kCAAnimationCubicPaced;
    animation.delegate = self;
    [imageView.layer addAnimation:animation forKey:@"position"];
    [UIView animateWithDuration:self.setting.duration animations:^{
        imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    }];
//    [UIView animateWithDuration:0.9 animations:^{
//
//    } completion:^(BOOL finished) {
//        self.hidden = YES;
//    }];
}

- (void)animationDidStart:(CAAnimation *)anim {
//    UIView *coinView =(UIView *)[self viewWithTag:[[self.coinTagArray firstObject] intValue]];
//    [coinView removeFromSuperview];
//    [self.coinTagArray removeObjectAtIndex:0];
//    if (coinView.tag == 1008) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"animation" object:nil];
//    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag){//动画执行结束移除view
//        NSLog(@"动画结束");
        UIView *coinView =(UIView *)[self viewWithTag:[[self.coinTagArray firstObject] intValue]];
//        NSLog(@"-----tag = %ld",(long)coinView.tag);
        [coinView removeFromSuperview];
        [self.coinTagArray removeObjectAtIndex:0];
        if (coinView.tag == 1001) {
//            self.hidden = YES;
//            [self removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"animation" object:nil];
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
