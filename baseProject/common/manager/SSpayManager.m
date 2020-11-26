//
//  SSpayManager.m
//  baseProject
//
//  Created by F S on 2017/8/28.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSpayManager.h"
//#import <AlipaySDK/AlipaySDK.h>

#define AlipayScheme  @"leeMailAliSDK"
#define TIME_STAMP    [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate date] timeIntervalSince1970]]

@implementation SSpayManager
static SSpayManager* shareManager = nil;
+ (instancetype)sharePayManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[SSpayManager alloc] init];
    });
    return shareManager;
}

- (void)AlipayWithOrderString:(NSString*) orderString payBlock:(payBlock)payBlock{
    _returnBlock = payBlock;
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:AlipayScheme callback:^(NSDictionary *resultDic) {
//        [self aliPayResult:resultDic];
//    }];
}

- (void)aliPayResult:(NSDictionary*)resultDic{
    NSInteger status = [resultDic[@"resultStatus"] integerValue];
    if (status == 9000) {
        [self presentMessageTips:@"支付成功"];
        //        [[NSNotificationCenter defaultCenter] postNotificationName:paySuccess object:nil];
        
        if (_returnBlock) {
            _returnBlock(YQpayManagerPayTypeSuccess);
        }
        
    }else{
        if (_returnBlock) {
            _returnBlock(YQpayManagerPayTypefailure);
        }
        
        NSString* msg = resultDic[@"memo"];
        if(msg.length < 1){
            switch (status) {
                case 8000:
                    [self presentMessageTips:@"正在处理中"];
                    break;
                case 6001:
                    [self presentMessageTips:@"取消支付"];
                    break;
                case 6002:
                    [self presentMessageTips:@"网络连接错误"];
                    break;
                default:
                    [self presentMessageTips:@"支付失败"];
                    break;
            }
        }
    }
}

- (void)WeichatPay:(NSDictionary*)orderDic payBlock:(payBlock)payBlock{
    _returnBlock = payBlock;
//    NSMutableString *codeStr = [orderDic objectForKey:@"wxOrderId"];
//    NSMutableString* codeStr = [orderDic objectForKey:@"prepay_id"];
//    if (codeStr){
//        //调起微信支付
//        PayReq* req             = [[PayReq alloc] init];
//        req.openID              = @"";
//        req.partnerId           = @"1531602121";
//        req.prepayId            = codeStr;
//        req.nonceStr            =  TIME_STAMP;
//        req.timeStamp           =  [[NSDate date] timeIntervalSince1970];
//        req.package = @"Sign=WXPay";
//        req.sign                =  [self createMD5SingForPayReq:req merKey:Weichat_key];
//        [WXApi registerApp:Weichat_appid];
//
//        BOOL payResult = [WXApi sendReq:req];
//        //日志输出
//        if (!payResult) {
//            NSLog(@"%@",[WXApi getApiVersion]);
//            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimeStamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//        }
//    }
}

////创建发起支付时的sign签名
//-(NSString *)createMD5SingForPayReq:(PayReq*)req merKey:(NSString*)merKey{
//    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
//    [signParams setObject:Weichat_appid forKey:@"appid"];//微信appid 例如wxfb132134e5342
//    [signParams setObject:req.nonceStr forKey:@"noncestr"];//随机字符串
//    [signParams setObject:req.package forKey:@"package"];//扩展字段  参数为 Sign=WXPay
//    [signParams setObject:req.partnerId forKey:@"partnerid"];//商户账号
//    [signParams setObject:req.prepayId forKey:@"prepayid"];//此处为统一下单接口返回的预支付订单号
//    [signParams setObject:[NSString stringWithFormat:@"%u",(unsigned int)req.timeStamp] forKey:@"timestamp"];//时间戳
//    NSMutableString *contentString  =[NSMutableString string];
//    NSArray *keys = [signParams allKeys];
//    //按字母顺序排序
//    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//    //拼接字符串
//    for (NSString *categoryId in sortedArray) {
//        if (![[signParams objectForKey:categoryId] isEqualToString:@""] && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"] && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]) {
//            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
//        }
//    }
//    //添加商户密钥key字段  API 密钥
//    [contentString appendFormat:@"key=%@",merKey];
//    NSString *result = [contentString ss_MD5String];//md5加密
//    return result;
//}

#pragma mark ------- WXApiDelegate ------------
//-(void) onResp:(BaseResp*)resp{
//    if([resp isKindOfClass:[PayResp class]]){
//        switch (resp.errCode) {
//            case WXSuccess:{
//                [self presentMessageTips:@"支付成功"];
//                if (_returnBlock) {
//                    _returnBlock(YQpayManagerPayTypeSuccess);
//                }
//                //                [[NSNotificationCenter defaultCenter] postNotificationName:paySuccess object:nil];
//                
//            }
//                break;
//            case WXErrCodeUserCancel:
//                [self presentMessageTips:@"取消支付"];
//                if (_returnBlock) {
//                    _returnBlock(YQpayManagerPayTypefailure);
//                }
//                break;
//            default:
//                [self presentMessageTips:@"支付失败"];
//                if (_returnBlock) {
//                    _returnBlock(YQpayManagerPayTypefailure);
//                }
//                break;
//        }
//    }
//}

@end
