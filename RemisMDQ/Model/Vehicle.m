//
//  Vehicle.m
//  Remisse MDQ prototype
//
//  Created by Globant iOS MDQ on 12/29/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vehicle.h"

@interface Vehicle ()
@end

@implementation Vehicle : NSObject

-(id)init
//Initializes the instance with default values, which should be properly set afterwards

{
    self = [super init];
    if (self)
    {
        [self setModel:VehicleModelNotSpecified];
        [self setColor:VehicleColorNotSpecified];
        [self setAgency:nil];
        [self setLicensePlate:@""];
        [self setLastKnownLocation:nil];
    }
    return self;
}


-(NSMutableDictionary *)outputToDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[self objectId] forKey:@"objectId"];
    [dict setObject:[self created_at] forKey:@"created_at"];
    [dict setObject:[self updated_at] forKey:@"updated_at"];
    
    [dict setObject:[[self agency] objectId] forKey:@"agency"];
    [dict setObject:[self licensePlate] forKey: @"licensePlate"];
    [dict setObject:[self lastKnownLocation] forKey:@"lastKnownLocation"];
    [dict setObject:[NSNumber numberWithInt:[self model]] forKey:@"model"];
    [dict setObject:[NSNumber numberWithInt:[self color]] forKey:@"color"];
    return dict;
}

-(instancetype)initInApplication:(MobileApplication *) app fromDictionary:(NSDictionary *) aDictionary
{
    self = [super init];
    if (self)
    {
        [self setObjectId:[aDictionary objectForKey:@"objectId"]];
        [self setCreated_at:[aDictionary objectForKey:@"created_at"]];
        [self setUpdated_at:[aDictionary objectForKey:@"updated_at"]];
        
        //Set the agency, asking the main application for it
        [self setAgency:[app getAgency:[aDictionary objectForKey:@"agency"] ]];
        
        //License plate and location:
        [self setLicensePlate:[aDictionary objectForKey:@"licensePlate"] ];
        [self setLastKnownLocation:[[Location alloc] initFromDictionary:[aDictionary objectForKey:@"lastKnownLocation"]] ];
        
        //The int code for the vehicle's model:
        [self setModel:[[aDictionary objectForKey:@"model"] intValue ] ];
        //The int code for the vehicle's color:
        [self setModel:[[aDictionary objectForKey:@"color"] intValue ] ];
        
    }
    return self;
}


-(void)saveToLocalStorage
{
    
}

@end