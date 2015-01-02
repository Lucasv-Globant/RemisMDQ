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

@end
