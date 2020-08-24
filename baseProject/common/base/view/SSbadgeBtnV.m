//
//  SSbadgeBtnV.m
//  leeMail
//
//  Created by F S on 2017/7/9.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSbadgeBtnV.h"
#import <Masonry.h>

@interface SSbadgeBtnV ()
@property(nonatomic,strong) UILabel* badgeLabel;
@end

@implementation SSbadgeBtnV

- (instancetype)init {
    if (self = [super init]) {
        [self setSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setSubView];
    }
    return self;
}

- (void)setSubView {
    self.imageV = [[UIImageView alloc] init];
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).mas_equalTo(-8);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(ssscale(30), ssscale(30)));
    }];
    
    self.badgeLabel = [[UILabel alloc] init];
    self.badgeLabel.backgroundColor = [UIColor redColor];
    self.badgeLabel.font = [UIFont systemFontOfSize:10];
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.hidden = YES;
    [self addSubview:self.badgeLabel];
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imageV.mas_right);
        make.centerY.mas_equalTo(self.imageV.mas_top);
        make.height.mas_equalTo(12);
    }];
    
    UIButton* button = [UIButton buttonWithType:0];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    [button SSaddEnlargeEdge:15];
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtn:(UIButton*)button {
    if (self.badgeBtnBlock) {
        self.badgeBtnBlock();
    }
}

- (void)setBadgeNum:(NSString *)badgeNum {
    if ([SShelper isObjNil:badgeNum] || [badgeNum isEqualToString:@"0"]) {
        self.badgeLabel.hidden = YES;
        return;
    }
    _badgeNum = badgeNum;
    if (badgeNum.length == 1) {
        self.badgeLabel.text = [NSString stringWithFormat:@" %@ ",badgeNum];
    }else {
        self.badgeLabel.text = badgeNum;
    }
    self.badgeLabel.hidden = NO;
    [self.badgeLabel sizeToFit];
    [self.badgeLabel SSaddCornerRadius:6];
//    [self.badgeLabel setlayerOfViewRadius:6 andLineWidth:0 andLineCorlor:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
