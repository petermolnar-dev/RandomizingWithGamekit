//
//  ViewController.m
//  RandomizingWithGamekit
//
//  Created by Peter Molnar on 16/10/2015.
//  Copyright © 2015 Peter Molnar. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@import GameKit;

@interface ViewController ()

// Timer for the generation signal
@property (strong, nonatomic) NSTimer *schedTimer;


@property (weak, nonatomic) GKRandomDistribution *currDist;

@property (strong, nonatomic)NSMutableArray *statisticValues;

// Outlets
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;

@property (strong, nonatomic) IBOutlet UISegmentedControl *randomizerTypeSelector;
@property (strong, nonatomic) IBOutlet UILabel *currentDistributionNameLabel;
@property (strong, nonatomic) IBOutlet UIView *dashBoardView;

@end

@implementation ViewController

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.startButton.layer setCornerRadius:self.startButton.bounds.size.width/2];
//    [self.startButton.layer setBackgroundColor:(__bridge CGColorRef _Nullable)([UIColor greenColor])];
//    [self.view setNeedsDisplay];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
    self.startButton.layer.cornerRadius = self.startButton.bounds.size.width/2;
    [self.startButton setBackgroundColor:[UIColor greenColor]];
    [self.startButton setTintColor:[UIColor whiteColor]];
    self.startButton.clipsToBounds = true;
}

#pragma mark - Accessors

- (NSMutableArray *)statisticValues
{
    if (!_statisticValues) {
        NSMutableArray *statisticValues = [[NSMutableArray alloc] init];
        
        // Init the array with all of the elements
        for (int i=0; i <  self.rangeHighestValue; i++) {
            [statisticValues insertObject:[NSNumber numberWithInt:0] atIndex:i];
             NSLog(@"%@", statisticValues);
        }
        _statisticValues = statisticValues;
         NSLog(@"%@", _statisticValues);
    }
    
    return _statisticValues;
}

- (NSInteger) rangeHighestValue {
    if (!_rangeHighestValue || _rangeHighestValue == 0) {
        _rangeHighestValue = 10;
    }
    
    return _rangeHighestValue;
}

- (void)createRandomDistribution:(NSString *)fromClassName
{
    GKRandomDistribution *randomDist;
    randomDist = [NSClassFromString(fromClassName) distributionWithLowestValue:1 highestValue:10];
    int currentGeneratedValue = [randomDist nextInt];
    //    Get the corresponding value from the valuelist
    NSNumber *currNum = self.statisticValues[currentGeneratedValue-1];
    currNum = @([currNum integerValue] + 1);
    self.statisticValues[currentGeneratedValue-1] = currNum;
    
    NSLog(@"Heyy, generated: %ld", (long)currentGeneratedValue);
    
    
}


#pragma mark - Start and stop behaviour

- (void)stratGeneratingRandomNumbers
{
    
    [self.schedTimer invalidate];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                      target:self
                                                    selector:@selector(generator)
                                                    userInfo:nil
                                                     repeats:YES];
    self.schedTimer = timer;
   
}


- (IBAction)startButtonPressed:(id)sender {
    NSString *className = [[NSString alloc] init];
    className = [self.randomizerTypeSelector titleForSegmentAtIndex:self.randomizerTypeSelector.selectedSegmentIndex];
    [self createRandomDistribution:className];
    
//   [self.currentDistributionNameLabel setText:className];
//    if (!self.currDist)
//    {
//    [self stratGeneratingRandomNumbers];
//    } else {
//        NSLog(@"No usable randomizer class");
//    }
}

- (IBAction)stopButtonPressed {
    
    [self.schedTimer invalidate];
    self.schedTimer = nil;
     NSLog(@"%@", self.statisticValues);
}

#pragma mark - Number generation and helpers

- (void)generator
{
    // Ask for the nextInt
    int currentGeneratedValue = [self.currDist nextInt];
//    Get the corresponding value from the valuelist
    NSNumber *currNum = self.statisticValues[currentGeneratedValue-1];
    currNum = @([currNum integerValue] + 1);
    self.statisticValues[currentGeneratedValue-1] = currNum;
    
    NSLog(@"Heyy, generated: %ld", (long)currentGeneratedValue);
    
//    self.values[(int)currentGeneratedValue] += 1;
    
    // update the display

}



@end
