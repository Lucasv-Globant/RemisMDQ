//
//  Request.h
//  Remisse MDQ prototype
//
//  Created by Globant iOS MDQ on 12/29/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "Vehicle.h"
#import "User.h"
#import "Location.h"
#import "Agency.h"

//RequestStatusCode enumerates the possible states of a request.
typedef enum {
              RequestStatusCancelled,
              RequestStatusInProgress,
              RequestStatusNotConfirmed,
              RequestStatusRejected,
              RequestStatusUserWasAbsent,
              RequestStatusCompleted
             } RequestStatusCode;


@interface Request : NSObject

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Vehicle *vehicle;
@property (nonatomic, strong) Agency *agency;
@property (nonatomic, strong) NSDate *creationTime;
@property RequestStatusCode statusCode;
@property (nonatomic, strong) Location *originLocation;
@property (nonatomic, strong) Location *destinationLocation;
@property (nonatomic, strong) NSNumber *ETAToSourceLocation; //expressed in minutes, when available
@property (nonatomic, strong) NSNumber *ETAFromSourceLocationToDestinationLocation; //expressed in minutes, when available


@end
