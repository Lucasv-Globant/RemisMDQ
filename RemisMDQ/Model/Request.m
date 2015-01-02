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
        [self setObjectId:@""];
        [self setCreated_at: [NSDate date]];
        [self setUpdated_at: [NSDate date]];
        [self setStatusCode:RequestStatusNil];
        [self setOriginLocation:[[Location alloc] init]];
        [self setDestinationLocation:[[Location alloc] init]];
        [self setETAToSourceLocation:[NSNumber numberWithInt:0]];
        [self setETAFromSourceLocationToDestinationLocation:[NSNumber numberWithInt:0]];
    }
    return self;
}


-(NSMutableDictionary *)outputToDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[[self user] objectId] forKey:@"user"];
    [dict setObject:[[self vehicle] objectId] forKey:@"vehicle"];
    [dict setObject:[[self agency] objectId] forKey:@"agency"];
    [dict setObject:[self objectId] forKey:@"objectId"];
    [dict setObject:[self created_at] forKey:@"created_at"];
    [dict setObject:[self updated_at] forKey:@"updated_at"];
    
    [dict setObject:[NSNumber numberWithInt:[self statusCode]] forKey:@"statusCode"];
    [dict setObject:[[self originLocation] outputToDictionary] forKey:@"originLocation"];
    [dict setObject:[[self destinationLocation] outputToDictionary] forKey:@"destinationLocation"];
    [dict setObject:[self ETAToSourceLocation] forKey:@"ETAToSourceLocation"];
    [dict setObject:[self ETAFromSourceLocationToDestinationLocation] forKey:@"ETAFromSourceLocationToDestinationLocation"];
    
    return dict;
}

@end