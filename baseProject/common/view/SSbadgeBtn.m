//
//
//  Created by F S on 2017/12/13.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSbadgeBtn.h"
#import <Masonry.h>

@interface SSbadgeBtn ()
@property(nonatomic,strong) UILabel* badgeLabel;
@end
@implementation SSbadgeBtn

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
    self.badgeLabel = [[UILabel alloc] init];
    self.badgeLabel.backgroundColor = [UIColor redColor];
    self.badgeLabel.font = [UIFont systemFontOfSize:10];
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.hidden = YES;
    [self addSubview:self.badgeLabel];
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.height.mas_equalTo(12);
    }];
}

- (CGRect)contentRectForBounds:(CGRect)bounds {
    return bounds;
}


- (void)setImgNameStr:(NSString *)imgNameStr {
    _imgNameStr = imgNameStr;
    if (self.buttonType == UIButtonTypeSystem) {
        ///当type为system时，使用此行代码
        [self setImage:[[UIImage imageNamed:imgNameStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else {
        ///当type为custom时，使用此行代码
        [self setImage:[UIImage imageNamed:imgNameStr] forState:UIControlStateNormal];
    }
}

- (void)setBadgeNum:(NSString *)badgeNum {
    _badgeNum = badgeNum;
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
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
