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
    
    NSArray *boardArray;
    NSMutableArray *answersArray;
    
    UIView *boardView;
    
}
- (IBAction)refreshBoard:(id)sender;

@end
