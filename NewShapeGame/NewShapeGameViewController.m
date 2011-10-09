//
//  NewShapeGameViewController.m
//  NewShapeGame
//
//  Created by Tim Duckett on 09/10/2011.
//  Copyright 2011 Charismatic Megafauna Ltd. All rights reserved.
//

#import "NewShapeGameViewController.h"

#import "BoardCell.h"

#define kBlueCursor 1
#define kGreenCursor 2
#define kRedCursor 3 
#define kYellowCursor 4
#define kSquareCursor 5
#define kTriangleCursor 6
#define kCircleCursor 7
#define kCrossCursor 8

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

- (void)createBoard {
    // Create the board
    boardRect = CGRectMake(kBoardOriginX, kBoardOriginY, 280, 230);
      UIView *theBoardView = [[UIView alloc] initWithFrame:boardRect];
    
    for (BoardCell *theCell in boardArray) {
        
        UIView *theCellView = [[UIView alloc] initWithFrame:theCell.rect];
        [theCellView setBackgroundColor:[UIColor lightGrayColor]];
        [theBoardView addSubview:theCellView]; 
        [theCellView release];
        
    }
    
    boardView = theBoardView;

    
    [self.view addSubview:boardView];
    [theBoardView release];
    
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

-(NSArray *)generateRandomPlacementsForShapes:(int)numberOfShapes {
    
    // Make a copy of the board array, call it placementArray
    NSArray *boardCopy = [boardArray copy];
    NSMutableArray *internalPlacements = [NSMutableArray arrayWithArray:boardCopy];
    [boardCopy release];
    
    for (int i = 0; i < numberOfShapes; i++) {
    
        // Generate a random shape
        int randomShape = (arc4random() % 3) + 1;
        int randomColor = (arc4random() % 3) + 1;

        // Generate a random placement tag
        int randomXLoc = (arc4random() % 3) + 1;
        int randomYLoc = (arc4random() % 3) + 1;
        int randomTag = (randomYLoc * 10) + randomXLoc;
        
        NSLog(@"Random placement: col:%d row:%d", randomXLoc, randomYLoc);
        NSLog(@"Shape: %d-%d", randomShape, randomColor);
        
        // Find the index of the BoardCell in placementArray with a matching tag
        NSUInteger index;
        index = [internalPlacements indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            BoardCell *thisBoardCell = (BoardCell *)obj;
            return (thisBoardCell.tag == randomTag);
        }];
        
        // Get that boardCell and updated with the random shape values
        BoardCell *theBoardCell = [internalPlacements objectAtIndex:index];
        theBoardCell.shape = randomShape;
        theBoardCell.colour = randomColor;

    }
    
    // return the placementArray
    NSArray *returnArray = [NSArray arrayWithArray:internalPlacements];
    return returnArray;
    
}

- (void)placeOnBoardFromArrayOfShapes:(NSArray *)shapePlacements  {
    // Put shapes on the board
    
    // Iterate across the shapePlacements array
    
    // for each cell -  extract the colour
    //                  extract the shape
    //                  extract the location
    
    //  if the color and shape are BOTH non-zero, then
    //  create the image and place it at the location
    
    for (BoardCell *theBoardCell in shapePlacements) {
        
        // Extract the colour, shape and location
        int cellColor = theBoardCell.colour;
        int cellShape = theBoardCell.shape;
        
        CGRect cellRect = theBoardCell.rect;
        float cellRectX = cellRect.origin.x;
        float cellRectY = cellRect.origin.y;
        float cellRectH = cellRect.size.height;
        float cellRectW = cellRect.size.width;
        
        // Create the cellShape int
        // shape is MSB, colour is LSB
        int cellCode = (cellShape * 10) + cellColor;
        
        // If this is zero, there's nothing placed
        if (cellCode != 0) {
            
            // Create the image name
            NSString *imageName = [NSString stringWithFormat:@"%d", cellCode];
            
            // Get the image
            UIImageView *cellImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            
            // Create a view, insert the image and place it in the view
            UIView *shapeView = [[UIView alloc] initWithFrame:CGRectMake(cellRectX + kBoardOriginX, cellRectY + kBoardOriginY, cellRectW, cellRectH)];
            [shapeView addSubview:cellImage];
            [cellImage release];
            
            // Place in main view
            [self.view addSubview:shapeView];
            [shapeView release];
            
        }
    }
}

#pragma mark -
#pragma mark Game methods

-(void)startRound {    
    
    // Create board array
    boardArray = [[self createBoardArray] retain];
    
    // Copy the board array into the answers array
    NSArray *boardCopy = [boardArray copy];
    answersArray = [[NSMutableArray arrayWithArray:boardCopy] retain];
    [boardCopy release];
    
    // Draw the board
    [self createBoard];
    
    // Create random placements of shapes and put them
    // into the placementArray
    placementArray = [self generateRandomPlacementsForShapes:2];
    [self placeOnBoardFromArrayOfShapes: placementArray];
    
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
            cursorTool = kBlueCursor;
            break;
        case (1):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenCursor"]];
            cursorTool = kGreenCursor;
            break;
        case (2):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redCursor"]];
            cursorTool = kRedCursor;
            break;
        case (3):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowCursor"]];
            cursorTool = kYellowCursor;
            break;
        case (4):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"squareCursor"]];
            cursorTool = kSquareCursor;
            break;
        case (5):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triangleCursor"]];
            cursorTool = kTriangleCursor;
            break;
        case (6):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circleCursor"]];
            cursorTool = kCircleCursor;
            break;
        case (7):
            cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"crossCursor"]];
            cursorTool = kCrossCursor;
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
    
    // Figure out how to react
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
    [self startRound];
    
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
@end
