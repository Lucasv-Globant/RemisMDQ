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



-(void)saveToLocalStorage
{
    
}

@end