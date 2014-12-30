//
//  User.h
//  Remisse MDQ prototype
//
//  Created by Globant iOS MDQ on 12/29/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

@interface User : NSObject

@property (nonatomic, strong) NSNumber *phoneNumber;
@property (nonatomic, strong) NSMutableArray *favoriteLocations; //An array of locations saved as "favorite"
@end

