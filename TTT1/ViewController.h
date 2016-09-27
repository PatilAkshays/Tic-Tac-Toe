//
//  ViewController.h
//  TTT1
//
//  Created by Mac on 04/07/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int numberOfTurns,currentPlayer;
    BOOL isGameOver;
    
    NSArray *winingCombinationArray;
    NSMutableArray *stateArray;
    
}

- (IBAction)tapButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *playerLabel;

@end

