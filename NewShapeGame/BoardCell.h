//
//  Shape.h
//  ShapeGame
//
//  Created by Tim Duckett on 06/10/2011.
//  Copyright 2011 Charismatic Megafauna Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoardCell : NSObject {
    
}

@property (nonatomic) CGRect rect;
@property (nonatomic) int shape;
@property (nonatomic) int colour;
@property (nonatomic) int tag;

-(id)initWithRect:(CGRect)theRect andTag:(int)theTag;

@end
