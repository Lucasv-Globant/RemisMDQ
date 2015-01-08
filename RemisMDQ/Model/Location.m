//
//  Location.m
//  RemisMDQ
//
//  Created by Lucas on 12/30/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Location ()
@end

@implementation Location : NSObject

-(id)init
//Initializes the instance with default values, which should be properly set afterwards
{
    self = [super init];
    if (self)
    {
        [self setObjectId:@""];
        [self setCreated_at:[NSDate date]];
        [self setUpdated_at:[NSDate date]];
        [self setLatitude:[NSNumber numberWithFloat:0.0f]];
        [self setLongitude:[NSNumber numberWithFloat:0.0f]];
        [self setStreet:@""];
        [self setHouseNumbering:@""];
        [self setHouseDetails:@""];
        [self setCity:@""];
        [self setCountry:@""];
        [self setProvince:@""];
        [self setZipCode:@""];
    }
    return self;
}


-(NSDictionary *)outputToDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[self objectId] forKey:@"objectId"];
    [dict setObject:[self created_at] forKey:@"created_at"];
    [dict setObject:[self updated_at] forKey:@"updated_at"];
    [dict setObject:[self latitude] forKey:@"latitude"];
    [dict setObject:[self longitude] forKey:@"longitude"];
    [dict setObject:[self street] forKey:@"street"];
    [dict setObject:[self houseNumbering] forKey:@"houseNumbering"];
    [dict setObject:[self houseDetails] forKey:@"houseDetails"];
    [dict setObject:[self city] forKey:@"city"];
    [dict setObject:[self country] forKey:@"country"];
    [dict setObject:[self province] forKey:@"province"];
    [dict setObject:[self zipCode] forKey:@"zipCode"];
    
    NSDictionary *result = [[NSDictionary alloc] initWithDictionary:dict];
    return result;
}




@end