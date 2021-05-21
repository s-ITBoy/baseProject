//
//  SSboxCodeView.m
//  baseProject
//
//  Created by F S on 2017/4/24.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSboxCodeView.h"

@interface SSboxCodeView ()
// 占位编辑框(这样就点击密码格以外的部分,可以弹出键盘)
@property (weak, nonatomic) UITextField *contentTextField;
@property (strong, nonatomic) NSMutableArray *boxes;
@end
@implementation SSboxCodeView
#pragma mark --- 懒加载
- (NSMutableArray *)boxes {
    if (!_boxes) {
        _boxes = [NSMutableArray array];
    }
    return _boxes;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        [self setSubV];
    }
    return self;
}

- (void)setSubV {
     UITextField *contentField = [[UITextField alloc] initWithFrame:CGRectMake(-50, 0, self.frame.size.width+50, self.frame.size.height)];
    self.contentTextField = contentField;
//    contentField.placeholder = @"请输入支付密码";
//    contentField.keyboardType = UIKeyboardTypePhonePad;
    contentField.textColor = [UIColor clearColor];
    contentField.tintColor = [UIColor clearColor];
//    contentField.hidden = YES;
    [contentField addTarget:self action:@selector(txchange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:contentField];
        
    // 密码格之间的间隔
//    CGFloat margin = 27;
    for (int i = 0; i < boxCount; i++){
        CGFloat x = ([UIScreen mainScreen].bounds.size.width - boxCount * boxW - (boxCount - 1)* margin) * 0.5 + (boxW + margin) * i;
        UITextField *pwdLabel = [[UITextField alloc] initWithFrame:CGRectMake(x, (self.frame.size.height - boxH) * 0.5, boxW, boxH)];
        pwdLabel.font = [UIFont systemFontOfSize:48];
        pwdLabel.borderStyle = UITextBorderStyleRoundedRect;
        pwdLabel.backgroundColor = [UIColor whiteColor];
        pwdLabel.enabled = NO;
        pwdLabel.textAlignment = NSTextAlignmentCenter;//居中
//        pwdLabel.secureTextEntry = YES;//设置密码模式
//        pwdLabel.layer.borderColor = [UIColor SScolorWithHexString:@"#6D6D6D"].CGColor;
//        pwdLabel.layer.cornerRadius = 9.5;
//        pwdLabel.layer.borderWidth = 1;
//        pwdLabel.layer.masksToBounds = YES;
        [pwdLabel SSsetlayerOfViewRadius:9.5 andLineWidth:1 andLineCorlor:[UIColor SScolorWithHexString:@"#969696"]];
        [self addSubview:pwdLabel];
        
        [self.boxes addObject:pwdLabel];
    }
    
}

#pragma mark 文本框内容改变
- (void)txchange:(UITextField *)tx {
    NSString *password = tx.text;
    [self textChange:password];
}

-(void)textChange:(NSString*)password {
    for (int i = 0; i < self.boxes.count; i++){
        UITextField *pwdtx = [self.boxes objectAtIndex:i];
        pwdtx.text = @"";
//        pwdtx.layer.cornerRadius = 9.5;
//        pwdtx.layer.borderColor = [UIColor SScolorWithHexString:@"#969696"].CGColor;
        if (i < password.length){
            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdtx.text = pwd;
//            pwdtx.layer.borderColor = [UIColor colorWithRed:0/255.0 green:112/255.0 blue:201/255.0 alpha:1].CGColor;
        }else{
//            pwdtx.layer.borderColor = [UIColor SScolorWithHexString:@"#969696"].CGColor;
        }
    }
    // 输入密码完毕
    if (password.length == boxCount){
        [self.contentTextField resignFirstResponder];//隐藏键盘
        if (self.SSReturnPasswordStrBLock) {
            self.SSReturnPasswordStrBLock(password);
        }
    }
}

- (void)becomeFirstReponse {
    //进入界面，contentTextField 成为第一响应
    [self.contentTextField becomeFirstResponder];
}

- (void)changeText:(NSString*)text {
    [self textChange:text];
}

-(void)clearText {
    self.contentTextField.text = @"";
    [self.contentTextField resignFirstResponder];
    [self textChange:@""];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
