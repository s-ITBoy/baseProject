//
//  ViewController.h
//  baseProject
//
//  Created by FL S on 2017/7/22.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol SSViewControllerDelegate <NSObject>

- (void)getValueStr:(NSString*)str;

@end

@interface ViewController : UIViewController
@property(nonatomic,weak)id<SSViewControllerDelegate>delegate;


@property (nonatomic, strong) RACSubject *delegateSignal;
@end

