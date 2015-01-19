//
//  RemisMDQ_v2Tests.m
//  RemisMDQ-v2Tests
//
//  Created by Lucas on 1/9/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Agency.h"
#import "Location.h"
#import "Request.h"
#import "User.h"
#import "Vehicle.h"

@interface RemisMDQ_v2Tests : XCTestCase

@end

@implementation RemisMDQ_v2Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testInitFromDictionary
{
    /*
     //ObjectId and timestamps
     [self setObjectId:[dict objectForKey:@"objectId"] ];
     [self setCreated_at:[dict objectForKey:@"created_at"] ];
     [self setUpdated_at:[dict objectForKey:@"updated_at"] ];
     
     //Asks the main application for the User instance, passing the objectId NSString as a parameter
     [self setUser:[app getUserWithObjectId:[dict objectForKey:@"user"]] ];
     
     //Asks the main application for the Agency instance, passing the objectId NSString as a parameter
     [self setAgency:[app getAgencyWithObjectId:[dict objectForKey:@"agency"]] ];
     
     //Asks the main application for the Vehicle instance, passing the objectId NSString as a parameter
     [self setVehicle:[app getVehicleWithObjectId:[dict objectForKey:@"vehicle"]] ];
     
     //Status code, locations, and ETAs:
     [self setStatusCode:[[dict objectForKey:@"statusCode"] intValue] ];
     [self setOriginLocation:[[Location alloc]initFromDictionary:[dict objectForKey:@"originLocation"]]];
     [self setDestinationLocation:[[Location alloc]initFromDictionary:[dict objectForKey:@"destinationLocation"]]];
     [self setETAToSourceLocation:[dict objectForKey:@"ETAToSourceLocation"] ];
     [self setETAFromSourceLocationToDestinationLocation:[dict objectForKey:@"ETAFromSourceLocationToDestinationLocation"] ];
     */
    
    
    /*
    NSDictionary *agencyDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"001",[NSDate date],[NSDate date],@"Fictitious Agency", @"objectId",@"created_at",@"updated_at", @"name", nil];
    
    Agency *agency = [[Agency alloc] initFromDictionary:agencyDictionary];
    
    MobileApplication *mainApp = [MobileApplication sharedInstance];
    NSNumber *ETAToSourceLocation = [NSNumber numberWithInt:10];
    NSNumber ETAFromSourceLocationToDestinationLocation
    NSDictionary *requestDictionary = [NSDictionary alloc] initWithObjectsAndKeys:@"002",
                                                                                    [NSDate date],
                                                                                    [NSDate date],
                                                                                    user,
                                                                                    agency,
                                                                                    vehicle,
                                                                                    originLocation,
                                                                                    destinationLocation,
                                                                                    [NSNumber alloc]
                                                                                    @"", nil];
    Request *testRequest = [[Request alloc] initInApplication:mainApp withDictionary:requestDictionary];
    
    */
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
