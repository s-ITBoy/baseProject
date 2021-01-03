//
//  ViewController.m
//  baseProject
//
//  Created by FL S on 2017/7/22.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "ViewController.h"
#import <pop/POP.h>

#import "SSfileManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView* tableView;

@property(nonatomic,strong) UITextField* textFD;
@property(nonatomic,strong) UIButton* vvvBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* vvvv = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-40/2, 180, 40, 40)];
    vvvv.layer.cornerRadius = 20;
    vvvv.backgroundColor = [UIColor greenColor];
    [self.view addSubview:vvvv];
    self.vvvBtn = vvvv;
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anim.toValue             = [NSValue valueWithCGPoint:CGPointMake(3.f, 3.f)];
    anim.springSpeed         = 0.f;
    [vvvv.layer pop_addAnimation:anim forKey:@""];
    
    [vvvv addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(vvvv.XX, vvvv.maxYY+100, vvvv.width, vvvv.height)];
    btn.layer.cornerRadius = 20;
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickbtn) forControlEvents:UIControlEventTouchUpInside];
    
    [[SSfileManager shareManager] SSclearCache];
}

- (void)clickbtn {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anim.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    anim.springSpeed         = 0.f;
    [self.vvvBtn.layer pop_addAnimation:anim forKey:@""];
}

- (void)clickBtn:(UIButton*)button {
//    button.width = 40;
//    button.height = 40;
//    button.size = CGSizeMake(40, 40);
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    anim.repeatForever = YES;
    anim.toValue             = [NSValue valueWithCGPoint:CGPointMake(3, 3)];
    anim.springSpeed         = 0;
    [button.layer pop_addAnimation:anim forKey:@"qwer"];
//    [UIView animateWithDuration:3 animations:^{
//
//    } completion:^(BOOL finished) {
//        [button pop_removeAllAnimations];
//    }];
    
}

- (void)setsubv {    ///
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 800) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld---- %ld",indexPath.section,indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

///分区背景色
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor redColor];
}
///蛋疼：ios11后更改section颜色必须加上这个方法
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)dealloc {
    NSLog(@"---------销毁------- %s",__func__);
}


@end
