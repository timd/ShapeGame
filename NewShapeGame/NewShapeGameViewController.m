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
    toolbarRect = CGRectMake(20, 20, 280, 35);
    UIView *toolbarView = [[UIView alloc] initWithFrame:toolbarRect];
    UIImageView *toolbar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toolBar"]];
    [toolbarView addSubview:toolbar];
    [self.view addSubview:toolbarView];
    [toolbarView release];
    [toolbar release];

}

#pragma mark - 
#pragma mark Placement methods

-(void)generateRandomPlacementsForShapes:(int)numberOfShapes {
    
    // Reset the contents of the board array
    for (BoardCell *theBoardCell in boardArray) {
        
        theBoardCell.shape = 9;
        theBoardCell.colour = 9;
        
    }
    NSLog(@"===============");
    NSLog(@"===============");

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
        
        NSLog(@"======");
        NSLog(@"Random placement: %d", randomTag);
        NSLog(@"Shape: %d-%d", randomShape, randomColor);
        
        // Find the index of the BoardCell in placementArray with a matching tag
        NSUInteger index;
        index = [boardArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            BoardCell *thisBoardCell = (BoardCell *)obj;
            return (thisBoardCell.tag == randomTag);
        }];
        
        // Get that boardCell and updated with the random shape values
        BoardCell *theBoardCell = [boardArray objectAtIndex:index];
        theBoardCell.shape = randomShape;
        theBoardCell.colour = randomColor;

    }
    
    
}

- (void)placeShapesOnBoard {

    BoardCell *bc11 = [boardArray objectAtIndex:0];
    BoardCell *bc12 = [boardArray objectAtIndex:1];
    BoardCell *bc13 = [boardArray objectAtIndex:2];
    BoardCell *bc21 = [boardArray objectAtIndex:3];
    BoardCell *bc22 = [boardArray objectAtIndex:4];
    BoardCell *bc23 = [boardArray objectAtIndex:5];
    BoardCell *bc31 = [boardArray objectAtIndex:6];
    BoardCell *bc32 = [boardArray objectAtIndex:7];
    BoardCell *bc33 = [boardArray objectAtIndex:8];
    
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
    boardArray = [[self createBoardArray] retain];
    
    // Copy the board array into the answers array
    answersArray = [boardArray copy];
    
}

-(void)startRound {
    
    // Generate new placement array
    [self generateRandomPlacementsForShapes:2];
    
    // Now that the board is clean, place the new shapes
    [self placeShapesOnBoard];
   
}
    
#pragma mark -
#pragma mark Touch handling methods

-(void)handleTouchStartingInToolbarWithTouch:(CGPoint)touchLoc {
    
    touchStartedInToolbar = YES;
    
    // Detect which tool was touched
    int correctedX = (touchLoc.x - 20);
    int touchMod = correctedX / 35;
    
    switch (touchMod) {
        case (0):
            // Create cursor & add to view
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueCursor"]];
            cursorColour = 1;
            cursorShape = 0;
            break;
        case (1):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenCursor"]];
            cursorColour = 2;
            cursorShape = 0;
            break;
        case (2):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redCursor"]];
            cursorColour = 3;
            cursorShape = 0;
            break;
        case (3):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowCursor"]];
            cursorColour = 4;
            cursorShape = 0;
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
    index = [boardArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BoardCell *theBoardCell = (BoardCell *)obj;
        return (theBoardCell.tag == theTag);
    }];
    
    BoardCell *theBoardCell = [boardArray objectAtIndex:index];
    
    // Figure out what's in the cell
    NSLog(@"BoardCell.color = %d", theBoardCell.colour);
    NSLog(@"BoardCell.shape = %d", theBoardCell.shape);
    
    int boardColor = theBoardCell.colour;
    int boardShape = theBoardCell.shape;
    
    // CASE ONE - TOOL DRAG IS IN PROGRESS
    if (touchStartedInToolbar) {
  
        // If the cursorColour value isn't 0, reset the cell's colour
        if (cursorColour != 0) {
            
            // Create the new display shape name string
            NSString *newShapeName = [NSString stringWithFormat:@"%d%d", cursorColour, boardShape];
            
            // Create the new image
            UIImageView *newShape = [[UIImageView alloc] initWithFrame:theBoardCell.rect];
            
            // Get a reference to that cell
            UIView *cellToChange = [self.view viewWithTag:theBoardCell.tag];
            
            // Set the image
            
             
            
            
            
        }
        
        // If the cursorShape\s value isn't 0. reset the cell's shape
        
    }
    
    
    
    
    
    [cursorImage removeFromSuperview];
    
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
            
            // Get the tag of the cell where the touch ended
            int endTag = [self getCellWhereTouchEndedWithTouch:touchLoc];
            
            // Figure out what to do
            [self handleTouchEndingWithinBoardWithTouch:touchLoc andTag:endTag];            
            
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
    
    [super viewDidLoad];
    
    // Setup initial values
    points = 0;
    wins = 0;
    lives = 2;
    level = 1;
    turn = 1;
    
    // Set up board
    [self drawToolbar];
    
    [self setupBoard];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    [super dealloc];
}
@end
