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
        [self setPhoneNumber:[NSNumber numberWithInt:0]];
        [self setFavoriteLocations:[[NSMutableArray alloc] init]];
    }
    return self;
}

-(NSMutableDictionary *)outputToDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[self phoneNumber] forKey:@"phoneNumber"];
    
    NSMutableArray *favorites = [[NSMutableArray alloc] init];
    for (Location *loc in [self favoriteLocations])
    {
        [favorites addObject:[loc objectId]];
    }
    
    [dict setObject:favorites forKey:@"favoriteLocations"];
    
    return dict;
}

@end
