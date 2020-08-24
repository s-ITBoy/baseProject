//
//  SSbezierCurve.h
//  ddz
//
//  Created by F S on 2017/12/23.
//  Copyright © 2017 F S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef struct
{
    float x;
    float y;
} Point2D;

@interface SSbezierCurve : NSObject
Point2D PointOnCubicBezier(Point2D* cp, float t);
@end

NS_ASSUME_NONNULL_END
