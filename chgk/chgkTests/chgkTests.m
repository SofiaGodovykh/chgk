//
//  chgkTests.m
//  chgkTests
//
//  Created by Admin on 28/07/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DB.h"

@interface chgkTests : XCTestCase

@end

@implementation chgkTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

- (void)testBunchOfQuestions
{
    NSLog(@"In Exercise are %ld rows", [[DB standardBase] countOfItemsInExercise]);
    NSArray *bunch = [[DB standardBase] getBunchOfQuestions];
    if ([bunch count]==0) {
        XCTFail(@"No question selected from database");
    }
}


@end
