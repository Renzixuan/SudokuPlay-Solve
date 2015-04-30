//
//  ViewController.h
//  SudokuGame
//
//  Created by Shannon Sun on 2015-04-23.
//  Copyright (c) 2015 InnoLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cell.h"
#import "TableViewCell.h"

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

- (Cell *)getNextCell:(Cell *)cell;
- (BOOL) isValid:(Cell *)cell withValue:(int)value;
-(void)endGame: (Cell*)cell;
@property (nonatomic,strong) NSMutableArray * boxArray;
@property (assign) BOOL isValid;
@property (weak, nonatomic) IBOutlet UILabel *gridLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UIView *sudokuView;
@property (weak, nonatomic) IBOutlet UITableView *gridTableView;
@property (nonatomic,strong) TableViewCell *rowCells;

@end

