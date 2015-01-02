//
//  Facade.h
//  RemisMDQ
//
//  Created by Analia on 1/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Success)(NSMutableDictionary * dic);
typedef void (^Failure)(NSError* error);
@interface Facade : NSObject

#pragma mark - Singleton
+ (id)sharedInstance;

#pragma mark - Method
-(void)insertDataInParse:(Success)success failure:(Failure)failure;
-(void)findInParse:(Success)success failure:(Failure)failure;
-(void)updateInParse:(Success)success failure:(Failure)failure;
-(void)deleteInPase:(Success)success failure:(Failure)failure;

@end
