//
//  UDVoteImageLoader.m
//  ULikeItDemo
//
//  Created by Rostyslav Stepanyak on 5/22/14.
//  Copyright (c) 2014 modocache. All rights reserved.
//

#import "UDVoteImageManager.h"
#import "UDImageLaoder.h"
#import "Notifications.h"

@interface UDVoteImageManager ()
   @property (nonatomic, strong) UDImageLaoder *imageLaoder;
@end

@implementation UDVoteImageManager

//shared manager instance
+ (instancetype) sharedManager
{
    static UDVoteImageManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UDVoteImageManager alloc] init];
    });
    
    return _sharedInstance;
}

-(void) fetchAll {
    self.imageLaoder = [[UDImageLaoder alloc] init];
    self.imageLaoder.delegate = self;
    [self.imageLaoder loadImages];
}

-(void) allDataRetrieved:(NSArray *)guys {
    _guys = guys;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:nImagesForVoteReceivedNotification object: nil userInfo:nil];
}

@end
