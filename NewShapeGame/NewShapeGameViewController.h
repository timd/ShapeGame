//
//  NewShapeGameViewController.h
//  NewShapeGame
//
//  Created by Tim Duckett on 09/10/2011.
//  Copyright 2011 Charismatic Megafauna Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoardCell;

@interface NewShapeGameViewController : UIViewController <UIAlertViewDelegate> {
    
    int points;     // score
    int lives;      // lives - 3 to lose
    int level;      // number of shapes per play
    int turn;       // number of plays on this level - after 3, level increases
    int shapes;     // number of shapes on the board
    
    NSArray *placementArray;            // copy of master board, with randomly placed shapes
    
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

    IBOutlet UIImageView *boardBackground;
    IBOutlet UIImageView *blankBoard;

    IBOutlet UIButton *guessButton;
    
    UIImageView *cursorImage;
    int cursorShape;
    int cursorColour;
    BOOL touchStartedInToolbar;
    BOOL touchStartedInBoard;
    
    // Board drag ivars
    BoardCell *cellContentsBeingDragged;
    int cellWhereDragStarted;
    int cellWhereDragEnded;
    
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *livesLabel;
    IBOutlet UILabel *roundLabel;
    
}

@property (nonatomic, retain) NSArray *boardArray;
@property (nonatomic, retain) NSArray *boardState;
@property (nonatomic, retain) NSMutableArray *answersArray;

- (IBAction)refreshBoard:(id)sender;
- (IBAction)guessButtonTapped:(id)sender;

-(int)getCellWhereTouchEndedWithTouch:(CGPoint)touchLoc;
-(BoardCell *)getTheBoardCellWithTag:(int)theTag;

- (void)placeShapesOnBoardWith:(NSArray *)theArray;

-(void)checkIfCorrectAnswer;
-(void)shouldGameContinue;
-(void)endGame;

@end
