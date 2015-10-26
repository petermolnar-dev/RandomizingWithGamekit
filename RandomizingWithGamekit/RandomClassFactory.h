//
//  RandomClassFactory.h
//  RandomizingWithGamekit
//
//  Created by Peter Molnar on 22/10/2015.
//  Copyright © 2015 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GameplayKit;

@interface RandomClassFactory : NSObject
+ (GKRandomDistribution *)randomDistribution:(NSUInteger)classType minValue:(NSInteger)minValue maxValue:(NSInteger)maxValue;
+ (GKRandomDistribution *)randomDistribution:(NSUInteger)classType;
@end
