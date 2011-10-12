    //
//  NewShapeGameViewController.m
//  NewShapeGame
//
//  Created by Tim Duckett on 09/10/2011.
//  Copyright 2011 Charismatic Megafauna Ltd. All rights reserved.
//

#import "NewShapeGameViewController.h"

#import "BoardCell.h"

#define kBoardOriginX 45
#define kBoardOriginY 100

@implementation NewShapeGameViewController

@synthesize boardArray;
@synthesize boardState;
@synthesize answersArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init {
    
    self = [super init];
    
    if (self) {
        
        //self.view.userInteractionEnabled = YES;
        
    }
    
    return self;

}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark Board methods

-(NSArray *)createBoardArray {
    
    /****************************/
    // Create board array
    int xOffset = 0;
    int yOffset = 0;
    
    BoardCell *cell11 = [[BoardCell alloc] initWithRect:CGRectMake(0 + xOffset, 0 + yOffset, 70, 70) andTag:11];
    BoardCell *cell12 = [[BoardCell alloc] initWithRect:CGRectMake(80 + xOffset, 0 + yOffset, 70, 70) andTag:12];
    BoardCell *cell13 = [[BoardCell alloc] initWithRect:CGRectMake(160 + xOffset, 0 + yOffset, 70, 70) andTag:13];
    BoardCell *cell21 = [[BoardCell alloc] initWithRect:CGRectMake(0 + xOffset, 80 + yOffset, 70, 70) andTag:21];
    BoardCell *cell22 = [[BoardCell alloc] initWithRect:CGRectMake(80 + xOffset, 80 + yOffset, 70, 70) andTag:22];
    BoardCell *cell23 = [[BoardCell alloc] initWithRect:CGRectMake(160 + xOffset, 80 + yOffset, 70, 70) andTag:23];
    BoardCell *cell31 = [[BoardCell alloc] initWithRect:CGRectMake(0 + xOffset, 160 + yOffset, 70, 70) andTag:31];
    BoardCell *cell32 = [[BoardCell alloc] initWithRect:CGRectMake(80 + xOffset, 160 + yOffset, 70, 70) andTag:32];
    BoardCell *cell33 = [[BoardCell alloc] initWithRect:CGRectMake(160 + xOffset, 160 + yOffset, 70, 70) andTag:33];
    
    NSArray *returnArray = [NSArray arrayWithObjects:cell11, cell12, cell13, cell21, cell22, cell23, cell31, cell32, cell33, nil];
    
    [cell11 release];
    [cell12 release];    
    [cell13 release];
    [cell21 release];
    [cell22 release];
    [cell23 release];
    [cell31 release];
    [cell32 release];
    [cell33 release];
    
    return returnArray;
    
}

- (void)drawToolbar {

    // Add toolbar
    toolbarRect = CGRectMake(0, 31, 320, 38);
    UIView *toolbarView = [[UIView alloc] initWithFrame:toolbarRect];
    UIImageView *toolbar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toolbar"]];
    [toolbarView addSubview:toolbar];
    [self.view addSubview:toolbarView];
    [toolbarView release];
    [toolbar release];

}

-(void)resetBoard {
    
    // Reset the contents of the board array
    for (BoardCell *theBoardCell in self.boardArray) {
        
        theBoardCell.shape = 0;
        theBoardCell.colour = 0;
        
    }
    
    // Reset the contents of the answers array
    for (BoardCell *theBoardCell in self.answersArray) {
        
        theBoardCell.shape = 0;
        theBoardCell.colour = 0;
        
    }
    
    [self placeShapesOnBoardWith:self.boardArray]; 
    
}

-(void)clearBoard {
 
    // Create image string
    NSString *blankImage = [NSString stringWithFormat:@"00"];
    
    // Update UIViews
    image11.image = [UIImage imageNamed:blankImage];
    image12.image = [UIImage imageNamed:blankImage];
    image13.image = [UIImage imageNamed:blankImage];
    image21.image = [UIImage imageNamed:blankImage];
    image22.image = [UIImage imageNamed:blankImage];
    image23.image = [UIImage imageNamed:blankImage];
    image31.image = [UIImage imageNamed:blankImage];
    image32.image = [UIImage imageNamed:blankImage];
    image33.image = [UIImage imageNamed:blankImage];
    
}

#pragma mark - 
#pragma mark Placement methods

-(void)generateRandomPlacementsForShapes:(int)numberOfShapes {
    
    // Reset the contents of the board array
    for (BoardCell *theBoardCell in self.boardArray) {
        
        theBoardCell.shape = 0;
        theBoardCell.colour = 0;
        
    }

    // Create an array of cell indexes
    NSMutableArray *cellIndexes = [[NSMutableArray alloc] initWithObjects:@"11",@"12",@"13",@"21",@"22",@"23",@"31",@"32",@"33", nil];
    
    for (int i = 0; i < numberOfShapes; i++) {
        
        // generate a random placement tag
        int randomIndex = arc4random() % ([cellIndexes count] -1);
        
        // Get the randomly chosen cell index
        int randomTag = [[cellIndexes objectAtIndex:randomIndex] intValue];
        
        // Remove that object from the cellIndexes array
        [cellIndexes removeObjectAtIndex:randomIndex];
        
        // Generate a random shape
        int randomShape = (arc4random() % 3) + 1;
        int randomColor = (arc4random() % 3) + 1;
        
        // Find the index of the BoardCell in placementArray with a matching tag
        NSUInteger index;
        index = [self.boardArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            BoardCell *thisBoardCell = (BoardCell *)obj;
            return (thisBoardCell.tag == randomTag);
        }];
        
        // Get that boardCell and updated with the random shape values
        BoardCell *theBoardCell = [self.boardArray objectAtIndex:index];
        theBoardCell.shape = randomShape;
        theBoardCell.colour = randomColor;

        // Update the boardState array with the same content
        
        // Find the index of the BoardCell in placementArray with a matching tag
        index = [self.boardState indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            BoardCell *thisBoardCell = (BoardCell *)obj;
            return (thisBoardCell.tag == randomTag);
        }];
        
        // Get that boardCell and updated with the random shape values
        theBoardCell = [self.boardState objectAtIndex:index];
        theBoardCell.shape = randomShape;
        theBoardCell.colour = randomColor;
        
    }
    
    
}

- (void)placeShapesOnBoardWith:(NSArray *)theArray {

    BoardCell *bc11 = [theArray objectAtIndex:0];
    BoardCell *bc12 = [theArray objectAtIndex:1];
    BoardCell *bc13 = [theArray objectAtIndex:2];
    BoardCell *bc21 = [theArray objectAtIndex:3];
    BoardCell *bc22 = [theArray objectAtIndex:4];
    BoardCell *bc23 = [theArray objectAtIndex:5];
    BoardCell *bc31 = [theArray objectAtIndex:6];
    BoardCell *bc32 = [theArray objectAtIndex:7];
    BoardCell *bc33 = [theArray objectAtIndex:8];
    
    // Create image string
    NSString *imageName11 = [NSString stringWithFormat:@"%d%d", bc11.colour, bc11.shape];
    NSString *imageName12 = [NSString stringWithFormat:@"%d%d", bc12.colour, bc12.shape];
    NSString *imageName13 = [NSString stringWithFormat:@"%d%d", bc13.colour, bc13.shape];
    NSString *imageName21 = [NSString stringWithFormat:@"%d%d", bc21.colour, bc21.shape];
    NSString *imageName22 = [NSString stringWithFormat:@"%d%d", bc22.colour, bc22.shape];
    NSString *imageName23 = [NSString stringWithFormat:@"%d%d", bc23.colour, bc23.shape];
    NSString *imageName31 = [NSString stringWithFormat:@"%d%d", bc31.colour, bc31.shape];
    NSString *imageName32 = [NSString stringWithFormat:@"%d%d", bc32.colour, bc32.shape];
    NSString *imageName33 = [NSString stringWithFormat:@"%d%d", bc33.colour, bc33.shape];
    
    // Update UIViews
    image11.image = [UIImage imageNamed:imageName11];
    image12.image = [UIImage imageNamed:imageName12];
    image13.image = [UIImage imageNamed:imageName13];
    image21.image = [UIImage imageNamed:imageName21];
    image22.image = [UIImage imageNamed:imageName22];
    image23.image = [UIImage imageNamed:imageName23];
    image31.image = [UIImage imageNamed:imageName31];
    image32.image = [UIImage imageNamed:imageName32];
    image33.image = [UIImage imageNamed:imageName33];
    
}

#pragma mark -
#pragma mark Game methods

-(void)setupBoard {    
    
    // Create board array
    self.boardArray = [self createBoardArray];
    self.answersArray = [NSMutableArray arrayWithArray:[self createBoardArray]];
    
    // Set the boardRect
    boardRect = CGRectMake(45, 93, 230, 230);
    
    // Set initial scores, turns and lives
    lives = 3;
    points = 0;
    turn = 1;
    
    scoreLabel.text = [NSString stringWithFormat:@"%d", points];
    livesLabel.text = [NSString stringWithFormat:@"%d", lives];
    roundLabel.text = [NSString stringWithFormat:@"Round %d", turn];
    
}

-(void)startRound {
    
    [blankBoard setAlpha:0];
    [guessButton setHidden:YES];
    
    // Generate new placement array
    [self generateRandomPlacementsForShapes:shapes];
    
    // Now that the board is clean, place the new shapes
    [self placeShapesOnBoardWith:self.boardArray];
    
    // Wait for a short while
    
    // Display blank grid
    [UIView animateWithDuration:0.5 delay:2.0 options:UIViewAnimationCurveEaseInOut animations:^(void) {
        
        // hide the board
        [blankBoard setAlpha:1];
        
    } completion:^(BOOL finished) {
        
        // clear the board
        [self clearBoard];
        
        [blankBoard setAlpha:0];
        
        [guessButton setHidden:NO];
        
    }];
    
    // wait for answers
   
}

- (IBAction)guessButtonTapped:(id)sender {
    
    [self checkIfCorrectAnswer];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    [self viewDidLoad];
    
}

#pragma mark -
#pragma mark Game Logic methods

-(void)checkIfCorrectAnswer {
    
    NSLog(@"******************************\n\n");

    BOOL gameLost = NO;
    
    // Iterate across the two arrays and compare the answer states
    for (int i=0; i < 9; i++) {
        
        BoardCell *boardCell = [self.boardArray objectAtIndex:i];
        BoardCell *answerCell = [self.answersArray objectAtIndex:i];

        NSLog(@"B: color:%d shape:%d", boardCell.colour, boardCell.shape);
        NSLog(@"A: color:%d shape:%d", answerCell.colour, answerCell.shape);
        NSLog(@"======");
        
        if ((answerCell.colour != boardCell.colour) || (answerCell.shape != boardCell.shape)) {
            gameLost = YES;
        }
    }
        
    if (gameLost) {
        NSLog(@"GAME LOST");
        
        lives--;
        
    } else {
        NSLog(@"GAME WON");
        
        points++;
    }
        
    scoreLabel.text = [NSString stringWithFormat:@"%d", points];
    livesLabel.text = [NSString stringWithFormat:@"%d", lives];
    roundLabel.text = [NSString stringWithFormat:@"%d", turn];
    
    [self shouldGameContinue];
    
}

-(void)shouldGameContinue {
    
    if (lives == 0) {
        
        [self endGame];
        return;
        
    }

    // GAME CONTINUES
    if (turn == 3) {
        
        // Increase level until it reaches 9
        if (level !=9) {
            level ++;
            turn = 1;
            shapes++;
        }
    } else {
        turn++;
    }
    
    [self resetBoard];
    [self startRound];
    
}

-(void)endGame {
    
    NSLog(@"Game ended!");
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You lost!" message:@"You lost the Game" delegate:self cancelButtonTitle:@"New game" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
    
}
    
#pragma mark -
#pragma mark Touch handling methods

-(void)handleTouchStartingInToolbarWithTouch:(CGPoint)touchLoc {
    
    touchStartedInToolbar = YES;
    touchStartedInBoard = NO;
    
    // Detect which tool was touched
    int touchMod = (int)touchLoc.x / 40;
    
    switch (touchMod) {
        case (0):
            // Create cursor & add to view
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splodge-blue"]];
            cursorShape = 0;
            cursorColour = 1;
            break;
        case (1):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splodge-green"]];
            cursorShape = 0;
            cursorColour = 2;
            break;
        case (2):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splodge-red"]];
            cursorShape = 0;
            cursorColour = 3;
            break;
        case (3):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splodge-yellow"]];
            cursorShape = 0;
            cursorColour = 4;
            break;
        case (4):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"squareCursor"]];
            cursorColour = 0;
            cursorShape = 1;
            break;
        case (5):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triangleCursor"]];
            cursorColour = 0;
            cursorShape = 2;
            break;
        case (6):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circleCursor"]];
            cursorColour = 0;
            cursorShape = 3;
            break;
        case (7):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"crossCursor"]];
            cursorColour = 0;
            cursorShape = 4;
            break;
            
        default:
            break;
    }
    
    [cursorImage setCenter:touchLoc];
    [self.view addSubview:cursorImage];
    
}

-(void)handleTouchStartingInBoardWithTouch:(CGPoint)touchLoc {
    
    NSLog(@"touched started in board");
    touchStartedInBoard = YES;
    touchStartedInToolbar = NO;
    
    // Get the tag of the cell that's been touched
    cellWhereDragStarted = 99;
        
    cellWhereDragStarted = [self getCellWhereTouchEndedWithTouch:touchLoc];
    
    // Check if anything was returned (ie whether there's anything in the cell or not)
    
    if (cellWhereDragStarted!= 99) {
        
        // Get the board cell for that tag
        BoardCell *theTouchedCell = [self getTheBoardCellWithTag:cellWhereDragStarted];
        
        // Set the ivar so we can retrieve whatever's being dragged later
        cellContentsBeingDragged = [[BoardCell alloc] init];
        cellContentsBeingDragged.colour = theTouchedCell.colour;
        cellContentsBeingDragged.shape = theTouchedCell.shape;

        NSLog(@"theTouchedCell.shape = %d", theTouchedCell.shape);
        NSLog(@"theTouchedCell.color = %d", theTouchedCell.colour);
        NSLog(@"cellContentsBeingDragged.shape = %d", cellContentsBeingDragged.shape);
        NSLog(@"cellContentsBeingDragged.color = %d", cellContentsBeingDragged.colour);
        
        // Remove the contents of this cell from the answersArray
        // First, get the BoardCell from the correct location in the board
        NSUInteger index;
        index = [self.answersArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            BoardCell *theBoardCell = (BoardCell *)obj;
            return (theBoardCell.tag == cellWhereDragStarted);
        }];
        
        // Get the cell which was touched from the answers array
        BoardCell *theBoardCell = [self.answersArray objectAtIndex:index];
        
        // Then reset the contents of this
        theBoardCell.colour = 0;
        theBoardCell.shape = 0;
        
        // and update the board
        [self placeShapesOnBoardWith:self.answersArray];
        
        // Draw the contents of the cell being moved under the touch
        // Create the image string from the theTouchedCell properties
        NSString *cursorImageString = [NSString stringWithFormat:@"%d%d", cellContentsBeingDragged.colour, cellContentsBeingDragged.shape];
        NSLog(@"cursorImageString = %@", cursorImageString);
        cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:cursorImageString]];
        [cursorImage setCenter:touchLoc];
        [self.view addSubview:cursorImage];
        
    } else {
        
        // Nothing was returned, so there isn't anything in the 
        // touched cell
        
        return;
        
    }
    
}

-(BoardCell *)getTheBoardCellWithTag:(int)theTag {
    
    // First, get the BoardCell from the correct location in the board
    NSUInteger index;
    index = [self.answersArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BoardCell *theBoardCell = (BoardCell *)obj;
        return (theBoardCell.tag == theTag);
    }];
    
    // Check if there's anything been found
    
    if (index != NSNotFound) {
    
        BoardCell *theBoardCell = [self.answersArray objectAtIndex:index];
        
        // Figure out what's in the cell
        NSLog(@"Tag = %d", theTag);
        NSLog(@"BoardCell.color = %d", theBoardCell.colour);
        NSLog(@"BoardCell.shape = %d", theBoardCell.shape);
        
        return theBoardCell;
        
    } else {
        
        // There wasn't anything in the touched cell
        return nil;
        
    }
    
}


-(int)getCellWhereTouchEndedWithTouch:(CGPoint)touchLoc {
    
    //split out x and y locations, and correct for board offset
    int xLoc = ((int)touchLoc.x) - 45;
    int yLoc = ((int)touchLoc.y) - 100;
    
    int xTag;
    int yTag;
    
    // Calculate X component
    if (xLoc < 75) {
        xTag = 1;
    } else if (xLoc < 155) {
        xTag = 2;
    } else {
        xTag = 3;
    }
    
    // calculate Y component
    if (yLoc < 75) {
        yTag = 1;
    } else if (yLoc < 155) {
        yTag = 2;
    } else {
        yTag = 3;
    }
    
    // Create combined tag
    int combinedTag = (yTag * 10) + xTag;
    
    return combinedTag;
        
}

-(void)handleTouchEndingWithinBoardWithTouch:(CGPoint)touchLoc andTag:(int)theTag {
    
    // First, get the BoardCell from the correct location in the board
    NSUInteger index;
    index = [self.answersArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BoardCell *theBoardCell = (BoardCell *)obj;
        return (theBoardCell.tag == theTag);
    }];
    
    BoardCell *theBoardCell = [self.answersArray objectAtIndex:index];
    
    // Figure out what's in the cell
    NSLog(@"Tag = %d", theTag);
    NSLog(@"BoardCell.color = %d", theBoardCell.colour);
    NSLog(@"BoardCell.shape = %d", theBoardCell.shape);
    
    // CASE ONE - TOOL DRAG IS IN PROGRESS
    if (touchStartedInToolbar) {
        
        // Update the cell's current colour
        if (cursorColour == 0) {
            // Only change shape
            theBoardCell.shape = cursorShape;
        }
        
        if (cursorShape == 0) {
            // Only change color
            theBoardCell.colour = cursorColour;
        }
        
        touchStartedInToolbar = NO;
        cursorColour = 0;
        cursorShape = 0;
        
    } else if (touchStartedInBoard) {
        // CASE TWO - TOUCH STARTED IN BOARD
        
        // Reset the cell to whatever it should be
        theBoardCell.shape = cellContentsBeingDragged.shape;
        theBoardCell.colour = cellContentsBeingDragged.colour;
        
        // Clear the cellContentsBeingDragged because they're not needed anymore
        cellContentsBeingDragged = nil;
        
    } else {
        
        // Touch started elsewhere, just clear the cell
        theBoardCell.shape = 0;
        theBoardCell.colour = 0;
        
    }
    
    // Update the answers array
    BoardCell *theAnswersCell = [self.answersArray objectAtIndex:index];
    
    NSLog(@"theAnswerCell.color = %d", theAnswersCell.colour);
    NSLog(@"theAnswerCell.shape = %d", theAnswersCell.shape);
    
    [theAnswersCell setColour:theBoardCell.colour];
    [theAnswersCell setShape:theBoardCell.shape];

    NSLog(@"theBoardCell:");
    NSLog(@"color = %d", theBoardCell.colour);
    NSLog(@"shape = %d", theBoardCell.shape);
    NSLog(@"theAnswersCell:");
    NSLog(@"New color = %d", theAnswersCell.colour);
    NSLog(@"New shape = %d", theAnswersCell.shape);
    
    [self placeShapesOnBoardWith:self.answersArray];
    
    [cursorImage removeFromSuperview];
    
}

-(void)clearTheCellWithTag:(int)theTag {
    
    // First, get the BoardCell from the correct location in the board
    NSUInteger index;
    index = [self.answersArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BoardCell *theBoardCell = (BoardCell *)obj;
        return (theBoardCell.tag == theTag);
    }];
    
    BoardCell *theBoardCell = [self.answersArray objectAtIndex:index];

    // Touch started elsewhere, just clear the cell
    theBoardCell.shape = 0;
    theBoardCell.colour = 0;
    
    [self placeShapesOnBoardWith:self.answersArray];
    
}


#pragma mark -
#pragma mark Touch detection methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
 
    // Check if touch began within the toolbar or the board
    for (UITouch *touch in touches) {
        
        // Check if this is a double tap
        if ([touch tapCount] > 1) {
            // It's a double tap
        }
        
        // Check if the touch started within the bounds of the cup icon
        CGPoint touchLoc = [touch locationInView:self.view];
        
        if (CGRectContainsPoint(toolbarRect, touchLoc)) {
            
            [self handleTouchStartingInToolbarWithTouch:touchLoc];
            
        }

        if (CGRectContainsPoint(boardRect, touchLoc)) {
            
            [self handleTouchStartingInBoardWithTouch:touchLoc];
            
        }

    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        // Check if this is a double tap
        if ([touch tapCount] > 1) {
            // It's a double tap
        }
        
        CGPoint touchLoc = [touch locationInView:self.view];

        //NSLog(@"touches moved");
        if (cursorImage) {
            [cursorImage setCenter:touchLoc];
        }
        
    }
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    NSLog(@"touches ended");
    
    // Detect where touch ended
    for (UITouch *touch in touches) {
        //
        if ([touch tapCount] > 1) {
            // It's a double tap
        }
        
        CGPoint touchLoc = [touch locationInView:self.view];

        // ************************
        // TOUCH ENDED WITHIN BOARD
        // ************************

        if (CGRectContainsPoint(boardRect, touchLoc)) {
            
            // Check if the touch started in the toolbar; if yes
            // then drop the cursor image into the square

            // Figure out where the drag ended
            cellWhereDragEnded = [self getCellWhereTouchEndedWithTouch:touchLoc];

            if (touchStartedInToolbar) {
            
                // Figure out what to do
                [self handleTouchEndingWithinBoardWithTouch:touchLoc andTag:cellWhereDragEnded];

            } else if (touchStartedInBoard) {

                // Touch started in the board.  If there's a cursorImage currently,
                // we need to drop that into the current board cell
                
                // Check if the touch ended in the same cell as it started
                if (cellWhereDragStarted == cellWhereDragEnded) {
                    // started and ended in the same cell, therefore
                    // just clear the cell and the cursor image
                    [cursorImage removeFromSuperview];
                    cursorImage = nil;
                    
                } else {
                
                    // Now drop whatever's being dragged into this cell
                    [self handleTouchEndingWithinBoardWithTouch:touchLoc andTag:cellWhereDragEnded];
                    
                }
            }
                
        } else {

                // touch ended elsewhere
                if (cursorImage) {
                    [cursorImage removeFromSuperview];
                    cursorImage = nil;
                }
            
        }
    }
}
        

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}



#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup initial values
    points = 0;
    lives = 2;
    level = 1;
    turn = 1;
    shapes = 1;
    
    // Set up board
    [self drawToolbar];
    
    [self setupBoard];
    
    [self startRound];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)refreshBoard:(id)sender {
    
    [self startRound];
    
}


 - (void)dealloc {
     [boardBackground release];
     [blankBoard release];
     [guessButton release];
     [scoreLabel release];
     [livesLabel release];
     [roundLabel release];
     [super dealloc];
 }

 - (void)viewDidUnload {
     [boardBackground release];
     boardBackground = nil;
     [blankBoard release];
     blankBoard = nil;
     [guessButton release];
     guessButton = nil;
     [scoreLabel release];
     scoreLabel = nil;
     [livesLabel release];
     livesLabel = nil;
     [roundLabel release];
     roundLabel = nil;
     [super viewDidUnload];
 }

@end
