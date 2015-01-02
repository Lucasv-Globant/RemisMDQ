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


@end