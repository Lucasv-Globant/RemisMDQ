//
//  MobileApplication.m
//  RemisMDQ
//
//  Created by Lucas on 1/7/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MobileApplication.h"

@interface MobileApplication ()
@end

@implementation MobileApplication : NSObject

+ (id)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

-(User *)getUserWithObjectId:(NSString *)objectId
{
    if ( [[[self user] objectId] isEqualToString:objectId] )
    {
        return [self user];
    }
    else
    {
        return nil;
    }
}


-(Agency *)getAgencyWithObjectId:(NSString *)objectId
{
    //Since this is a mobile application, it only has one agency (which is the agency of the current request)
    //Returns the current agency if the objectId being requested matches with the objectId of the agency, otherwise return nil.
    if ( [[[self agencyOfCurrentRequest] objectId] isEqualToString:objectId] )
    {
        return [self agencyOfCurrentRequest];
    }
    else
    {
        return nil;
    }
}

-(Vehicle *)getVehicleWithObjectId:(NSString *)objectId
{
    //Since this is a mobile application, it only has one vehicle (which is the vehicle of the current request)
    //Returns the current vehicle if the objectId being requested matches with the objectId of the vehicle, otherwise return nil.
    if ( [[[self vehicleOfCurrentRequest] objectId] isEqualToString:objectId] )
    {
        return [self vehicleOfCurrentRequest];
    }
    else
    {
        return nil;
    }
}


@end
