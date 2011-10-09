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
    NSArray *placementArray;     // copy of master board, with randomly placed shapes
    NSMutableArray *answersArray;       // holds the player's answers
    
    UIView *boardView;
    CGRect boardRect;
    CGRect toolbarRect;
    
    UIImageView *cursorImage;
    int cursorTool;
    BOOL touchStartedInToolbar;
    
    
}
- (IBAction)refreshBoard:(id)sender;

@end
