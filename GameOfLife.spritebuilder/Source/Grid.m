//
//  Grid.m
//  GameOfLife
//
//  Created by Victoria Simpri on 12/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "UITouch+CC.h"
#import "Grid.h"
#import "Creature.h"

//these are variables that cannot be changed
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

-(void)onEnter {
    [super onEnter];
    
    [self setupGrid];
    
    //accepts touches on the grid
    self.userInteractionEnabled = YES;
}

-(void)setupGrid {
    //divide the grid's size by the number of rows/columns to find the right size of each cell
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    // initialize the array as a blank NSMutable Array
    _gridArray = [NSMutableArray array];
    
    //initialize creatures
    for (int i = 0; i < GRID_ROWS; i++) {
        //this is how you create two dimensional arrays, put arrays into arrays
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            //this is shorthand to access an array inside an array
            _gridArray[i][j] = creature;
            
            //make the creatures visible to test this method, remove once we know grid has been filled properly
            //creature.isAlive = YES;
            
            x += _cellWidth;
        }
        y += _cellHeight;
    }
}
    
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    //get the x,y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
        
    //get the creature at that location
    Creature *creature = [self creatureForTouchPosition:touchLocation];
        
    //invert its state
    creature.isAlive = !creature.isAlive;
}

-(Creature *)creatureForTouchPosition:(CGPoint)touchPosition {
    //get the row and column that was touched
    int row = touchPosition.y / _cellHeight;
    int column = touchPosition.x / _cellWidth;
    return _gridArray[row][column];
}

-(void)evolveStep {
    //update each Creature's neighbor count
    [self countNeighbors];
    
    //update each Creature's state
    [self updateCreatures];
    
    //update the generation so the label displays correctly
    _generation++;
}

-(void)countNeighbors {
    //iterate through the nodes
    //NSArray has count method that returns how many elements in array
    for (int i = 0; i < [_gridArray count]; i++) {
        //iterate through all the columns for a given row
        for (int j = 0; j < [_gridArray[i] count]; j++) {
            //access the creature in the cell
            Creature *currentCreature = _gridArray[i][j];
            
            //every creature has a living neighbors property
            currentCreature.livingNeighbors = 0;
            
            //now examine every cell around this cell
            
            //check from the row on top of the cell to the row under the cell
            for (int x = (i-1); x <= (i+1); x++) {
                //check form the column to the left of this cell to the column on the right
                for (int y = (j-1); y <= (j+1); y++) {
                    //check that this cell isnt off the screen
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    //skip over all cells that are off screen and cells that contain current creature
                    if (!((x == i) && (y == j)) && isIndexValid) {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive) {
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                    
                }
            }
            
        }
    }
}

-(BOOL)isIndexValidForX:(int)x andY:(int)y {
    BOOL isIndexValid = YES;
    if (x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS) {
        isIndexValid = NO;
    }
    return isIndexValid;
}
-(void)updateCreatures {
    //go through all rows
    for (int i = 0; i < GRID_ROWS; i++) {
        //go through all columns
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = _gridArray[i][j];
            if (creature.livingNeighbors == 3) {
                creature.isAlive = TRUE;
            }
            else if (creature.livingNeighbors <= 1 || creature.livingNeighbors >= 4) {
                creature.isAlive = FALSE;
            }
        }
    }
}
@end
