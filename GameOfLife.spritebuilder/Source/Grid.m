//
//  Grid.m
//  GameOfLife
//
//  Created by Victoria Simpri on 12/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

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
    for (int i = 10; i < GRID_ROWS; i++) {
        //this is how you create two dimensional arrays, put arrays into arrays
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 10; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            //this is shorthand to access an array inside an array
            _gridArray[i][j] = creature;
            
            //make the creatures visible to test this method, remove once we know grid has been filled properly
            creature.isAlive = YES;
            
            x += _cellWidth;
        }
        y += _cellHeight;
    }
}
@end
