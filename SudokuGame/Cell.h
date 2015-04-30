//
//  Cell.h
//  SudokuGame
//
//  Created by Shannon Sun on 2015-04-23.
//  Copyright (c) 2015 InnoLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell : NSObject

@property (nonatomic) int row;
@property (nonatomic) int column;
@property (nonatomic) int cellVal;

@end
