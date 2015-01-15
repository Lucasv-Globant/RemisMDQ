//
//  MobileApplication.m
//  RemisMDQ
//
//  Created by Lucas on 1/7/15.
//  Copyright (c) 2015 iOS MDQ. All rights reserved.
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
        _sharedObject = [[self alloc] initFromPersistentStorageOrNewInstance];
    });
    
    // returns the same object each time
    return _sharedObject;
}


#pragma mark -String Keys for NSUserDefaults
//The string used as a key for NSUserDefaults. Object: currentUser
-(NSString *)stringCodeForCurrentUser
{
    return @"currentUser";
}

//The string used as a key for NSUserDefaults. Object: currentRequest
-(NSString *)stringCodeForCurrentRequest
{
    return @"currentRequest";
}

//The string used as a key for NSUserDefaults. Object: vehicleOfCurrentRequest
-(NSString *)stringCodeForVehicleOfCurrentRequest
{
    return @"vehicleOfCurrentRequest";
}


#pragma mark -Persistence
-(instancetype)initFromPersistentStorageOrNewInstance
{
    //Loads the context data from NSUserDefaults
    self = [super init];
    if (self)
    {
        //Recovering the dictionaries from NSUserDefaults for User, Request, and Vehicle:
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *userDictionary = [defaults dictionaryForKey:[self stringCodeForCurrentUser]];
        NSDictionary *currentRequestDictionary = [defaults dictionaryForKey:[self stringCodeForCurrentRequest]];
        NSDictionary *vehicleOfCurrentRequestDictionary = [defaults dictionaryForKey:[self stringCodeForVehicleOfCurrentRequest]];
        
        //If there was a dictionary for the User object, proceed to initialize the User object:
        if (userDictionary != nil)
        {
            [self setUser:[[User alloc] initFromDictionary:userDictionary]];
            [self setCurrentRequest:[[Request alloc] initInApplication:self withDictionary:currentRequestDictionary]];
            [self setVehicleOfCurrentRequest:[[Vehicle alloc] initInApplication:self withDictionary:vehicleOfCurrentRequestDictionary]];
        }
        else
        {
            [self setUser:[[User alloc] init]];
            [self setCurrentRequest:[[Request alloc] init]];
            [self setVehicleOfCurrentRequest:[[Vehicle alloc] init]];
        }
    }
    return self;
}

-(void)saveToPersistentStorage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[self currentUserOutputToDictionary] forKey:[self stringCodeForCurrentUser]];
    [defaults setObject:[self currentRequestOutputToDictionary] forKey:[self stringCodeForCurrentRequest]];
    [defaults setObject:[self vehicleOfCurrentRequestOutputToDictionary] forKey:[self stringCodeForVehicleOfCurrentRequest]];
    [defaults synchronize];
}


#pragma mark Supporting methods for persistence
-(NSDictionary *)currentUserOutputToDictionary
{
    return [[self user] outputToDictionary];
}

-(NSDictionary *)currentRequestOutputToDictionary
{
    return [[self currentRequest] outputToDictionary];
}

-(NSDictionary *)vehicleOfCurrentRequestOutputToDictionary
{
    return [[self vehicleOfCurrentRequest] outputToDictionary];
}


#pragma mark -Getters for internal objects by ID
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

-(User *)getUserWithObjectId:(NSString *)objectId

//Since this is a mobile application, it only has one User (which is the vehicle of the current request)
//Returns the current user if the objectId being requested matches with the objectId of the user, otherwise return nil.
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

@end
