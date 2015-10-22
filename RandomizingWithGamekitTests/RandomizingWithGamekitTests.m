//
//  RandomizingWithGamekitTests.m
//  RandomizingWithGamekitTests
//
//  Created by Peter Molnar on 22/10/2015.
//  Copyright © 2015 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RandomClassFactory.h"

@import GameKit;

@interface RandomizingWithGamekitTests : XCTestCase

@end

@implementation RandomizingWithGamekitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testRandomizerClassCreationFromString
{
    GKRandomDistribution *randDist = [RandomClassFactory randomDistribution:1];
    
    XCTAssertNotNil(randDist);
}

- (void) testRandomizerClassCreationFromString_GKRandomDistributionType
{
    GKRandomDistribution *randDist = [RandomClassFactory randomDistribution:1];
    
    XCTAssert([randDist isMemberOfClass:[GKRandomDistribution class]]);
}

- (void) testRandomizerClassCreationFromString_GKRandomDistributionType_notShuffledType
{
    GKRandomDistribution *randDist = [RandomClassFactory randomDistribution:1];
    
    XCTAssertFalse([randDist isMemberOfClass:[GKShuffledDistribution class]]);
}

- (void) testRandomizerClassCreationFromString_GKRandomDistributionType_notGaussianType
{
    GKRandomDistribution *randDist = [RandomClassFactory randomDistribution:1];
    
    XCTAssertFalse([randDist isMemberOfClass:[GKGaussianDistribution class]]);
}

- (void) testRandomizerClassCreationFromString_GKRandomShuffledType
{
    GKRandomDistribution *randDist = [RandomClassFactory randomDistribution:2];
    
    XCTAssert([randDist isMemberOfClass:[GKShuffledDistribution class]]);
}

- (void) testRandomizerClassCreationFromString_GKRandomShuffledType_notRandomType
{
    GKRandomDistribution *randDist = [RandomClassFactory randomDistribution:2];
    
    XCTAssertFalse([randDist isMemberOfClass:[GKRandomDistribution class]]);
}

- (void) testRandomizerClassCreationFromString_GKRandomShuffledType_notGaussianType
{
    GKRandomDistribution *randDist = [RandomClassFactory randomDistribution:2];
    
    XCTAssertFalse([randDist isMemberOfClass:[GKGaussianDistribution class]]);
}




@end
