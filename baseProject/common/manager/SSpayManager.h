//
//  SSpayManager.h
//  baseProject
//
//  Created by F S on 2017/8/28.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    YQpayManagerPayTypefailure = 0,      //支付失败
    YQpayManagerPayTypeSuccess           //支付成功
} YQpayManagerPayType;

typedef void (^payBlock)(YQpayManagerPayType type);
NS_ASSUME_NONNULL_BEGIN

@interface SSpayManager : NSObject
///<WXApiDelegate>
{
    payBlock _returnBlock;
}

+ (instancetype)sharePayManager;
- (void)AlipayWithOrderString:(NSString*) orderString payBlock:(payBlock)payBlock;
- (void)aliPayResult:(NSDictionary*)resultDic;

- (void)WeichatPay:(NSDictionary*)orderDic payBlock:(payBlock)payBlock;

@end

NS_ASSUME_NONNULL_END
