//
//  UDVoteImageLoader.h
//  ULikeItDemo
//
//  Created by Rostyslav Stepanyak on 5/22/14.
//  Copyright (c) 2014 modocache. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UDRequestOperationDelegate.h"
#import "UDImageFetchDeleagte.h"

/*utilizes images loading process*/

@interface UDVoteImageManager : NSObject <UDImageFetchDeleagte>
@property (nonatomic, readonly, strong) NSArray *guys;

/*retrive all the persnons info*/
-(void) fetchAll;

+(instancetype) sharedManager;
@end
