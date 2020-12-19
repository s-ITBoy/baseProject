//
//  SSRACmanager.h
//  baseProject
//
//  Created by F S on 2020/12/19.
//  Copyright © 2020 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSRACmanager : NSObject

@end

NS_ASSUME_NONNULL_END
/*
 RAC代替 代理 篇 （类似于代理的步骤）
 第一步：在VC2 中 添加 @property (nonatomic, strong) RACSubject *delegateSignal;
 第二步：在VC2 中 对应的地方 通知代理
        if (self.delegateSignal) {
         // 有值，才需要通知
         [self.delegateSignal sendNext:nil];
        }
 第三步：在VC1 中 对应的地方 设置代理信号 订阅代理信号
        twoVc.delegateSignal = [RACSubject subject];
        // 订阅代理信号
        [twoVc.delegateSignal subscribeNext:^(id x) {
 
        }];
         // 跳转到第二个控制器
         [self presentViewController:twoVc animated:YES completion:nil];
 */

/*
 RACSequence:RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典。
 // 这里其实是三步
     // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
     // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
     // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
                 NSArray *numbers = @[@1,@2,@3,@4];
                 [numbers.rac_sequence.signal subscribeNext:^(id x) {
                     NSLog(@"%@",x);
                 }];
 */

/*
 RACMulticastConnection:用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用这个类处理。
 RACMulticastConnection通过RACSignal的-publish或者-muticast:方法创建
     RACMulticastConnection *connect = [signal publish];
     RACMulticastConnection *connect = [signal multicast:[RACSubject subject]];
 RACMulticastConnection使用步骤:
     // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
     // 2.创建连接 RACMulticastConnection *connect = [signal publish];
     // 3.订阅信号,注意：订阅的不在是之前的信号，而是连接的信号。 [connect.signal subscribeNext:nextBlock] (多次订阅，此方法重复多次)
     // 4.连接 [connect connect]
             // 1.创建请求信号
             RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                 NSLog(@"发送请求");
                [subscriber sendNext:@1];
                 return nil;
             }];
             RACMulticastConnection *connect = [signal publish];
             [connect.signal subscribeNext:^(id x) {
                 NSLog(@"订阅者一信号");
             }];
             [connect.signal subscribeNext:^(id x) {
                 NSLog(@"订阅者二信号");

             }];
             [connect connect];
 
 RACMulticastConnection底层原理:
     // 1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
     // 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
     // 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
     // 3.1.订阅原始信号，就会调用原始信号中的didSubscribe
     // 3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
     // 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
     // 4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock
 
 需求：假设在一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
     // 解决：使用RACMulticastConnection就能解决.
 */

/*
 RACCommand:RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。
 使用场景:监听按钮点击，网络请求
 RACCommand使用步骤:
     // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
     // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
     // 3.执行命令 - (RACSignal *)execute:(id)input
 */
