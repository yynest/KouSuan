//
//  TTSService.h
//  KouSuan
//
//  Created by Fedora on 2019/2/28.
//  Copyright © 2019 Fedora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDSSpeechSynthesizerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTSService : NSObject<BDSSpeechSynthesizerDelegate>
+ (TTSService *)sharedInstance;

- (BOOL)speakSentence:(NSString*)sentence;

@end

NS_ASSUME_NONNULL_END
