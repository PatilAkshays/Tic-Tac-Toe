//
//  ViewController.m
//  TTT1
//
//  Created by Mac on 04/07/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initGame];
    
}

-(void)initGame{
    
    numberOfTurns = 0;
    currentPlayer = 1;
    
    isGameOver = false;
    
    winingCombinationArray = @ [@ [@0,@1,@2],
                                @ [@3,@4,@5],
                                @ [@6,@7,@8],
                                @ [@0,@3,@6],
                                @ [@1,@4,@7],
                                @ [@2,@5,@8],
                                @ [@0,@4,@8],
                                @ [@2,@4,@6]];
    stateArray = [[NSMutableArray alloc]initWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0, nil];
    
    for (int i=100; i<=108; i++) {
        UIButton * button = [self.view viewWithTag:i];
        
        [button setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapButton:(id)sender {
    
    numberOfTurns = numberOfTurns + 1;
    
    UIButton *tile = sender;
    UIImage *playerImage;
    int player = currentPlayer;
    
    
    BOOL isButtonSelected = [[stateArray objectAtIndex:(tile.tag-100)]isEqual:@0];
    
    
    if (isButtonSelected) {
        
        if(!isGameOver){
        
            if (player==1) {
                 playerImage = [UIImage imageNamed:@"nought"];
                
                NSString *newString = [NSString stringWithFormat:@"Next is Player2 "];
                
                _playerLabel.text = newString;
                
                [stateArray replaceObjectAtIndex:(tile.tag-100) withObject:@1];
                
                  currentPlayer = 2;
               }
             else{
                 playerImage = [UIImage imageNamed:@"cross"];
                 
                 NSString *newString = [NSString stringWithFormat:@"Next is Player1"];
                 
                 _playerLabel.text = newString;
            
                 [stateArray replaceObjectAtIndex:(tile.tag-100) withObject:@2];
                 
                  currentPlayer =1;
            
              }
           }
        [tile setBackgroundImage:playerImage forState:UIControlStateNormal];
        }
    
    else {
        [self alertWithTitle:@"Caution" message:@"please select another tile"];
          }
    
    
    if (numberOfTurns >=5) {
        for(NSArray *combination in winingCombinationArray){
            
            int indexOfButtonOne = [[combination objectAtIndex:0]intValue];
            int indexOfButtonTwo = [[combination objectAtIndex:1]intValue];
            int indexOfButtonThree = [[combination objectAtIndex:2]intValue];
            
            NSNumber *StateAtButtonOne =[stateArray objectAtIndex:indexOfButtonOne];
            
            NSNumber *stateAtButtonTwo  = [stateArray objectAtIndex:indexOfButtonTwo];
            
            NSNumber *stateAtButtonThree = [stateArray objectAtIndex:indexOfButtonThree];
            
            if(![StateAtButtonOne isEqual:@0 ] && [StateAtButtonOne isEqual:stateAtButtonTwo] && [stateAtButtonTwo isEqual:stateAtButtonThree]){

                isGameOver = YES;
                NSString *winnerString = [NSString stringWithFormat:@"Player %d has won!",player];
                
                [self alertForEndWithTitle:winnerString message:@"Do You Want to Play Again"];
                
                break;
            }
            
            
        }
    }
    
    if (!isGameOver) {
        BOOL zeroValuePresent =[stateArray containsObject:@0];
        
        if (!zeroValuePresent) {
            [self alertForEndWithTitle:@"Game Is Drow" message:@"Do You Want to Play Again"];
        }
    }
    
}



-(void)alertWithTitle: (NSString *)title message:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OK =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [alert addAction:OK];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)alertForEndWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self initGame];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        exit(0);
    }];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
