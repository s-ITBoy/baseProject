//
//  SSforthVC.m
//  baseProject
//
//  Created by FL S on 2020/11/22.
//  Copyright © 2020 FL S. All rights reserved.
//

#import "SSforthVC.h"

@interface SSballModel : NSObject
@property(nonatomic,assign) int first;
@property(nonatomic,assign) int second;
@property(nonatomic,assign) int third;
@property(nonatomic,assign) int forth;
@property(nonatomic,assign) int fifth;
@property(nonatomic,assign) int sixth;
@property(nonatomic,assign) int blue;
@end

@interface SSballView : UIView
@property(nonatomic,strong) UILabel* redFirstLab;
@property(nonatomic,strong) UILabel* redSecondLab;
@property(nonatomic,strong) UILabel* redThirdLab;
@property(nonatomic,strong) UILabel* redForthLab;
@property(nonatomic,strong) UILabel* redFifthLab;
@property(nonatomic,strong) UILabel* redSixthLab;
@property(nonatomic,strong) UILabel* blueLab;

@property(nonatomic,strong) NSDictionary* dic;
@end
@implementation SSballView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView {
    self.redFirstLab = [SShelper SSlabel:[UIFont SSfont18] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:nil];
    self.redFirstLab.frame = CGRectMake(0, 0, ssscale(24), ssscale(24));
    [self addSubview:self.redFirstLab];
    
    self.redSecondLab = [SShelper SSlabel:[UIFont SSfont18] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:nil];
    self.redSecondLab.frame = CGRectMake(self.redFirstLab.maxXX+1, 0, self.redFirstLab.width, self.redFirstLab.height);
    [self addSubview:self.redSecondLab];
    
    self.redThirdLab = [SShelper SSlabel:[UIFont SSfont18] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:nil];
    self.redThirdLab.frame = CGRectMake(self.redSecondLab.maxXX+1, self.redFirstLab.YY, self.redFirstLab.width, self.redFirstLab.height);
    [self addSubview:self.redThirdLab];
    
    self.redForthLab = [SShelper SSlabel:[UIFont SSfont18] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:nil];
    self.redForthLab.frame = CGRectMake(self.redThirdLab.maxXX+1, self.redFirstLab.YY, self.redFirstLab.width, self.redFirstLab.height);
    [self addSubview:self.redForthLab];
    
    self.redFifthLab = [SShelper SSlabel:[UIFont SSfont18] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:nil];
    self.redFifthLab.frame = CGRectMake(self.redForthLab.maxXX+1, self.redFirstLab.YY, self.redFirstLab.width, self.redFirstLab.height);
    [self addSubview:self.redFifthLab];
    
    self.redSixthLab = [SShelper SSlabel:[UIFont SSfont18] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:nil];
    self.redSixthLab.frame = CGRectMake(self.redFifthLab.maxXX+1, self.redFirstLab.YY, self.redFirstLab.width, self.redFirstLab.height);
    [self addSubview:self.redSixthLab];
    
    self.blueLab = [SShelper SSlabel:[UIFont SSfont18] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:nil];
    self.blueLab.frame = CGRectMake(self.redSixthLab.maxXX+1, self.redFirstLab.YY, self.redFirstLab.width, self.redFirstLab.height);
    [self addSubview:self.blueLab];
    
    self.redFirstLab.layer.cornerRadius = self.redFirstLab.height/2;
    self.redFirstLab.layer.backgroundColor = [UIColor redColor].CGColor;
    
    self.redSecondLab.layer.cornerRadius = self.redFirstLab.height/2;
    self.redSecondLab.layer.backgroundColor = [UIColor redColor].CGColor;
    
    self.redThirdLab.layer.cornerRadius = self.redFirstLab.height/2;
    self.redThirdLab.layer.backgroundColor = [UIColor redColor].CGColor;
    
    self.redForthLab.layer.cornerRadius = self.redFirstLab.height/2;
    self.redForthLab.layer.backgroundColor = [UIColor redColor].CGColor;
    
    self.redFifthLab.layer.cornerRadius = self.redFirstLab.height/2;
    self.redFifthLab.layer.backgroundColor = [UIColor redColor].CGColor;
    
    self.redSixthLab.layer.cornerRadius = self.redFirstLab.height/2;
    self.redSixthLab.layer.backgroundColor = [UIColor redColor].CGColor;
    
    self.blueLab.layer.cornerRadius = self.redFirstLab.height/2;
    self.blueLab.layer.backgroundColor = [UIColor blueColor].CGColor;
    
}

- (void)setDic:(NSDictionary *)dic {
    NSArray* arr = [dic SSarrayForDicKey:@"1"];
    self.redFirstLab.text = [arr SSstringAtIndex:0];
    self.redSecondLab.text = [arr SSstringAtIndex:1];
    self.redThirdLab.text = [arr SSstringAtIndex:2];
    self.redForthLab.text = [arr SSstringAtIndex:3];
    self.redFifthLab.text = [arr SSstringAtIndex:4];
    self.redSixthLab.text = [arr SSstringAtIndex:5];
    self.blueLab.text = [arr SSstringAtIndex:6];
}

@end

@interface SSTwoColorBallCell : UITableViewCell
@property(nonatomic,strong) UILabel* weekLab;
@property(nonatomic,strong) SSballView* firstView;
@property(nonatomic,strong) SSballView* secondView;
@property(nonatomic,strong) SSballView* thirdView;

@property(nonatomic,strong) NSDictionary* dic;
@end
@implementation SSTwoColorBallCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSub];
    }
    return self;
}

///子视图
- (void)setSub {
    self.weekLab = [SShelper SSlabel:[UIFont SSfont16] textAlignment:NSTextAlignmentCenter textColor:[UIColor SScolorWithHex333333] backgroundColor:nil];
    self.weekLab.frame = CGRectMake(0, 0, 100, ssscale(24));
    [self addSubview:self.weekLab];
    
    self.firstView = [[SSballView alloc] initWithFrame:CGRectMake(self.weekLab.maxXX+5, 0, ScreenWidth/2, self.weekLab.height)];
    [self addSubview:self.firstView];
    
    self.secondView = [[SSballView alloc] initWithFrame:CGRectMake(0, self.firstView.maxYY+ssscale(1), ScreenWidth/2, self.firstView.height)];
    [self addSubview:self.secondView];
    
    self.thirdView = [[SSballView alloc] initWithFrame:CGRectMake(self.secondView.maxXX, self.secondView.YY, self.secondView.width, self.secondView.height)];
    [self addSubview:self.thirdView];
}

- (void)setDic:(NSDictionary *)dic {
    switch ((self.tag % 3)) {
        case 0:
            self.weekLab.text = @"星期二";
            break;
        case 1:
            self.weekLab.text = @"星期四";
            break;
        case 2:
            self.weekLab.text = @"星期日";
            break;
            
        default:
            break;
    }
    NSArray* arr = [dic SSarrayForDicKey:@"1"];
    self.firstView.dic = @{@"1":[arr SSarrayAtIndex:0]};
    self.secondView.dic = @{@"1":[arr SSarrayAtIndex:1]};
    self.thirdView.dic = @{@"1":[arr SSarrayAtIndex:2]};
}

@end

@interface SSforthVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy) NSMutableArray* muArray;
@property(nonatomic,strong) NSMutableArray* dataMuArr;
@end

@implementation SSforthVC
- (NSMutableArray *)muArray {
    if (!_muArray) {
        _muArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _muArray;
}
- (NSMutableArray *)dataMuArr {
    if (!_dataMuArr) {
        _dataMuArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataMuArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    
    [self setSub];
}

- (void)setSub {
    self.tableView.YY = 0;
    self.tableView.height = ScreenHeight-NAVIHEIGHT-TabBarHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = ssscale(55);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    weakly(self);
    [self.tableView SS_addRefreshFooterWithBlock:^{
        [weakSelf loadData];
    }];
}

- (void)loadData {
    for (int j=0; j<3; j++) {
        NSMutableArray* arr = [NSMutableArray arrayWithCapacity:1];
        for (int i=0; i<6; i++) {
            int num;
            num = (arc4random() % 33) + 1;
            do {
                num = (arc4random() % 33) + 1;
            } while ([arr containsObject:@(num)]);
            [arr addObject:@(num)];
        }
        arr = [[arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];;
        }] mutableCopy];
        
        int blue = (arc4random() % 16) + 1;
        [arr addObject:@(blue)];
        [self.muArray addObject:arr];
    }
//    NSArray* array = [self.muArray mutableCopy];
    [self.dataMuArr addObject:self.muArray.mutableCopy];
    [self.muArray removeAllObjects];
    [self.tableView SS_endRefresh];
    [self.tableView reloadData];
}

#pragma mark -------- UITableView --------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSTwoColorBallCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSTwoColorBallCell class])];
    if (!cell) {
        cell = [[SSTwoColorBallCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([SSTwoColorBallCell class])];
    }
    cell.tag = indexPath.row;
    cell.dic = @{@"1":self.dataMuArr[indexPath.row]};
    
    return cell;
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

