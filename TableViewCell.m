//
//  TableViewCell.m
//  SudokuGame
//
//  Created by Lily Ren on 2015-04-28.
//  Copyright (c) 2015 InnoLab. All rights reserved.
//

#import "TableViewCell.h"
#import "ViewController.h"

@implementation TableViewCell
@synthesize rowCells;

- (void)awakeFromNib {
    // Initialization code
    for (int i = 0, r = 6; i < 3; i++) {
        [rowCells[i] setBackgroundColor:[UIColor colorWithRed:200.0f/225.0f green:200.0f/225.0f blue:200.0f/225.0f alpha:1]];
        if (r < 9) {
            [rowCells[r] setBackgroundColor:[UIColor colorWithRed:200.0f/225.0f green:200.0f/225.0f blue:200.0f/225.0f alpha:1]];
            r++;
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
