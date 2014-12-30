//
//  Request.h
//  Remisse MDQ prototype
//
//  Created by Lucas on 12/29/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "Vehicle.h"
#import "User.h"

@interface Request : NSObject

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Vehicle *vehicle;
@property (nonatomic, strong) NSDate *creationTime;

@end
