//
//  Vehicle.m
//  Remisse MDQ prototype
//
//  Created by Globant iOS MDQ on 12/29/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vehicle.h"

@class Vehicle;
@interface Vehicle ()
@end

@implementation Vehicle : NSObject

#pragma mark - Initialization and persistence

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


-(NSDictionary *)outputToDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    //Object ID and time stamps:
    [dict setObject:[self objectId] forKey:@"objectId"];
    [dict setObject:[self created_at] forKey:@"created_at"];
    [dict setObject:[self updated_at] forKey:@"updated_at"];
    
    //Instance variables specific for this class:
    [dict setObject:[[self agency] objectId] forKey:@"agency"];
    [dict setObject:[self licensePlate] forKey: @"licensePlate"];
    [dict setObject:[self lastKnownLocation] forKey:@"lastKnownLocation"];
    [dict setObject:[NSNumber numberWithInt:[self model]] forKey:@"model"];
    [dict setObject:[NSNumber numberWithInt:[self color]] forKey:@"color"];
    
    NSDictionary *result = [[NSDictionary alloc] initWithDictionary:dict];
    return result;
}


-(id)initInApplication:(MobileApplication *) app withDictionary:(NSDictionary *) aDictionary
{
    self = [super init];
    if (self)
    {
        [self setObjectId:[aDictionary objectForKey:@"objectId"]];
        [self setCreated_at:[aDictionary objectForKey:@"created_at"]];
        [self setUpdated_at:[aDictionary objectForKey:@"updated_at"]];
        //Set the agency, asking the main application for it:
        [self setAgency:[app getAgencyWithObjectId:[aDictionary objectForKey:@"agency"] ]];
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

#pragma mark - Codes to string

+(NSString *)stringForVehicleModelCode:(VehicleModel)vehicleModel
{
    NSString *result;
    switch(vehicleModel)
    {
        case (VehicleModelNotSpecified):
            result = @"No especificado";
            break;
        case (VehicleModelCorsa):
            result = @"Chevrolet Corsa";
            break;
        case (VehicleModelMegane):
            result = @"Renault Megane";
            break;
        case (VehicleModelLogan):
            result = @"Renault Logan";
            break;
        case (VehicleModelC4):
            result = @"Citröen C4";
            break;
        case (VehicleModelSiena):
            result = @"Fiat Siena";
            break;
        default:
            result = @"No definido";
            break;
    }
    return result;
}


+(NSString *)stringForVehicleColorCode:(VehicleColor)vehicleColor
{
    NSString *result;
    switch(vehicleColor)
    {
        case (VehicleColorNotSpecified):
            result = @"No especificado";
            break;
        case (VehicleColorGray):
            result = @"Gris";
            break;
        case (VehicleColorSilver):
            result = @"Plateado";
            break;
        case (VehicleColorWhite):
            result = @"Blanco";
            break;
        case (VehicleColorBlack):
            result = @"Negro";
            break;
        case (VehicleColorRed):
            result = @"Rojo";
            break;
        case (VehicleColorBlue):
            result = @"Azul";
            break;
        default:
            result = @"No definido";
            break;
    }
    return result;
}


-(NSString *)stringForVehicleModel
{
    return [Vehicle stringForVehicleModelCode:[self model]];
}

-(NSString *)stringForVehicleColor
{
    return [Vehicle stringForVehicleColorCode:[self color]];
}


@end