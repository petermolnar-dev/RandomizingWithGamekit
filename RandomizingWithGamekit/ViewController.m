//
//  ViewController.m
//  RandomizingWithGamekit
//
//  Created by Peter Molnar on 16/10/2015.
//  Copyright © 2015 Peter Molnar. All rights reserved.
//

#import "ViewController.h"
@import GameKit;

@interface ViewController ()

@property (strong, nonatomic) NSTimer *schedTimer;
@property (strong, nonatomic) GKRandomDistribution *randomDistribution;
@property (strong, nonatomic) GKShuffledDistribution *shuffledDistribution;
@property (strong, nonatomic) GKGaussianDistribution *gaussianDistribution;
@property (weak, nonatomic) GKRandomDistribution *currDist;

//@property (weak, nonatomic)NSArray *lables; //Of UILabel
@property (strong, nonatomic)NSMutableArray *values;


@end

@implementation ViewController


- (void)setupGenerators
{
    self.randomDistribution = nil;
    
    GKRandomDistribution *randomDist = [GKRandomDistribution distributionWithLowestValue:1
                                                                            highestValue:self.rangeHighestValue];
    GKShuffledDistribution *shuffledDist = [GKShuffledDistribution distributionWithLowestValue:1
                                                                                  highestValue:self.rangeHighestValue];
    GKGaussianDistribution *gaussianDist = [GKGaussianDistribution distributionWithLowestValue:1
                                                                                  highestValue:self.rangeHighestValue];
    
    self.randomDistribution = randomDist;
    self.shuffledDistribution = shuffledDist;
    self.gaussianDistribution = gaussianDist;
    
}

- (NSMutableArray *)values
{
    if (!_values) {
        // Init the array with all of the elements
        for (int i=0; i <  self.rangeHighestValue; i++) {
            [_values insertObject:@0 atIndex:i];
        }
    }
    
    return _values;
}

- (NSInteger) rangeHighestValue {
    if (!_rangeHighestValue || _rangeHighestValue == 0) {
        _rangeHighestValue = 10;
    }
    
    return _rangeHighestValue;
}

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
    [self setupGenerators];
    [self setCurrDist:self.shuffledDistribution];
    [self stratGeneratingRandomNumbers];
}

- (IBAction)stopButtonPressed {
    
    [self.schedTimer invalidate];
    self.schedTimer = nil;
    
}

- (void)generator
{
    // Ask for the nextInt
    NSInteger *currentGeneratedValue = [self.shuffledDistribution nextInt];
    NSLog(@"Heyy, generated: %ld", (long)currentGeneratedValue);
    
//    self.values[(int)currentGeneratedValue] += 1;
    
    // update the display

}



@end
