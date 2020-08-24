//
//  SStextLayer.m
//  ddz
//
//  Created by F S on 2017/12/23.
//  Copyright © 2017 F S. All rights reserved.
//

#import "SStextLayer.h"
#import "SSbezierCurve.h"
#import <CoreText/CoreText.h>

#define kPointsNumber 100 // 即数字跳100次
#define kDurationTime 5.0 // 动画时间
#define kStartNumber  0   // 起始数字
#define kEndNumber    1000// 结束数字

@interface SStextLayer ()
@property (nonatomic, assign) int pointsNumber;
@property (nonatomic, assign) float durationTime;
@property (nonatomic, assign) float startNumber;
@property (nonatomic, assign) float endNumber;

@property (nonatomic, retain) NSMutableArray *numberPoints;//记录每次textLayer更改值的间隔时间及输出值。
@property (nonatomic, assign) float lastTime;
@property (nonatomic, assign) int indexNumber;

@property (nonatomic, assign) Point2D startPoint;
@property (nonatomic, assign) Point2D controlPoint1;
@property (nonatomic, assign) Point2D controlPoint2;
@property (nonatomic, assign) Point2D endPoint;
@end
@implementation SStextLayer
- (void)cleanUpValue {
    _lastTime = 0;
    _indexNumber = 0;
    self.string = [NSString stringWithFormat:@"%.2f",_startNumber];
}

- (void)jumpNumberWithDuration:(int)duration
                    fromNumber:(float)startNumber
                      toNumber:(float)endNumber {
    _durationTime = duration;
    _startNumber = startNumber;
    _endNumber = endNumber;
    
    [self cleanUpValue];
    [self initPoints];
    [self changeNumberBySelector];
}

- (void)jumpNumber {
    [self jumpNumberWithDuration:kDurationTime fromNumber:kStartNumber toNumber:kEndNumber];
}

- (void)initPoints {
    // 贝塞尔曲线
    [self initBezierPoints];
    Point2D bezierCurvePoints[4] = {_startPoint, _controlPoint1, _controlPoint2, _endPoint};
    _numberPoints = [[NSMutableArray alloc] init];
    float dt;
    dt = 1.0 / (kPointsNumber - 1);
    for (int i = 0; i < kPointsNumber; i++) {
        Point2D point = PointOnCubicBezier(bezierCurvePoints, i*dt);
        float durationTime = point.x * _durationTime;
        float value = point.y * (_endNumber - _startNumber) + _startNumber;
        [_numberPoints addObject:[NSArray arrayWithObjects:[NSNumber numberWithFloat:durationTime], [NSNumber numberWithFloat:value], nil]];
    }
}

- (void)initBezierPoints {
    // 可到http://cubic-bezier.com自定义贝塞尔曲线
    
    _startPoint.x = 0;
    _startPoint.y = 0;
    
    _controlPoint1.x = 0.25;
    _controlPoint1.y = 0.1;
    
    _controlPoint2.x = 0.25;
    _controlPoint2.y = 1;
    
    _endPoint.x = 1;
    _endPoint.y = 1;
}

- (void)changeNumberBySelector {
    NSMutableAttributedString* attri = nil;
    UIFont *font = [UIFont SSCustomBoldFont:55];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    NSDictionary *attribs = @{
      (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor SScolorWithHexString:@"#DF2C22"].CGColor,
      (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
    };
    
    UIFont* font2 = [UIFont SSCustomBoldFont:24.5];
    CFStringRef fontName2 = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize2 = font2.pointSize;
    CTFontRef fontRef2 = CTFontCreateWithName(fontName2, fontSize2, NULL);
    NSDictionary *attribs2 = @{
      (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor SScolorWithHexString:@"#DF2C22"].CGColor,
      (__bridge id)kCTFontAttributeName: (__bridge id)fontRef2
    };
    
    if (_indexNumber >= kPointsNumber) {
        attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %.2f",_endNumber]];
        [attri setAttributes:attribs2 range:NSMakeRange(0, 2)];
        [attri setAttributes:attribs range:NSMakeRange(2, attri.length-2)];
        
        self.string = attri;
//        self.string = [NSString stringWithFormat:@"%.2f",_endNumber];
        return;
    } else {
        NSArray *pointValues = [_numberPoints objectAtIndex:_indexNumber];
        _indexNumber++;
        float value = [(NSNumber *)[pointValues objectAtIndex:1] floatValue];// 有时要改成floatValue
        float currentTime = [(NSNumber *)[pointValues objectAtIndex:0] floatValue];
        float timeDuration = currentTime - _lastTime;
        _lastTime = currentTime;
        
        attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %.2f",value]];
        [attri setAttributes:attribs2 range:NSMakeRange(0, 2)];
        [attri setAttributes:attribs range:NSMakeRange(2, attri.length-2)];

        self.string = attri;
//        self.string = [NSString stringWithFormat:@"%.2f",value];
        [self performSelector:@selector(changeNumberBySelector) withObject:nil afterDelay:timeDuration];
    }
}
@end
