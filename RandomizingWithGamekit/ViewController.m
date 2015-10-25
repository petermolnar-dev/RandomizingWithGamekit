//
//  ViewController.m
//  RandomizingWithGamekit
//
//  Created by Peter Molnar on 16/10/2015.
//  Copyright © 2015 Peter Molnar. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RandomClassFactory.h"

@interface ViewController ()

// Timer for the generation signal
@property (strong, nonatomic) NSTimer *schedTimer;

// Randomizer and its statistic collector
@property (weak, nonatomic) GKRandomDistribution *currDist;
@property (strong, nonatomic)NSMutableArray *statisticValues;

// Outlets
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *randomizerTypeSelector;
@property (strong, nonatomic) IBOutlet UILabel *currentDistributionNameLabel;
@property (strong, nonatomic) IBOutlet UIView *dashBoardView;
@property (weak, nonatomic) IBOutlet UILabel *generatedNumberLabel;
@end

@implementation ViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.startButton.layer.cornerRadius = self.startButton.bounds.size.width/2;
    [self.startButton setBackgroundColor:[UIColor greenColor]];
    [self.startButton setTintColor:[UIColor whiteColor]];
    self.startButton.clipsToBounds = true;

    self.stopButton.layer.cornerRadius = self.startButton.bounds.size.width/2;
    [self.stopButton setBackgroundColor:[UIColor redColor]];
    [self.stopButton setTintColor:[UIColor whiteColor]];
    self.stopButton.clipsToBounds = true;
    [self.stopButton setEnabled:false];
    
    
}

#pragma mark - Accessors

- (NSMutableArray *)statisticValues
{
    if (!_statisticValues) {
        _statisticValues = [self resetStatisticValues];
    }
    
    return _statisticValues;
}

- (NSInteger) rangeHighestValue {
    if (!_rangeHighestValue || _rangeHighestValue == 0) {
        _rangeHighestValue = 10;
    }
    
    return _rangeHighestValue;
}

- (GKRandomDistribution *)currDist
{
    GKRandomDistribution *randomDist = [RandomClassFactory randomDistribution:[self.randomizerTypeSelector selectedSegmentIndex] minValue:1 maxValue:10];
    _currDist = randomDist;
    
    return _currDist;
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


- (IBAction)startPressed:(UIButton *)sender
{
    [sender setEnabled:false];
    [self.stopButton setEnabled:true];
    
    [self resetStatisticDisplay];
    
    self.statisticValues = nil;
    self.statisticValues = [self resetStatisticValues];
    [self stratGeneratingRandomNumbers];
}


- (IBAction)stopPressed:(UIButton *)sender
{
    [sender setEnabled:false];
    [self.startButton setEnabled:true];
    
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
    
    // update the display
    self.generatedNumberLabel.text = [NSString stringWithFormat:@"%d",currentGeneratedValue];
    UILabel *classOf = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    classOf.text = NSStringFromClass([self.currDist class]);
    [self.dashBoardView addSubview:classOf];
    [self.view setNeedsDisplay];
}

- (void) resetStatisticDisplay
{
    for (UIView *curView in [self.dashBoardView subviews]) {
        [curView removeFromSuperview];
    }
}

- (NSMutableArray *)resetStatisticValues
{
    NSMutableArray *statisticValues = [[NSMutableArray alloc] init];
    
    for (int i=0; i <  self.rangeHighestValue; i++) {
        [statisticValues insertObject:[NSNumber numberWithInt:0] atIndex:i];
    }
    
    return statisticValues;
}


@end
