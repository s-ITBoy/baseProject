//
//  UIButton+SS.h
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (SS)
#pragma ---------------扩大响应区域----------------
-(void)SSaddEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
-(void)SSaddEnlargeEdge:(CGFloat) size;
@end

