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

@end