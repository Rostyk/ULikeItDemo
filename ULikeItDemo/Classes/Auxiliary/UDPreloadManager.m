//
//  DCPreloadManager.m
//  Discount Cab 2.0
//
//  Created by Rostyslav Stepanyak on 4/2/14.
//  Copyright (c) 2014 Treeline Interactive. All rights reserved.
//

#import "UDPreloadManager.h"

@interface UDPreloadManager ()

@property (nonatomic, strong) UIView *preloadView;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation UDPreloadManager

+(instancetype)sharedManager
{
    static UDPreloadManager * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UDPreloadManager alloc] init];
    });
    
    return _sharedInstance;
}

//creating preload views programatically
-(id) init {
    self = [super init];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.preloadView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    self.preloadView.backgroundColor = [UIColor colorWithRed: 141./255. green: 145./255. blue: 152./255. alpha: 0.45];
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.spinner.center = CGPointMake(bounds.size.width / 2, bounds.size.height / 2);
    [self.preloadView addSubview: self.spinner];
    
    UILabel *preloadLabel = [[UILabel alloc] init];
    preloadLabel.backgroundColor = [UIColor clearColor];
    preloadLabel.textColor = /*[UIColor colorWithRed: 215./255. green: 218./255. blue: 221./255. alpha: 1.0]*/ [UIColor whiteColor];
    preloadLabel.font = [UIFont fontWithName: @"Arial" size: 14];
    preloadLabel.text = @"Downloading images";
    [preloadLabel sizeToFit];
    preloadLabel.center = CGPointMake(158, bounds.size.height / 2 + 50);
    [self.preloadView addSubview: preloadLabel];
    [self.spinner startAnimating];
    return self;
}

/* spinnerOffsetY actually contains the hight of the top bars (status bar + nabigation bar), it can be:  64 / 44 / 20 / 0 */
-(void) addPreloadToView: (UIView*) view spinnerOffset: (int) spinnerOffsetY {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.preloadView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    
    self.spinner.center = CGPointMake(self.preloadView.frame.size.width / 2, self.preloadView.frame.size.height / 2);
    if(![[view subviews] containsObject: self.preloadView])
      [view addSubview: self.preloadView];
}

-(void) removePreloadView {
    [self.preloadView removeFromSuperview];
}
    
-(void) dealloc {
    self.preloadView = nil;
    self.spinner = nil;
}

@end
