//
//  MiddleTableViewCell.h
//  SudokuGame
//
//  Created by Lily Ren on 2015-04-28.
//  Copyright (c) 2015 InnoLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiddleTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *rowCells2;

@end
