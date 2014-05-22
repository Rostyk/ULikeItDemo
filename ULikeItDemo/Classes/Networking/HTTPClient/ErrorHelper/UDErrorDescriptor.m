//
//  DCErrorDescriptor.m
//  Discount Cab 2.0
//
//  Created by Rostyslav Stepanyak on 5/17/14.
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//

#import "UDErrorDescriptor.h"
#import "AFURLConnectionOperation.h"

@implementation UDErrorDescriptor


#pragma mark Public Methods

+ (NSError *)errorTranslatedFromNetworkError:(NSError *)error responseObject:(id)responseObject
{
    NSError *errorTranslatedFromNetworkError = nil;
    NSString *description = nil;
    
    NSUInteger statusCode = 0;
    
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]] && [[responseObject allKeys] containsObject:@"ErrorCode"]) {
        statusCode = [responseObject[@"ErrorCode"] integerValue];
    } else {
        statusCode = [self statusCodeOfNetworkError:error];
    }
    
    
    NSString *descriptionFotStatus = [self descriptionForStatus:statusCode];

    if (descriptionFotStatus) {
        description = descriptionFotStatus;
    }else if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        description = responseObject[@"Error"];
    }

    if (description) {
        
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:description forKey:NSLocalizedDescriptionKey];
        
        errorTranslatedFromNetworkError = [NSError errorWithDomain:@"2PoinB" code:statusCode userInfo:errorDetail];
        
    } else {
        errorTranslatedFromNetworkError = error;
    }
    
    return errorTranslatedFromNetworkError;
}

+ (NSUInteger)statusCodeOfNetworkError:(NSError *)error
{
    NSUInteger statusCodeOfNetworkError;
    
    if ([error code] > 0) {
        
        statusCodeOfNetworkError = [error code];
        
    } else {
    
        NSHTTPURLResponse *response = [[error userInfo] valueForKey:AFNetworkingOperationFailingURLResponseErrorKey];
        statusCodeOfNetworkError = [response statusCode];
    }
    
    return statusCodeOfNetworkError;
}

#pragma makr Private Methods

+ (NSDictionary *)statusDictionary
{
    static NSDictionary *__statusDictionary = nil;
    if (!__statusDictionary) {
        __statusDictionary = @{@"500" : NSLocalizedString(@"Internal server error (500)", nil),
                               @"401" : NSLocalizedString(@"The email or password you entered is incorrect.", nil)
                               };
    }
    return __statusDictionary;
}

+(BOOL)statusDictionaryContainsKey: (NSString *)key
{
    NSArray *allKeys = [[self statusDictionary] allKeys];
    BOOL retVal = [allKeys containsObject:key];
    
    return retVal;
}

+ (NSString *)descriptionForStatus:(NSUInteger)status
{
    NSString *desription = nil;
    NSString *statusString = [[NSNumber numberWithInteger:status] stringValue];
    
    if ([self statusDictionaryContainsKey:statusString]) {
        desription = [[self statusDictionary] valueForKey:statusString];
    }
    
    return desription;
}
@end
