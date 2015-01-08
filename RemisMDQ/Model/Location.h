//
//  Location.h
//  RemisMDQ
//
//  Created by Lucas on 12/30/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

@interface Location : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSDate *created_at;
@property (nonatomic, strong) NSDate *updated_at;

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *houseNumbering;
@property (nonatomic, strong) NSString *houseDetails;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *country;

-(id)init;
-(NSDictionary *)outputToDictionary;

@end
