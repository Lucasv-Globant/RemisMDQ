//
//  Request.h
//  Remisse MDQ prototype
//
//  Created by Globant iOS MDQ on 12/29/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vehicle.h"
#import "User.h"
#import "Location.h"
#import "Agency.h"
#import "MobileApplication.h"

@class Vehicle;
@class User;
@interface Request : NSObject

//RequestStatusCode enumerates the possible states of a request.
typedef enum {
              RequestStatusNil = 0,             // Status for a null request. It is the default status.
              RequestStatusCancelled = 1,       // Status for when a user cancels the request
              RequestStatusEnRouteToOrigin = 2, // The vehicle is on its' way to the user's location
              RequestStatusRejected = 3,        // The agency has rejected the request
              RequestStatusVehicleWaitingForUser = 4, // The vehicle arrived to the user's location and it's waiting for him/her
              RequestStatusUserWasAbsent = 5,   // The vehicle arrived to the user's location, but he wasn't present.
              RequestStatusEnRouteToDestination = 6, // The user got into the vehicle and is on its' way to destination
              RequestStatusCompleted = 7        // The vehicle arrived to destination.
             }  RequestStatusCode;




@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSDate *created_at;
@property (nonatomic, strong) NSDate *updated_at;

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Vehicle *vehicle;
@property (nonatomic, strong) Agency *agency;

@property RequestStatusCode statusCode;
@property (nonatomic, strong) Location *originLocation;
@property (nonatomic, strong) Location *destinationLocation;
@property (nonatomic, strong) NSNumber *ETAToSourceLocation; //expressed in minutes, when available
@property (nonatomic, strong) NSNumber *ETAFromSourceLocationToDestinationLocation; //expressed in minutes, when available

-(id)init;
-(NSDictionary *)outputToDictionary;

@end
