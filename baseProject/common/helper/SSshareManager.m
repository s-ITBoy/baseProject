//
//  SSshareManager.m
//  ddz
//
//  Created by F S on 2017/12/17.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SSshareManager.h"

#define QQ_appid  @"101527387"

@implementation SSshareModel

@end

@interface SSshareManager ()
@property(nonatomic,copy) void (^CallBackBlock) (BOOL isSuccess, NSString* msg);

@end
@implementation SSshareManager

static SSshareManager* manager = nil;
+ (instancetype)sharemanager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SSshareManager alloc] init];
    });
    return manager;
}

- (void)sharecontent:(SSshareModel*)model and:(void(^) (BOOL isSuccess, NSString* msg))callBackBlock{
    self.CallBackBlock = callBackBlock;
//    [self shareToWhere:model.shareToWhere and:model];
}

//- (void)shareToWhere:(NSInteger)where and:(SSshareModel*)model{
//    switch (where) {
//        case 0:
//        case 1:{
////            [WXApi registerApp:Weichat_appid];//delegate中注册了，这里就不需要了
//            WXMediaMessage* mediaMsg = [[WXMediaMessage alloc] init];
//
//
//            if (model.type == 0) {
//                mediaMsg.title = model.title;
//                mediaMsg.description = model.descript;
//                [mediaMsg setThumbImage:[UIImage imageWithData:model.thumbData]];
//
//                WXWebpageObject* web = [[WXWebpageObject alloc] init];
//                web.webpageUrl = model.webUrlStr;
//                mediaMsg.mediaObject = web;
//            }else if (model.type == 1)  {
////                [mediaMsg setThumbImage:[UIImage imageWithData:model.thumbData]];
////                [mediaMsg setThumbData:model.thumbData];
////                mediaMsg.thumbData = model.thumbData;
//
//                WXImageObject* imageObj = [[WXImageObject alloc] init];
//                imageObj.imageData = model.thumbData;
//                mediaMsg.mediaObject = imageObj;
//            }
//
//            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//            req.bText = NO;
//            req.message = mediaMsg;
//            req.scene = where == 0 ? WXSceneSession : WXSceneTimeline;
//
//            [WXApi sendReq:req];
//        }
//            break;
//        case 3:
//
//            break;
////        case 2:{
////            if (![QQApiInterface isSupportShareToQQ]) {
////                [self presentMessageTips:@"没有安装QQ"];
////                return;
////            }
////            TencentOAuth* tencent = [[TencentOAuth alloc] initWithAppId:QQ_appid andDelegate:nil];
////            NSData* data = [[UIImage imageNamed:model.logo] ss_imageToData];
////            QQApiNewsObject *news = [QQApiNewsObject
////                                    objectWithURL:[NSURL URLWithString:model.webUrlStr]
////                                    title:model.title
////                                    description:model.descript
////                                    previewImageData:data];
////            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:news];
////            //将内容分享到qq
////            //QQApiSendResultCode sent = [QQApiInterface sendReq:req];
////            //将内容分享到qzone
////            [QQApiInterface sendReq:req];
////        }
////            break;
//
//        default:
//            break;
//    }
//}

#pragma mark --------- WXApiDelegate -----------
/*
 App 分享功能调整
 为鼓励用户自发分享喜爱的内容，减少“强制分享至不同群”等滥用分享能力，破坏用户体验的行为，微信开放平台分享功能即日起做出如下调整：
 新版微信客户端（6.7.2及以上版本）发布后，用户从App中分享消息给微信好友，或分享到朋友圈时，开发者将无法获知用户是否分享完成。
 具体调整点为：分享接口调用后，不再返回用户是否分享完成事件，即原先的cancel事件和success事件将统一为success事件。
 请开发者尽快做好调整。
 */
//-(void) onResp:(BaseResp*)resp{
//    if([resp isKindOfClass:[SendMessageToWXResp class]]){
//        SSLog(@"---------resp.errCode = %d ---------",resp.errCode);
//
//        switch (resp.errCode) {
//
//            case WXErrCodeUserCancel:
//                self.CallBackBlock(NO, @"用户取消");
//                break;
//            case WXSuccess:
//                self.CallBackBlock(YES, @"分享成功");
//                break;
//            default:
//                self.CallBackBlock(NO, @"分享失败");
//                break;
//        }
//    }
//}

@end
