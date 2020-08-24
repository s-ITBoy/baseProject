//
//  SSautoTableV.h
//  ddz
//
//  Created by F S on 2017/12/23.
//  Copyright © 2017 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SStableVObject : NSObject
@property (nonatomic, weak) id receiver;
@property (nonatomic, weak) id middleMan;
@end

NS_ASSUME_NONNULL_BEGIN
///自动循环滚动的tableview
@interface SSautoTableV : UITableView

@end

NS_ASSUME_NONNULL_END
