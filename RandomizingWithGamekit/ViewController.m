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

// Distributions by type
@property (strong, nonatomic) GKRandomDistribution *randomDistribution;
@property (strong, nonatomic) GKShuffledDistribution *shuffledDistribution;
@property (strong, nonatomic) GKGaussianDistribution *gaussianDistribution;

@property (weak, nonatomic) GKRandomDistribution *currDist;

@property (strong, nonatomic)NSMutableArray *statisticValues;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;

@property (strong, nonatomic) IBOutlet UISegmentedControl *randomizerTypeSelector;
@property (strong, nonatomic) IBOutlet UILabel *currentDistributionNameLabel;

@end

@implementation ViewController

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.startButton.layer setCornerRadius:self.startButton.bounds.size.width/2];
//    [self.startButton.layer setBackgroundColor:(__bridge CGColorRef _Nullable)([UIColor greenColor])];
//    [self.view setNeedsDisplay];
    
}

#pragma mark - Accessors

- (NSMutableArray *)statisticValues
{
    if (!_statisticValues) {
        // Init the array with all of the elements
        for (int i=0; i <  self.rangeHighestValue; i++) {
            [_statisticValues insertObject:@0 atIndex:i];
        }
    }
    
    return _statisticValues;
}

- (NSInteger) rangeHighestValue {
    if (!_rangeHighestValue || _rangeHighestValue == 0) {
        _rangeHighestValue = 10;
    }
    
    return _rangeHighestValue;
}

- (GKRandomDistribution *)randomDistribution
{
    if (!_randomDistribution) {
        GKRandomDistribution *randomDist = [GKRandomDistribution distributionWithLowestValue:1
                                                                                highestValue:self.rangeHighestValue];
        _randomDistribution = randomDist;
    }
    
    return _randomDistribution;
}

- (GKShuffledDistribution *)shuffledDistribution
{
    if (!_shuffledDistribution) {
        GKShuffledDistribution *shuffledDist = [GKShuffledDistribution distributionWithLowestValue:1
                                                                                      highestValue:self.rangeHighestValue];
        _shuffledDistribution = shuffledDist;
    }
    
    return _shuffledDistribution;
}

- (GKGaussianDistribution *)gaussianDistribution
{
    if (!_gaussianDistribution) {
        GKGaussianDistribution *gaussianDist = [GKGaussianDistribution distributionWithLowestValue:1
                                                                                      highestValue:self.rangeHighestValue];
        _gaussianDistribution = gaussianDist;
    }
    return _gaussianDistribution;
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
    switch (self.randomizerTypeSelector.selectedSegmentIndex) {
        case 0:
            [self setCurrDist:self.randomDistribution];
            break;
        case 1:
            [self setCurrDist:self.shuffledDistribution];
            break;
        case 2:
            [self setCurrDist:self.gaussianDistribution];
            break;
    }
    
   [self.currentDistributionNameLabel setText:NSStringFromClass([self.currDist class])];
    [self stratGeneratingRandomNumbers];
}

- (IBAction)stopButtonPressed {
    
    [self.schedTimer invalidate];
    self.schedTimer = nil;
    
}

#pragma mark - Number generation and helpers

- (void)generator
{
    // Ask for the nextInt
    NSInteger *currentGeneratedValue = [self.currDist nextInt];
    NSLog(@"Heyy, generated: %ld", (long)currentGeneratedValue);
    
//    self.values[(int)currentGeneratedValue] += 1;
    
    // update the display

}



@end
