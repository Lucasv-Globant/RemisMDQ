//
//  Pedido.m
//  Remisse MDQ prototype
//
//  Created by Globant iOS MDQ on 12/29/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

#import "Request.h"

/*
 Request class : 
 Represents a request made by a user to dispatch.
 A request can be in one of many states (cancelled, in progresss, etc).
*/

@interface Request ()
@end

@implementation Request : NSObject

-(id)init
//Initializes the instance with default values, which should be properly set afterwards
{
    self = [super init];
    if (self)
    {
        [self setUser:[[User alloc] init]];
        [self setVehicle:[[Vehicle alloc] init]];
        [self setAgency:[[Agency alloc] init]];
        [self setCreationTime: [NSDate date]];
        [self setStatusCode:RequestStatusNil];
        [self setOriginLocation:[[Location alloc] init]];
        [self setDestinationLocation:[[Location alloc] init]];
        [self setETAToSourceLocation:[NSNumber numberWithInt:0]];
        [self setETAFromSourceLocationToDestinationLocation:[NSNumber numberWithInt:0]];
    }
    return self;
}

@end