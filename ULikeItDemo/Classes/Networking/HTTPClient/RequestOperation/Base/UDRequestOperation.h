//
//  ADBaseRequestOperation.h
//
//  Created by Rostyslav Stepanyak on 5/17/14.
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UDHTTPClient.h"
#import "UDRequestOperationDelegate.h"

typedef NS_ENUM(NSInteger, RequestOperationType) {
    RTGet        = 0,
    RTPost       = 1,
    RTFetchImage = 2
};



extern NSString * const kUnauthorisedRequestNotification;

@protocol UDRequestOperationProtocol <NSObject>
@optional

- (instancetype) initWithParameters:(NSDictionary *) params
                           delegate:(id<UDRequestOperationDelegate>)delegate;

- (instancetype) initWithContext:(NSManagedObjectContext *)managedObjectContext
                        delegate:(id<UDRequestOperationDelegate>)delegate;


- (instancetype) initWithParameters:(NSDictionary *) params
                            context:(NSManagedObjectContext *)managedObjectContext
                           delegate:(id<UDRequestOperationDelegate>)delegate;

@end

/* Base Request Class. All the subsequent requests should be inherited from this class with at least initWithPararmeter / performHandlingResponse being overridden*/

@interface UDRequestOperation : NSOperation

@property (readonly) BOOL isExecuting;
@property (readonly) BOOL isFinished;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, weak, readonly) id <UDRequestOperationDelegate> delegate;

@property (nonatomic) RequestOperationType type;
// ========= Web Server Api Call Details =============
@property (nonatomic, strong, readonly) NSString *serverMethodName;
@property (nonatomic, strong, readonly) NSDictionary *parameters;

// ========= Public methods =============
- (instancetype) initWithMethod:(NSString *)method
                     parameters:(NSDictionary *)parameters
                        context:(NSManagedObjectContext *)managedObjectContext
                       delegate:(id <UDRequestOperationDelegate> )delegate;

/**
 * @note Can be overriden by subclass to change web api call.
 */
- (void)performRequestForMethod:(NSString *)apiName withParameters:(NSDictionary *)parameters;

/**
 * @note Can be overriden by subclass to perform respons handling.
 * @note You must call [super performHandlingResponse:] after finishing custom operations in this mehod.
 */
- (void)performHandlingResponse:(id)responseObject;

/**
 * @note Must be called in succes response block
 */
- (void)requestSuccess:(id)responseObject;

/**
 * @note Must be called in failed response block
 */
- (void)requestFailed:(NSError *)error;

@end
