//
//  Grid.h
//  GameOfLife
//
//  Created by Victoria Simpri on 12/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite

@property (nonatomic, assign) int totalAlive;

@property (nonatomic, assign) int generation;

@property (nonatomic, assign) BOOL isStatic;

@property (nonatomic, assign) int number;


-(void)evolveStep;
-(void)countNeighbors;
-(void)updateCreatures;

@end
