//
//  MiddleTableViewCell.m
//  SudokuGame
//
//  Created by Lily Ren on 2015-04-28.
//  Copyright (c) 2015 InnoLab. All rights reserved.
//

#import "MiddleTableViewCell.h"

@implementation MiddleTableViewCell
@synthesize rowCells2;

- (void)awakeFromNib {
    // Initialization code
    for (int i = 2; i < 5; i++) {
        [rowCells2[i] setBackgroundColor:[UIColor colorWithRed:200.0f/225.0f green:200.0f/225.0f blue:200.0f/225.0f alpha:1]];
        }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
