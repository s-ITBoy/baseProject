//
//  SSthirdVC.m
//  baseProject
//
//  Created by F S on 2017/1/16.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSthirdVC.h"
#import "SSwindowView.h"
#import "SStipsAndHUD.h"
#import <Masonry.h>
#import "SSTableView.h"

@interface sstestModel : NSObject
@property(nonatomic,copy) NSString* name;
@end
@implementation sstestModel


@end

@interface sstestCell_1 : UITableViewCell
@property(nonatomic,strong) UILabel* testLab;
@property(nonatomic,copy) sstestModel* model;
//@property(nonatomic,copy) NSString* modelStr;

@end
@implementation sstestCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.testLab = [UILabel SSlabel:[UIFont SSfontWith:30] textColor:[UIColor SStitleColor51] backgroundColor:nil];
        self.testLab.numberOfLines = 0;
        [self addSubview:self.testLab];
        [self.testLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.bottom.right.mas_equalTo(-10);
        }];
    }
    return self;
}

- (void)setModel:(sstestModel *)model {
    _model = model;
    self.testLab.text = model.name;
}

//- (void)setModelStr:(NSString *)modelStr {
//    _modelStr = modelStr;
//    self.testLab.text = modelStr;
//}
//
//- (void)setModelDic:(NSDictionary *)modelDic {
//    _modelDic = modelDic;
//    self.testLab.text = [modelDic SSstringForDicKey:@"name"];;
//}


@end

@interface SSthirdVC ()
@property(nonatomic,strong) SSTableView* stableV;
@end

@implementation SSthirdVC
- (SSTableView *)stableV {
    if (!_stableV) {
        _stableV = [[SSTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIHEIGHT-TabBarHeight) style:UITableViewStylePlain];
        _stableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _stableV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.stableV];
//    self.stableV.isautoHeight = YES;
    self.stableV.ss_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nonnull indexPath) {
        return [sstestCell_1 class];
    };
    self.stableV.ss_willDisplayCell = ^(NSIndexPath * _Nonnull indexPath, sstestCell_1*  _Nonnull cell) {
//        cell.testLab.text = @"qwer";
    };
//    self.stableV.ss_setCellHeightAtIndexPath = ^CGFloat(NSIndexPath * _Nonnull indexPath) {
//        return 150;
//    };
    self.stableV.ss_isAdaptiveCellHeight = YES;
    [self getdata];
}

- (void)testtipsHUD {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 88, 100, 50)];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtn {
    SStipsAndHUD* show = [[SStipsAndHUD alloc] init];
    show.backGroundColor = [UIColor whiteColor];
//    show.circleColor = [UIColor greenColor];
    [show SSshowLoadingSSHUD:4];
    
}

- (void)getdata {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray* arr = [NSMutableArray array];
        for (NSUInteger i = 0;i < 10;i++) {
            sstestModel* model = [[sstestModel alloc] init];
            model.name = [NSString stringWithFormat:@"数字_%ld",i];
            [arr addObject:model];
            
//            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
//            dic[@"name"] = [NSString stringWithFormat:@"数字_%ld",i];
//            [arr addObject:dic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.stableV.ssDatas = [arr mutableCopy];
        });
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
