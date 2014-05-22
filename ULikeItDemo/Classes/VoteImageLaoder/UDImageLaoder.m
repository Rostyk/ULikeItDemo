//
//  UDImageLaoder.m
//  ULikeItDemo
//
//  Created by Rostyslav Stepanyak on 5/22/14.
//  Copyright (c) 2014 modocache. All rights reserved.
//

#import "UDImageLaoder.h"
#import "UDFetchImageOperation.h"
#import "Person.h"

@interface UDImageLaoder() {
       int imagesLoaded;
   }
   @property (nonatomic, strong) NSMutableArray *guys;
@end

@implementation UDImageLaoder

-(id) init {
    self = [super init];
    imagesLoaded = 0;
    self.guys = [[NSMutableArray alloc] init];
    
     // Load images for all teh guys (Lets assume we've got persons meta data already available)
    
     [self.guys addObject: [[Person alloc] initWithName: @"Vincent" image:nil age:39 ]];
     [self.guys addObject: [[Person alloc] initWithName: @"Radina" image:nil age:23 ]];
     [self.guys addObject: [[Person alloc] initWithName: @"Amy" image:nil age:24 ]];
    
     return self;
}

-(void) loadImages {
    int idValue = 0;
    
    /*the name of the images on server is exactly the same as the name of the person: [name].png, made for a test purpose*/
    for(Person *person in self.guys) {
        UDFetchImageOperation *radinaOperation = [[UDFetchImageOperation alloc] initWithParameters: nil delegate: self imageName: [NSString stringWithFormat: @"%@.png", person.name]];
        radinaOperation.ID = idValue;
        [radinaOperation start];
        
        idValue++;
    }
}

#pragma mark Response delegate methods

-(void)requestOperation:(UDFetchImageOperation *)operation didFinishHandlingResponse:(id)responseObject {
    /*Successfully logged in*/
    if ([operation isKindOfClass:[UDFetchImageOperation class]]) {
        
        Person *person = [self.guys objectAtIndex: operation.ID];
        person.image = (UIImage*)responseObject;
        imagesLoaded++;
        
        if(imagesLoaded == [self.guys count]) {
            [self.delegate allDataRetrieved: self.guys];
        }
    }
    
}

//method failed
-(void)requestOperation:(UDRequestOperation *)operation didFailWithError:(NSError *)error userMessage:(NSString *)message {
    [self produceAlertWithMessage: [error localizedDescription]];
}

#pragma mark Erro Alerts
-(void) produceAlertWithMessage: (NSString*) message {
    [[[UIAlertView alloc] initWithTitle:@"" message: message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}


@end
