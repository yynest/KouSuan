//
//  ASRService.m
//  KouSuan
//
//  Created by Fedora on 2019/2/28.
//  Copyright © 2019 Fedora. All rights reserved.
//

#import "ASRService.h"
#import "ComDefined.h"

#import "BDSEventManager.h"
#import "BDSASRDefines.h"
#import "BDSASRParameters.h"

@implementation ASRService

+ (ASRService *)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype) init {
    if (self = [super init]) {
//        [self configureSDK];
    }
    return self;
}

@end
