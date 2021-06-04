//
//  SSrightCollectCell.m
//  baseProject
//
//  Created by F S on 2020/3/31.
//  Copyright © 2020 FL S. All rights reserved.
//

#import "SSrightCollectCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface SSrightCollectCell ()
@property(nonatomic,strong) UIImageView* imgV;
@property(nonatomic,strong) UILabel* titleLabel;

@end
@interface SSrightCollectCell ()

@end
@implementation SSrightCollectCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imgV = [[UIImageView alloc] init];
        self.imgV.contentMode = UIViewContentModeScaleAspectFit;
        self.imgV.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.imgV];
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.mas_equalTo(ssscale(10));
            make.height.mas_equalTo(ssscale(66.5));
        }];
//        self.imgV.backgroundColor = [UIColor SScolorWithHexString:@"#D8D8D8"];
        
        self.titleLabel = [UILabel SSlabel:[UIFont SSCustomFont14] textAlignment:NSTextAlignmentCenter textColor:[UIColor SStitleColor51] backgroundColor:nil];
        
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.imgV.mas_bottom).mas_equalTo(ssscale(1));
            make.height.mas_equalTo(ssscale(20));
            
        }];
        self.titleLabel.text = @"旅行箱包";
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    if ([SShelper isObjNil:dic]) {
        return;
    }
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[dic SSstringForDicKey:@"image"]] placeholderImage:nil];
    self.titleLabel.text = [dic SSstringForDicKey:@"opt_name"];
}

- (void)setStrModel:(NSString *)strModel {
    _strModel = strModel;
    self.titleLabel.text = strModel;
}

//- (void)setIsSelected:(BOOL)isSelected{
//    _isSelected = isSelected;
//    if (isSelected) {
//        self.titleLabel.textColor = [UIColor whiteColor];
//        self.titleLabel.backgroundColor = [UIColor SSredColor];
//    }else{
//        self.titleLabel.textColor = [UIColor SScolor71];
//        self.titleLabel.backgroundColor = [UIColor SScolorWithR:243 G:243 B:243];
//    }
//}
@end
