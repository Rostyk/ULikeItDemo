//
//  GFCRequestSerializer.m
//  Yellow
//
//  Created by Rostyslav Stepanyak on 5/17/14.
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//

#import "UDRequestSerializer.h"
#import "Networking.h"

//Requst Serializer Header

NSString * const kAppAuthToken = @"token";


@implementation UDRequestSerializer

-(id)init {
    self = [super init];
    if (self) {
        [self setRequestHeaderFields];
    }
    
    return self;
}

#pragma mark -
#pragma mark Private Methods

/*
 * This methods is used for setting Requst Serializer Header field
 */

-(void)setRequestHeaderFields {
    [self setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self setValue:@"en-US,en;q=0.8" forHTTPHeaderField:@"Accept-Language"];
}

#pragma mark -
#pragma mark Public Methods

-(void)setAuthorizationHeaderFieldWithToken:(NSString *)token {
    //token = [NSString stringWithFormat: @"\"%@\"", token];
    [self setValue:token forHTTPHeaderField:kAppAuthToken];
}


@end
