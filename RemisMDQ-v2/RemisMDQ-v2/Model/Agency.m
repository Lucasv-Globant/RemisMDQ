//
//  Agency.m
//  RemisMDQ
//
//  Created by Analia on 1/5/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Agency.h"
#import <Parse/Parse.h>

@interface Agency ()

@end
@implementation Agency

-(id)initFromDictionary:(NSDictionary *)aDictionary
{
    if (self=[super init])
    {
        [self setName:aDictionary[@"name"]];
        [self setObjectId:aDictionary[@"objectId"]];
        [self setCreated_at:aDictionary[@"created_at"]];
        [self setUpdated_at:aDictionary[@"updated_at"]];
    }
    return self;
}

-(NSMutableDictionary *)outputToMutableDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[self objectId] forKey:@"objectId"];
    [dict setObject:[self created_at] forKey:@"created_at"];
    [dict setObject:[self updated_at] forKey:@"updated_at"];
    [dict setObject:[self name] forKey:@"name"];
    return dict;
}

-(NSDictionary *)outputToDictionary
{
    return [[NSDictionary alloc] initWithDictionary:[self outputToMutableDictionary]];
}

@end