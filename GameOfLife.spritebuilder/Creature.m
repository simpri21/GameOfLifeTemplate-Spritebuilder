//
//  Creature.m
//  GameOfLife
//
//  Created by Victoria Simpri on 12/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature
-(instancetype)initCreature {
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
    }
    
    return self;
}

-(void)setIsAlive:(BOOL)newState {
    //when you create an @property an instance variable with underscore before is automatically created
    _isAlive = newState;
    
    //'visible' is a property of any class that inherits from CCNode
    self.visible = _isAlive;
}
@end
