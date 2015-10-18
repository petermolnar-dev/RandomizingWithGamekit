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
//@property (strong, nonatomic)NSArray *values;

@end

@implementation ViewController


- (void)setupGenerators
{
    self.randomDistribution = nil;
    
    GKRandomDistribution *randomDist = [GKRandomDistribution distributionWithLowestValue:1 highestValue:10];
    GKShuffledDistribution *shuffledDist = [GKShuffledDistribution distributionWithLowestValue:1 highestValue:10];
    GKGaussianDistribution *gaussianDist = [GKGaussianDistribution distributionWithLowestValue:1 highestValue:10];
    
    self.randomDistribution = randomDist;
    self.shuffledDistribution = shuffledDist;
    self.gaussianDistribution = gaussianDist;
}

- (void)generateNewNumber
{
    
}
- (void)stratGeneratingRandomNumbers
{
    
    [self.schedTimer invalidate];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5
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
    NSLog(@"Heyy, generated: %d", [self.shuffledDistribution nextInt]
          );
    // Ask for the nextInt
    
    // put it into the array
    // update the display

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
// set up an array of the UILables
//    Set up a random generator with the given type and seed
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
