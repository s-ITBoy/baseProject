 //
//  MjRefreshCustomGifHeader.m
//  EasyDecoration
//
//  Created by FL S on 2017/4/14.
//  Copyright © 2017年 FL S. All rights reserved.
//

#import "MjRefreshCustomGifHeader.h"
#import <UIImage+GIF.h>

@interface MjRefreshCustomGifHeader (){
    UIImageView *gifImage;
}

@end

@implementation MjRefreshCustomGifHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i < 44; i++) {
        NSString *imageName = [NSString stringWithFormat:@"xialajiazai_0001.png"];
        UIImage *image = [UIImage imageNamed:imageName];
        [idleImages addObject:image];
    }
    for (int i = 1; i <= 25; i++) {
        NSString *imageName = [NSString stringWithFormat:@"xialajiazai_00%.02d.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];

    // 设置普通状态的动画图片
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (int i = 26; i <= 34; i++) {
        NSString *imageName = [NSString stringWithFormat:@"xialajiazai_00%.02d.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [pullingImages addObject:image];
    }
    
    for (int i = 0; i < 20; i++) {
        for (int i = 34; i <= 38; i++) {
            NSString *imageName = [NSString stringWithFormat:@"xialajiazai_00%.02d.png", i];
            UIImage *image = [UIImage imageNamed:imageName];
            [pullingImages addObject:image];
        }
    }
   
    [self setImages:pullingImages forState:MJRefreshStatePulling];

    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 34; i <= 38; i++) {
        NSString *imageName = [NSString stringWithFormat:@"xialajiazai_00%.02d.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [refreshingImages addObject:image];
    }

    // 设置正在刷新状态的动画图片
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    self.lastUpdatedTimeLabel.hidden = true;
    self.stateLabel.hidden = true;

    self.mj_h = 100;
//    gifImage = [YQhelper createImageView:CGRectMake(0, 10, 40, 40) image:[UIImage imageNamed:@"loading3.tiff"]];
//    gifImage.centerx = ScreenWidth/2;
//    [self addSubview:gifImage];
}

//- (void)setState:(MJRefreshState)state{
//    MJRefreshCheckState;
//
//    switch (state) {
//            //进行中
//        case MJRefreshStateRefreshing:{
//            NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"waiting3" withExtension:@"gif"]; //加载GIF图片
//            NSData *data = [NSData dataWithContentsOfURL:fileUrl];
//            gifImage.image = [UIImage sd_animatedGIFWithData:data];
//        }
//            break;
//        default:
//            gifImage.image = [UIImage imageNamed:@"loading3.tiff"];
//            break;
//    }
//}

@end
