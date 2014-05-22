//
//  GFCPassengerLoginOperation.h
//  Yellow
//
//  Created by Rostyslav Stepanyak on 5/17/14.
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//

#import "UDRequestOperation.h"

@interface UDFetchImageOperation : UDRequestOperation <UDRequestOperationProtocol>

/* Load image operation */
    
-(instancetype)initWithParameters:(NSDictionary *)params delegate:(id<UDRequestOperationDelegate>)delegate imageName: (NSString*) imageName;

@property (nonatomic) int ID;
@end
