//
//  Application.h
//  RemisMDQ
//
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "User.h"
#import "CurrentRequest.h"
#import "Facade.h"


@interface Application : NSObject

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Request *currentRequest;


+ (id)sharedInstance;

@end
