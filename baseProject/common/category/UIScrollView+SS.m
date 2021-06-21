//
//  UIScrollView+SS.m
//  leeMail
//
//  Created by F S on 2017/7/10.
//  Copyright © 2017 F S. All rights reserved.
//

#import "UIScrollView+SS.h"
#import <MJRefresh.h>

@interface SSrefreshGifHeader : MJRefreshGifHeader

@end
@interface SSrefreshGifHeader (){
    UIImageView* gifImage;
}

@end
@implementation SSrefreshGifHeader

- (void)prepare {
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray* idleImages = [NSMutableArray array];
    for (int i = 1; i < 44; i++) {
        NSString* imageName = [NSString stringWithFormat:@"xialajiazai_0001.png"];
        UIImage* image = [UIImage imageNamed:imageName];
        [idleImages addObject:image];
    }
    for (int i = 1; i <= 25; i++) {
        NSString* imageName = [NSString stringWithFormat:@"xialajiazai_00%.02d.png", i];
        UIImage* image = [UIImage imageNamed:imageName];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];

    // 设置普通状态的动画图片
    NSMutableArray* pullingImages = [NSMutableArray array];
    for (int i = 26; i <= 34; i++) {
        NSString* imageName = [NSString stringWithFormat:@"xialajiazai_00%.02d.png", i];
        UIImage* image = [UIImage imageNamed:imageName];
        [pullingImages addObject:image];
    }
    
    for (int i = 0; i < 20; i++) {
        for (int i = 34; i <= 38; i++) {
            NSString* imageName = [NSString stringWithFormat:@"xialajiazai_00%.02d.png", i];
            UIImage* image = [UIImage imageNamed:imageName];
            [pullingImages addObject:image];
        }
    }
   
    [self setImages:pullingImages forState:MJRefreshStatePulling];

    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray* refreshingImages = [NSMutableArray array];
    for (int i = 34; i <= 38; i++) {
        NSString* imageName = [NSString stringWithFormat:@"xialajiazai_00%.02d.png", i];
        UIImage* image = [UIImage imageNamed:imageName];
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

//- (void)setState:(MJRefreshState)state {
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

@interface SSrefreshGifFooter : MJRefreshAutoGifFooter

@end
@implementation SSrefreshGifFooter

- (void)prepare {
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray* idleImages = [NSMutableArray array];
        NSString* imageName = [NSString stringWithFormat:@"shanglaLoading"];
        UIImage* image = [UIImage imageNamed:imageName];
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

@end

@implementation UIScrollView (SS)

- (void)SS_addRefreshHeaderWithBlock:(void (^)(void))reFreshBlock{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        reFreshBlock();
    }];
//    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}

- (void)SS_addRefreshFooterWithBlock:(void (^)(void))reFreshBlock{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        reFreshBlock();
    }];
}

- (void)SS_beginRefreshing{
    [self.mj_header beginRefreshing];
}

- (void)SS_endRefresh{
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
}

- (BOOL)SS_headerIsRefreshing {
    return  [self.mj_header isRefreshing];
}

- (void)SS_footerBeginRefresh{
    [self.mj_footer beginRefreshing];
}

- (void)SS_addRefresh:(SSrefreshType)type HeaderWithBlock:(void(^)(void))reFreshBlock {
    switch (type) {
        case SSrefreshTypeDefault: {
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                reFreshBlock();
            }];
        }
            break;
        case SSrefreshTypecustom: {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)SS_addRefresh:(SSrefreshType)type FooterWithBlock:(void(^)(void))reFreshBlock {
    switch (type) {
        case SSrefreshTypeDefault: {
            self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                reFreshBlock();
            }];
        }
            break;
        case SSrefreshTypecustom: {
            
        }
            break;
            
        default:
            break;
    }
}

@end
