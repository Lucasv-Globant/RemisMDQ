//
//  User.h
//  Remisse MDQ prototype
//
//  Created by Globant iOS MDQ on 12/29/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

#import "Location.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSDate *created_at;
@property (nonatomic, strong) NSDate *updated_at;

@property (nonatomic, strong) NSNumber *phoneNumber;
@property (nonatomic, strong) NSMutableArray *favoriteLocations; //An array of locations saved as "favorite"

-(id)init;
-(NSDictionary *)outputToDictionary;
-(instancetype)initFromDictionary:(NSDictionary *)aDictionary;

@end

