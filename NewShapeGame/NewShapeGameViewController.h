//
//  NewShapeGameViewController.h
//  NewShapeGame
//
//  Created by Tim Duckett on 09/10/2011.
//  Copyright 2011 Charismatic Megafauna Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewShapeGameViewController : UIViewController {
    
    int points;
    int wins;
    int lives;
    int level;
    int turn;
    
    NSArray *boardArray;                // "Master" board - holds empty cells
    NSArray *placementArray;            // copy of master board, with randomly placed shapes
    NSArray *previousBoardState;        //  holds the shape placements from the previous turn
    NSMutableArray *answersArray;       // holds the player's answers
    
    UIView *boardView;
    CGRect boardRect;
    CGRect toolbarRect;
    
    IBOutlet UIImageView *image11;
    IBOutlet UIImageView *image12;
    IBOutlet UIImageView *image13;
    IBOutlet UIImageView *image21;
    IBOutlet UIImageView *image22;
    IBOutlet UIImageView *image23;
    IBOutlet UIImageView *image31;
    IBOutlet UIImageView *image32;
    IBOutlet UIImageView *image33;
        
    UIImageView *cursorImage;
    int cursorShape;
    int cursorColour;
    BOOL touchStartedInToolbar;
    
    
}
- (IBAction)refreshBoard:(id)sender;

@end
