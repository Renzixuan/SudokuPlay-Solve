//
//  ViewController.m
//  SudokuGame
//
//  Created by Shannon Sun on 2015-04-23.
//  Copyright (c) 2015 InnoLab. All rights reserved.
//

//Algorithm:
//
//1 solveCell(currentCell)
//2 If currentCell not empty, call solve(nextCell)
//3 If currentCell is empty (grid[currentCell.x][currentCell.y] == 0)
//4 Add value v (v belongs to 1-9)
//5 Check if v is valid for cell
//6 if not valid, continue to step 4
//7 If valid, call solveCell(nextCell)
//8 If sudoku is solved, return true
//9 Else return false

#import "ViewController.h"
#import "TableViewCell.h"
#import "MiddleTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize boxArray,isValid,gridLabel,noteLabel,resultView,sudokuView,gridTableView;
NSUInteger grid[9][9];
- (void)viewDidLoad {
    [super viewDidLoad];
    //setups
    resultView.hidden = YES;
    sudokuView.hidden  = NO;
    noteLabel.text = @"Work your brain man!";
    gridTableView.dataSource = self;
    gridTableView.delegate = self;
    
    //dismiss keyboard
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tapBackground];
    
    //init grid here, set up the game.
    //row one
    grid[0][0] = 0;
    grid[0][1] = 0;
    grid[0][2] = 0;
    grid[0][3] = 0;
    grid[0][4] = 0;
    grid[0][5] = 0;
    grid[0][6] = 0;
    grid[0][7] = 1;
    grid[0][8] = 2;
    //row two
    grid[1][0] = 0;
    grid[1][1] = 0;
    grid[1][2] = 0;
    grid[1][3] = 0;
    grid[1][4] = 0;
    grid[1][5] = 0;
    grid[1][6] = 0;
    grid[1][7] = 0;
    grid[1][8] = 3;
    //row three
    grid[2][0] = 0;
    grid[2][1] = 0;
    grid[2][2] = 2;
    grid[2][3] = 3;
    grid[2][4] = 0;
    grid[2][5] = 0;
    grid[2][6] = 4;
    grid[2][7] = 0;
    grid[2][8] = 0;
    //row four
    grid[3][0] = 0;
    grid[3][1] = 0;
    grid[3][2] = 1;
    grid[3][3] = 8;
    grid[3][4] = 0;
    grid[3][5] = 0;
    grid[3][6] = 0;
    grid[3][7] = 0;
    grid[3][8] = 5;
    //row five
    grid[4][0] = 0;
    grid[4][1] = 6;
    grid[4][2] = 0;
    grid[4][3] = 0;
    grid[4][4] = 7;
    grid[4][5] = 0;
    grid[4][6] = 8;
    grid[4][7] = 0;
    grid[4][8] = 0;
    //row six
    grid[5][0] = 0;
    grid[5][1] = 0;
    grid[5][2] = 0;
    grid[5][3] = 0;
    grid[5][4] = 0;
    grid[5][5] = 9;
    grid[5][6] = 0;
    grid[5][7] = 0;
    grid[5][8] = 0;
    //row seven
    grid[6][0] = 0;
    grid[6][1] = 0;
    grid[6][2] = 8;
    grid[6][3] = 5;
    grid[6][4] = 0;
    grid[6][5] = 0;
    grid[6][6] = 0;
    grid[6][7] = 0;
    grid[6][8] = 0;
    //row eight
    grid[7][0] = 9;
    grid[7][1] = 0;
    grid[7][2] = 0;
    grid[7][3] = 0;
    grid[7][4] = 4;
    grid[7][5] = 0;
    grid[7][6] = 5;
    grid[7][7] = 0;
    grid[7][8] = 0;
    //row nine
    grid[8][0] = 4;
    grid[8][1] = 7;
    grid[8][2] = 0;
    grid[8][3] = 0;
    grid[8][4] = 0;
    grid[8][5] = 6;
    grid[8][6] = 0;
    grid[8][7] = 0;
    grid[8][8] = 0;

    }

- (IBAction)solveSudoku:(id)sender {
    Cell* curentCell = [[Cell alloc]init];
    curentCell.row = 0;
    curentCell.column = 0;
    sudokuView.hidden = YES;
    [self solveCell:curentCell];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (bool)solveCell:(Cell *)currentCell {

    //if the cell is nil, that means we have reached the end of sudoku board
    if(currentCell.row > 8) {
        [self endGame:currentCell];
    }
    
    //current cell already has a value in the grid, there's nothing to solve here, continue to the next cell
    if(grid[currentCell.row][currentCell.column] != 0)
        return [self solveCell:[self getNextCell:currentCell]];
    
    //if current cell does not have a value, try each possible value
    for(int i = 1; i <= 9; i++) {
        //check if the value i is valid for current cell, if it's valid, then update
        bool realValid = [self isValid:currentCell withValue:i];
        
        //if i is not valid for current cell, stop here, try another value for i
        if(!realValid)
            continue;
        
        //assign the value i here
        grid[currentCell.row][currentCell.column] = i;
        
        //continue with next cell
        bool isSolved = [self solveCell:[self getNextCell:currentCell]];
        
        
        //if solved, return true, otherwise try other values
        if(isSolved) {
            return true;
        }
        else {
            grid[currentCell.row][currentCell.column] = 0; //reset
            //continue with other possible values
        }
        
    }
    return false;
}

- (BOOL) isValid:(Cell *)cell withValue:(int)value {
    
    //check value is valid for a cell, you will need to check if there's any conflict for row values, column values and 3x3 grid values
    if (isValid == YES) {
        return true;
    }
    else{
        bool rowValid = [self checkRow:cell withValue:value];
        if (rowValid) {
            bool columnValid = [self checkColumn:cell withValue:value];
            if (columnValid) {
                bool gridValid = [self checkGrid:cell withValue:value andBox:[self getBoxCells:cell]];
                if (gridValid) {
                    grid[cell.row][cell.column] = value;
                    if ([self solveCell:cell]) {
                        return true;
                    }
                    else{
                        grid[cell.row][cell.column] = 0;
                    }
                }
            }
        }
    return  isValid;
    }
}



- (Cell *) getNextCell:(Cell *)cell {
    int row = cell.row;
    int column = cell.column;
    
    //We move the next cell to next column  but same row
    column++;
    
    //If we have moved to the end of column, we need to move the next row but reset the column to 0
    if(column > 8) {
        column = 0;
        row++;
    }
    
    //if everything is fine, construct next cell
    Cell *nextCell = [[Cell alloc] init];
    nextCell.row = row;
    nextCell.column = column;
    return nextCell;
    
}

//all the checks
- (NSMutableArray*) getBoxCells: (Cell*)cell{
    boxArray = [[NSMutableArray alloc]init];
    if (cell.column < 3) {
        if (cell.row < 3) {
            boxArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:grid[0][0]],[NSNumber numberWithUnsignedInteger:grid[0][1]],[NSNumber numberWithUnsignedInteger:grid[0][2]],[NSNumber numberWithUnsignedInteger:grid[1][0]],[NSNumber numberWithUnsignedInteger:grid[1][1]],[NSNumber numberWithUnsignedInteger:grid[1][2]],[NSNumber numberWithUnsignedInteger:grid[2][0]],[NSNumber numberWithUnsignedInteger:grid[2][1]],[NSNumber numberWithUnsignedInteger:grid[2][2]], nil];
        }
        else if (cell.row < 6)
        {
            boxArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:grid[3][0]],[NSNumber numberWithUnsignedInteger:grid[3][1]],[NSNumber numberWithUnsignedInteger:grid[3][2]],[NSNumber numberWithUnsignedInteger:grid[4][0]],[NSNumber numberWithUnsignedInteger:grid[4][1]],[NSNumber numberWithUnsignedInteger:grid[4][2]],[NSNumber numberWithUnsignedInteger:grid[5][0]],[NSNumber numberWithUnsignedInteger:grid[5][1]],[NSNumber numberWithUnsignedInteger:grid[5][2]], nil];
        }
        else if (cell.row < 9){
            boxArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:grid[6][0]],[NSNumber numberWithUnsignedInteger:grid[6][1]],[NSNumber numberWithUnsignedInteger:grid[6][2]],[NSNumber numberWithUnsignedInteger:grid[7][0]],[NSNumber numberWithUnsignedInteger:grid[7][1]],[NSNumber numberWithUnsignedInteger:grid[7][2]],[NSNumber numberWithUnsignedInteger:grid[8][0]],[NSNumber numberWithUnsignedInteger:grid[8][1]],[NSNumber numberWithUnsignedInteger:grid[8][2]], nil];
        }
    }
    else if (cell.column < 6){
        if (cell.row < 3) {
            boxArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:grid[0][3]],[NSNumber numberWithUnsignedInteger:grid[0][4]],[NSNumber numberWithUnsignedInteger:grid[0][5]],[NSNumber numberWithUnsignedInteger:grid[1][3]],[NSNumber numberWithUnsignedInteger:grid[1][4]],[NSNumber numberWithUnsignedInteger:grid[1][5]],[NSNumber numberWithUnsignedInteger:grid[2][3]],[NSNumber numberWithUnsignedInteger:grid[2][4]],[NSNumber numberWithUnsignedInteger:grid[2][5]], nil];
        }
        else if (cell.row < 6)
        {
            boxArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:grid[3][3]],[NSNumber numberWithUnsignedInteger:grid[3][4]],[NSNumber numberWithUnsignedInteger:grid[3][5]],[NSNumber numberWithUnsignedInteger:grid[4][3]],[NSNumber numberWithUnsignedInteger:grid[4][4]],[NSNumber numberWithUnsignedInteger:grid[4][5]],[NSNumber numberWithUnsignedInteger:grid[5][3]],[NSNumber numberWithUnsignedInteger:grid[5][4]],[NSNumber numberWithUnsignedInteger:grid[5][5]], nil];
        }
        else if (cell.row < 9){
            boxArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:grid[6][3]],[NSNumber numberWithUnsignedInteger:grid[6][4]],[NSNumber numberWithUnsignedInteger:grid[6][5]],[NSNumber numberWithUnsignedInteger:grid[7][3]],[NSNumber numberWithUnsignedInteger:grid[7][4]],[NSNumber numberWithUnsignedInteger:grid[7][5]],[NSNumber numberWithUnsignedInteger:grid[8][3]],[NSNumber numberWithUnsignedInteger:grid[8][4]],[NSNumber numberWithUnsignedInteger:grid[8][5]], nil];
        }
    }
    else if (cell.column < 9){
        if (cell.row < 3) {
            boxArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:grid[0][6]],[NSNumber numberWithUnsignedInteger:grid[0][7]],[NSNumber numberWithUnsignedInteger:grid[0][8]],[NSNumber numberWithUnsignedInteger:grid[1][6]],[NSNumber numberWithUnsignedInteger:grid[1][7]],[NSNumber numberWithUnsignedInteger:grid[1][8]],[NSNumber numberWithUnsignedInteger:grid[2][6]],[NSNumber numberWithUnsignedInteger:grid[2][7]],[NSNumber numberWithUnsignedInteger:grid[2][8]], nil];
        }
        else if (cell.row < 6)
        {
            boxArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:grid[3][6]],[NSNumber numberWithUnsignedInteger:grid[3][7]],[NSNumber numberWithUnsignedInteger:grid[3][8]],[NSNumber numberWithUnsignedInteger:grid[4][6]],[NSNumber numberWithUnsignedInteger:grid[4][7]],[NSNumber numberWithUnsignedInteger:grid[4][8]],[NSNumber numberWithUnsignedInteger:grid[5][6]],[NSNumber numberWithUnsignedInteger:grid[5][7]],[NSNumber numberWithUnsignedInteger:grid[5][8]], nil];
        }
        else if (cell.row < 9){
            boxArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:grid[6][6]],[NSNumber numberWithUnsignedInteger:grid[6][7]],[NSNumber numberWithUnsignedInteger:grid[6][8]],[NSNumber numberWithUnsignedInteger:grid[7][6]],[NSNumber numberWithUnsignedInteger:grid[7][7]],[NSNumber numberWithUnsignedInteger:grid[7][8]],[NSNumber numberWithUnsignedInteger:grid[8][6]],[NSNumber numberWithUnsignedInteger:grid[8][7]],[NSNumber numberWithUnsignedInteger:grid[8][8]], nil];
        }
    }
    return boxArray;
}

-(BOOL)checkRow: (Cell*)cell withValue:(int)value{
    BOOL rowValid = false;
    for (int i = 0; i < 9; i++) {
        if (value == grid[i][cell.column]){
            return rowValid;
        }
    }
    //NSLog([NSString stringWithFormat:@"%d", value]);
    return true;
}

-(BOOL)checkColumn: (Cell*)cell withValue:(int)value{
    BOOL columnValid = false;
    for (int i = 0; i < 9; i++) {
        if (value == grid[cell.row][i])
            return columnValid;
    }
    return true;
}

-(BOOL)checkGrid: (Cell*)cell withValue:(int)value andBox:(NSMutableArray*)gridArray{
    BOOL gridValid = false;
    for (int i = 0; i < 9; i++) {
        if (value == [gridArray[i] integerValue])
            return gridValid;
    }
    return true;
}

-(void)endGame: (Cell*)cell{
    if (cell.row > 8) {
        //ready to print ui
        resultView.hidden = NO;
        noteLabel.hidden = NO;
        noteLabel.text = @"End of game! Congratz!";
        NSString *gridStrn = @"";
        NSString *goodStrn = @"";
        for (int r = 0; r < 9; r++) {
            for (int c = 0; c < 9; c++) {
                if (c == 8) {
                    goodStrn = [NSString stringWithFormat:@"%lu\n", (unsigned long)grid[r][c]];
                }
                else
                    goodStrn = [NSString stringWithFormat:@"%lu   ", (unsigned long)grid[r][c]];
                
                gridStrn = [gridStrn stringByAppendingString:goodStrn];
            }
        }
        gridLabel.text = gridStrn;
    }
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 2 && indexPath.row < 6) {
         TableViewCell *cell = [gridTableView dequeueReusableCellWithIdentifier:@"basicCell2"];
        return cell;
     }
    else{
        TableViewCell *cell = [gridTableView dequeueReusableCellWithIdentifier:@"basicCell"];
        return cell;
    }
     
 }

//dismiss keyboard
-(void)dismissKeyboard:(id)sender{
    [self.view endEditing:YES];
}


@end
