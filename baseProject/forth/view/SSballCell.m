//
//  SSballCell.m
//  baseProject
//
//  Created by FL S on 2020/11/22.
//  Copyright © 2020 FL S. All rights reserved.
//

#import "SSballCell.h"

@implementation SSballCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

@end
