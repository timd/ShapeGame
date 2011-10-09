//
//  Shape.m
//  ShapeGame
//
//  Created by Tim Duckett on 06/10/2011.
//  Copyright 2011 Charismatic Megafauna Ltd. All rights reserved.
//

#import "BoardCell.h"

@implementation BoardCell

@synthesize rect;
@synthesize shape;
@synthesize colour;
@synthesize tag;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithRect:(CGRect)theRect andTag:(int)theTag {
    
    self = [super init];
    if (self) {
        self.rect = theRect;
        self.tag = theTag;
        self.shape = 0;
        self.colour = 0;
    }
    
    return self;
    
}

@end
