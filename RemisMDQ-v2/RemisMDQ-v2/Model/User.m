//
//  User.m
//  Remisse MDQ prototype
//
//  Created by Globant iOS MDQ on 12/29/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface User ()
@end

@implementation User : NSObject

-(id)init
//Initializes the instance with default values, which should be properly set afterwards

{
    self = [super init];
    if (self)
    {
        [self setObjectId:@""];
        [self setCreated_at:nil];
        [self setUpdated_at:nil];
        [self setPhoneNumber:[NSNumber numberWithInt:0]];
        [self setFavoriteLocations:[[NSMutableArray alloc] init]];
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

    //Phone number:
    [dict setObject:[self phoneNumber] forKey:@"phoneNumber"];
    
    //Favorites(saving objectId only):
    NSMutableArray *mutableFavorites = [[NSMutableArray alloc] init];
    for (Location *loc in [self favoriteLocations])
    {
        [mutableFavorites addObject:[loc objectId]];
    }
    NSArray *favorites = [[NSArray alloc] initWithArray:mutableFavorites];
    [dict setObject:favorites forKey:@"favoriteLocations"];

    //Converting from NSMutableDictionary to NSDictionary:
    NSDictionary *result = [[NSDictionary alloc] initWithDictionary:dict];
    return result;
}

-(instancetype)initFromDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    if (self)
    {
        //Object ID and time stamps:
        [self setObjectId:[aDictionary objectForKey:@"objectId"]];
        [self setCreated_at:[aDictionary objectForKey:@"created_at"]];
        [self setUpdated_at:[aDictionary objectForKey:@"updated_at"]];
        //Instance variables specific for this class:
        [self setPhoneNumber:[aDictionary objectForKey:@"phoneNumber"]];
        [self setFavoriteLocations:[[NSMutableArray alloc] initWithArray:[aDictionary objectForKey:@"favoriteLocations"]]];
    }
    return self;
}


@end
