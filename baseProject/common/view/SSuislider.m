//
//  SSuislider.m
//  baseProject
//
//  Created by F S on 2017/7/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSuislider.h"

@implementation SSuislider


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent: event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGRect t = [self trackRectForBounds: [self bounds]];
    float v = [self minimumValue] + ([[touches anyObject] locationInView: self].x - t.origin.x - 4.0) * (([self maximumValue]-[self minimumValue]) / (t.size.width - 8.0));
    [self setValue: v];
    [super touchesEnded:touches withEvent:event];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
