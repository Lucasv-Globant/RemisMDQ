//
//  Facade.h
//  RemisMDQ
//
//  Created by Analia on 1/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
@class Request;
@interface Facade : NSObject

#pragma mark - Singleton
+ (id)sharedInstance;

#pragma mark - Method
-(instancetype)initWithParse;
-(void)insertRequestDataInParse:(Request *)requestSave;
-(NSDictionary *)findInParseWith:(NSString *)whereKey value:(NSString *)value in:(NSString *)from;
-(void)updateRequestInParseWith:(NSString *)Id data:(NSDictionary *)dataUpdate;
-(void)deleteInPaseWith:(NSString *)Id in:(NSString *)from;
-(NSMutableArray *)getInParse:(NSString *)from;

@end
