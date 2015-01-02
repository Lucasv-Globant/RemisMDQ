//
//  Agency.h
//  RemisMDQ
//
//  Created by Lucas on 12/30/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

@interface Agency : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSDate *created_at;
@property (nonatomic, strong) NSDate *updated_at;

@property (nonatomic, strong) NSString *name;

@end
