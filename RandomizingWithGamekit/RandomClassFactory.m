//
//  RandomClassFactory.m
//  RandomizingWithGamekit
//
//  Created by Peter Molnar on 22/10/2015.
//  Copyright © 2015 Peter Molnar. All rights reserved.
//

#import "RandomClassFactory.h"

@implementation RandomClassFactory

+ (GKRandomDistribution *)randomDistribution:(NSUInteger)classType minValue:(NSInteger)minValue maxValue:(NSInteger)maxValue;
{
    switch (classType) {
        case 0:
            return [GKRandomDistribution distributionWithLowestValue:minValue
                                                        highestValue:maxValue];
            break;
        case 1:
            return [GKShuffledDistribution distributionWithLowestValue:minValue
                                                          highestValue:maxValue];
            break;
        case 2:
            return [GKGaussianDistribution distributionWithLowestValue:minValue
                                                          highestValue:maxValue];
            break;
            
        default:
            return nil;
            break;
    }
}

+ (GKRandomDistribution *)randomDistribution:(NSUInteger)classType
{
    return [RandomClassFactory randomDistribution:classType minValue:1 maxValue:10];
}

@end
