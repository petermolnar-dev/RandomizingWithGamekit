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
@property (weak, nonatomic) GKRandomDistribution *currentRandomDistribution;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self buttonSetup:self.startButton borderColor:[UIColor greenColor]];
    [self buttonSetup:self.stopButton borderColor:[UIColor redColor]];

}


- (void)buttonSetup:(UIButton *)button borderColor:(UIColor *)borderColor
{
    button.layer.cornerRadius = button.bounds.size.width/2;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor =[borderColor CGColor];
    button.clipsToBounds = true;
}


#pragma mark - Accessors

- (NSMutableArray *)statisticValues
{
    if (!_statisticValues) {
        _statisticValues = [self emptyStatisticValues];
    }
    
    return _statisticValues;
}

- (NSInteger)rangeHighestValue {
    if (!_rangeHighestValue || _rangeHighestValue == 0) {
        _rangeHighestValue = 10;
    }
    
    return _rangeHighestValue;
}

- (GKRandomDistribution *)currentRandomDistribution
{
    GKRandomDistribution *randomDist = [RandomClassFactory randomDistribution:[self.randomizerTypeSelector selectedSegmentIndex] minValue:1 maxValue:10];

    _currentRandomDistribution = randomDist;
    
    return _currentRandomDistribution;
}


#pragma mark - Start and stop behaviour

- (IBAction)startPressed:(UIButton *)sender
{
    [sender setEnabled:false];
    [self.stopButton setEnabled:true];
    
    [self resetStatisticDisplay];
    
    self.statisticValues = nil;
    self.statisticValues = [self emptyStatisticValues];
    [self stratGeneratingRandomNumbers];
}


- (IBAction)stopPressed:(UIButton *)sender
{
    [sender setEnabled:false];
    [self.startButton setEnabled:true];
    
    [self.schedTimer invalidate];
    self.schedTimer = nil;
}


#pragma mark - Number generation and helpers

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


- (void)generator
{
    int currentGeneratedValue = [self.currentRandomDistribution nextInt];

    NSNumber *currentNumber = self.statisticValues[currentGeneratedValue-1];
    self.statisticValues[currentGeneratedValue-1] =  @([currentNumber integerValue] + 1);
    
    self.generatedNumberLabel.text = [NSString stringWithFormat:@"%d",currentGeneratedValue];
    
    [self resetStatisticDisplay];
    [self updateStatisticDisplay];
    [self.view setNeedsDisplay];
}


#pragma mark - Statistic View manipulation

- (void)updateStatisticDisplay
{
    UILabel *classOf = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    classOf.text = NSStringFromClass([self.currentRandomDistribution class]);
    
    [self.dashBoardView addSubview:classOf];
    int i = 0;
    
    for (NSNumber *currentNumber in self.statisticValues) {
        i++;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i*20, 200, 20)];
        label.text =  [NSString stringWithFormat:@"%d: %d",i,[currentNumber intValue]];
        
        [self.dashBoardView addSubview:label];
    }

}

- (void)resetStatisticDisplay
{
    for (UIView *curView in [self.dashBoardView subviews]) {
        [curView removeFromSuperview];
    }
}

- (NSMutableArray *)emptyStatisticValues
{
    NSMutableArray *statisticValues = [[NSMutableArray alloc] init];
    
    for (int i=0; i <  self.rangeHighestValue; i++) {
        [statisticValues insertObject:[NSNumber numberWithInt:0] atIndex:i];
    }
    
    return statisticValues;
}


@end
