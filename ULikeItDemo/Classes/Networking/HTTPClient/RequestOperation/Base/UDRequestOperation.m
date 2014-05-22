//
//  ADBaserRequestOperation.m
//  Yellow
//
//  Created by Rostyslav Stepanyak on 5/17/14.
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//

#import "UDRequestOperation.h"
#import "UDErrorDescriptor.h"

@import CoreData.NSManagedObjectContext;

@interface UDRequestOperation ()

@property (nonatomic, weak, readwrite) id <UDRequestOperationDelegate> delegate;

@property (nonatomic, strong, readwrite) NSString *serverMethodName;
@property (nonatomic, strong, readwrite) NSDictionary *parameters;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;

@end

@implementation UDRequestOperation

#pragma mark - Base Initialization Method

- (instancetype) initWithMethod:(NSString *)method
                     parameters:(NSDictionary *)parameters
                        context:(NSManagedObjectContext *)managedObjectContext delegate:(id<UDRequestOperationDelegate>)delegate;
{
	if (self = [super init]) {
	
        _serverMethodName = method;
		_managedObjectContext = managedObjectContext;
		_parameters = parameters;
		_delegate = delegate;
        
        _isExecuting = NO;
        _isFinished = NO;
	}
    
	return self;
}

#pragma mark - NSOperation Overrided Method

 -(void) main {
  
    [self performRequestForMethod:self.serverMethodName withParameters:self.parameters];
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
}


- (void)finish
{
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    _isExecuting = NO;
    _isFinished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isConcurrent
{
    return YES;
}
#pragma mark - Custom Methods

- (void)performRequestForMethod:(NSString *)apiName withParameters:(NSDictionary *)parameters
{
    NSLog(@"performRequestForMethod: %@  START", apiName);
    
    if(self.type == RTGet) {
        [[UDHTTPClient client] GET:apiName parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject ) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]]) {
                [self requestSuccess:responseObject];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            
            error = [UDErrorDescriptor errorTranslatedFromNetworkError:error responseObject:operation.responseObject];
            [self requestFailed:error];
            
        }];
    }
    if(self.type == RTPost) {
        [[UDHTTPClient client] POST:apiName parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject ) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]]) {
                //handle success response
                NSLog(@"performRequestForMethod-success: %@", responseObject);
                [self requestSuccess:responseObject];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            
            error = [UDErrorDescriptor errorTranslatedFromNetworkError:error responseObject:operation.responseObject];
            [self requestFailed:error];
            
        }];
    }
    if(self.type == RTFetchImage) {
        [[UDHTTPClient client] FETCH_IMAGE:apiName parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject ) {
            if([responseObject isKindOfClass: [UIImage class]]) {
                //handle success response
                [self requestSuccess:responseObject];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            
            error = [UDErrorDescriptor errorTranslatedFromNetworkError:error responseObject:operation.responseObject];
            [self requestFailed:error];
            
        }];

    }
}

-(void)requestSuccess:(id)responseObject
{
    if (!self.isCancelled) {
        
        [self performHandlingResponse:responseObject];
        
        if([self.delegate respondsToSelector:@selector(requestOperation:didReceiveResponse:)]) {
            [self.delegate requestOperation:self didReceiveResponse:responseObject];
        }
        
        NSLog( @"%@", responseObject);
        
    }
}

- (void)requestFailed:(NSError *)error
{
	if (!self.isCancelled) {
       
        NSInteger statusCode = [UDErrorDescriptor statusCodeOfNetworkError:error];
        NSLog(@"Request Error Status Code: %ld", (long)statusCode);

        [self finish];
        
        if ([self.delegate respondsToSelector:@selector(requestOperation:didFailWithError:userMessage:)]) {
			[self.delegate requestOperation:self didFailWithError:error userMessage:[error localizedDescription]];
		}
        
	}
}

- (void)performHandlingResponse:(id)responseObject
{
    [self finish];
    
    if([self.delegate respondsToSelector:@selector(requestOperation:didFinishHandlingResponse:)]) {
        [self.delegate requestOperation:self didFinishHandlingResponse:responseObject];
    }
}

@end
