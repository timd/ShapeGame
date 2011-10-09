//
//  NewShapeGameViewController.m
//  NewShapeGame
//
//  Created by Tim Duckett on 09/10/2011.
//  Copyright 2011 Charismatic Megafauna Ltd. All rights reserved.
//

#import "NewShapeGameViewController.h"

#import "BoardCell.h"

@implementation NewShapeGameViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark Game methods

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
      UIView *theBoardView = [[UIView alloc] initWithFrame:CGRectMake(45, 100, 280, 230)];
    
    for (BoardCell *theCell in boardArray) {
        
        UIView *theCellView = [[UIView alloc] initWithFrame:theCell.rect];
        [theCellView setBackgroundColor:[UIColor lightGrayColor]];
        [theBoardView addSubview:theCellView]; 
        [theCellView release];
        
    }
    
    boardView = theBoardView;
    
    [self.view addSubview:boardView];
    
    [theBoardView release];

}

-(NSArray *)generateRandomPlacementsForShapes:(int)numberOfShapes {
    
    NSMutableArray *placements = [[NSMutableArray alloc] init];
    
    NSMutableArray *shapesToPlace = [[NSMutableArray alloc] init];
    
    NSMutableArray *locations = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:11],
                          [NSNumber numberWithInt:12],
                          [NSNumber numberWithInt:13],
                          [NSNumber numberWithInt:21],
                          [NSNumber numberWithInt:22],
                          [NSNumber numberWithInt:23],
                          [NSNumber numberWithInt:31],
                          [NSNumber numberWithInt:32],
                          [NSNumber numberWithInt:33],nil];
    
    
    for (int i=0; i < numberOfShapes; i++) {
        
        // Generate a random index
        int randomIndex = arc4random() % ([locations count] - 1);
        
        // Grab the location member at that index
        NSNumber *chosen = [locations objectAtIndex:randomIndex];
        
        // Add it to the chosen array
        [placements addObject:chosen];
        
        // Remove it from the locations array
        [locations removeObjectAtIndex:randomIndex];
        
    }

    // For each element in the placements array, create 
    // a boardCell object with a random shape/color combination
    // and insert it into the shapesToPlace array
    for (int i=0; i< [placements count]; i++) {
    
        // Having created the locations, generate a random shape & colour for each
        int randomShape = (arc4random() % 3) + 1;
        int randomColor = (arc4random() % 3) + 1;
        
        // Create a new boardCell object
        BoardCell *cell = [[BoardCell alloc] init];
        cell.shape = randomShape;
        cell.colour = randomColor;
        cell.tag = [[placements objectAtIndex:i] intValue];
        [shapesToPlace addObject:cell];
        [cell release];
    }
    
    // Clean up
    NSArray *returnArray = [NSArray arrayWithArray:shapesToPlace];
    [placements release];
    [shapesToPlace release];
    
    return returnArray;
}

- (void)placeOnBoardFromArrayOfShapes:(NSArray *)shapePlacements  {
    // Put shapes on the board
    
      for (BoardCell *shapeCell in shapePlacements) {
        
        // Get the cell with the corresponding tag from the boardArray
        NSUInteger index;
        
        NSLog(@"tag = %d", shapeCell.tag);
        
        // Find the index and retrieve the cell
        index = [boardArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            BoardCell *boardCell = (BoardCell *)obj;
            return (boardCell.tag == shapeCell.tag);
        }];
        
        BoardCell *placementCell = [boardArray objectAtIndex:index];
        
        // Get the location
        CGRect placementRect = placementCell.rect;
        
        // Create a view to place
        UIView *placementView = [[UIView alloc] initWithFrame:placementRect];
        
        NSString *shapeName = [NSString stringWithFormat:@"%d%d", shapeCell.shape, shapeCell.colour];
        
        UIImageView *placementImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:shapeName]];
        
        [placementView addSubview:placementImage];
        
        [boardView addSubview:placementView];
        
        [placementView release];
        [placementImage release];
                 
    }

}
-(void)startRound {    
    
    // Create board array
    boardArray = [[self createBoardArray] retain];
    
    // Copy the board array into the answers array
    answersArray = [[NSMutableArray arrayWithArray:boardArray] retain];
    
    // Draw the board
    [self createBoard];
    
    // Create random placements of shapes and put them on the board
    NSArray *shapePlacements = [self generateRandomPlacementsForShapes:2];
    [self placeOnBoardFromArrayOfShapes: shapePlacements];

    
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
