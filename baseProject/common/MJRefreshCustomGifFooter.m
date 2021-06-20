//
//  MJRefreshCustomGifFooter.m
//  yiqi
//
//  Created by FL S on 2018/10/24.
//  Copyright © 2018 FL S. All rights reserved.
//

#import "MJRefreshCustomGifFooter.h"

@implementation MJRefreshCustomGifFooter


-(void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
        NSString *imageName = [NSString stringWithFormat:@"shanglaLoading"];
        UIImage *image = [UIImage imageNamed:imageName];
        [idleImages addObject:image];
    self.gifView.image = image;
    [self setImages:@[image] forState:(MJRefreshStateIdle)];
    [self setImages:@[image] forState:(MJRefreshStatePulling)];
    [self setImages:@[image] forState:(MJRefreshStateWillRefresh)];
    [self setImages:@[image] forState:(MJRefreshStateRefreshing)];

//    [self setTitle:@"" forState:(MJRefreshStateIdle)];
    [self setTitle:@"加载中..." forState:(MJRefreshStateWillRefresh)];
    [self setTitle:@"加载中..." forState:(MJRefreshStateRefreshing)];
    [self setTitle:@"加载中..." forState:(MJRefreshStateWillRefresh)];
    [self setTitle:@"加载中..." forState:(MJRefreshStateNoMoreData)];
//    self.stateLabel.hidden = true;
//    self.refreshingTitleHidden = true;
//    MJRefreshStateIdle = 1,
//    /** 松开就可以进行刷新的状态 */
//    MJRefreshStatePulling,
//    /** 正在刷新中的状态 */
//    MJRefreshStateRefreshing,
//    /** 即将刷新的状态 */
//    ,
//    /** 所有数据加载完毕，没有更多的数据了 */
//
    self.onlyRefreshPerDrag = true;
    self.mj_h = 70;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
