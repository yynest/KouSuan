//
//  TTSService.m
//  KouSuan
//
//  Created by Fedora on 2019/2/28.
//  Copyright © 2019 Fedora. All rights reserved.
//

#import "TTSService.h"
#import "ComDefined.h"
#import "BDSSpeechSynthesizer.h"
#import <AVFoundation/AVFoundation.h>


@implementation TTSService

+ (TTSService *)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype) init {
    if (self = [super init]) {
        [self configureSDK];
    }
    return self;
}

- (void)configureSDK {
    NSLog(@"TTS version info: %@", [BDSSpeechSynthesizer version]);
    [BDSSpeechSynthesizer setLogLevel:BDS_PUBLIC_LOG_VERBOSE];
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    [self configureOnlineTTS];
    [self configureOfflineTTS];
}



- (void)configureOnlineTTS {
    [[BDSSpeechSynthesizer sharedInstance] setApiKey:API_KEY withSecretKey:SECRET_KEY];
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:@(BDS_SYNTHESIZER_SPEAKER_FEMALE) forKey:BDS_SYNTHESIZER_PARAM_SPEAKER];
    //    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:@(10) forKey:BDS_SYNTHESIZER_PARAM_ONLINE_REQUEST_TIMEOUT];
}

- (void)configureOfflineTTS {
    NSError *err = nil;
    // 在这里选择不同的离线音库（请在XCode中Add相应的资源文件），同一时间只能load一个离线音库。根据网络状况和配置，SDK可能会自动切换到离线合成。
    NSString* offlineEngineSpeechData = [[NSBundle mainBundle] pathForResource:@"Chinese_And_English_Speech_Female" ofType:@"dat"];
    
    NSString* offlineChineseAndEnglishTextData = [[NSBundle mainBundle] pathForResource:@"Chinese_And_English_Text" ofType:@"dat"];
    
    err = [[BDSSpeechSynthesizer sharedInstance] loadOfflineEngine:offlineChineseAndEnglishTextData speechDataPath:offlineEngineSpeechData licenseFilePath:nil withAppCode:APP_ID];
    if(err){
//        [self displayError:err withTitle:@"Offline TTS init failed"];
        return;
    }
//    [TTSConfigViewController loadedAudioModelWithName:@"Chinese female" forLanguage:@"chn"];
//    [TTSConfigViewController loadedAudioModelWithName:@"English female" forLanguage:@"eng"];
}

- (BOOL)speakSentence:(NSString*)sentence {
    NSInteger sentenceID;
    NSError* err = nil;
    sentenceID = [[BDSSpeechSynthesizer sharedInstance] speakSentence:sentence withError:&err];
    return YES;
}



#pragma mark - implement BDSSpeechSynthesizerDelegate
- (void)synthesizerStartWorkingSentence:(NSInteger)SynthesizeSentence{
    NSLog(@"Did start synth %ld", SynthesizeSentence);

}

- (void)synthesizerFinishWorkingSentence:(NSInteger)SynthesizeSentence{
    NSLog(@"Did finish synth, %ld", SynthesizeSentence);
}

- (void)synthesizerSpeechStartSentence:(NSInteger)SpeakSentence{
    NSLog(@"Did start speak %ld", SpeakSentence);
}

- (void)synthesizerSpeechEndSentence:(NSInteger)SpeakSentence{
    NSLog(@"Did end speak %ld", SpeakSentence);
}

- (void)synthesizerNewDataArrived:(NSData *)newData
                       DataFormat:(BDSAudioFormat)fmt
                   characterCount:(int)newLength
                   sentenceNumber:(NSInteger)SynthesizeSentence{
    NSMutableDictionary* sentenceDict = nil;
//    for(NSMutableDictionary *dict in self.synthesisTexts){
//        if([[dict objectForKey:@"ID"] integerValue] == SynthesizeSentence){
//            sentenceDict = dict;
//            break;
//        }
//    }
//    if(sentenceDict == nil){
//        NSLog(@"Sentence ID mismatch??? received ID: %ld\nKnown sentences:", (long)SynthesizeSentence);
//        for(NSDictionary* dict in self.synthesisTexts){
//            NSLog(@"ID: %ld Text:\"%@\"", [[dict objectForKey:@"ID"] integerValue], [((NSAttributedString*)[dict objectForKey:@"TEXT"]) string]);
//        }
//        return;
//    }
    [sentenceDict setObject:[NSNumber numberWithInteger:newLength] forKey:@"SYNTH_LEN"];
}

- (void)synthesizerTextSpeakLengthChanged:(int)newLength
                           sentenceNumber:(NSInteger)SpeakSentence{
    NSLog(@"SpeakLen %ld, %d", SpeakSentence, newLength);
    NSMutableDictionary* sentenceDict = nil;
//    for(NSMutableDictionary *dict in self.synthesisTexts){
//        if([[dict objectForKey:@"ID"] integerValue] == SpeakSentence){
//            sentenceDict = dict;
//            break;
//        }
//    }
//    if(sentenceDict == nil){
//        NSLog(@"Sentence ID mismatch??? received ID: %ld\nKnown sentences:", (long)SpeakSentence);
//        for(NSDictionary* dict in self.synthesisTexts){
//            NSLog(@"ID: %ld Text:\"%@\"", [[dict objectForKey:@"ID"] integerValue], [((NSAttributedString*)[dict objectForKey:@"TEXT"]) string]);
//        }
//        return;
//    }
//    [sentenceDict setObject:[NSNumber numberWithInteger:newLength] forKey:@"SPEAK_LEN"];
}

- (void)synthesizerdidPause{
    NSLog(@"Did Pause");
}

- (void)synthesizerResumed{
    NSLog(@"Did resume");
}

- (void)synthesizerCanceled{
    NSLog(@"Did cancel");
}

- (void)synthesizerErrorOccurred:(NSError *)error
                        speaking:(NSInteger)SpeakSentence
                    synthesizing:(NSInteger)SynthesizeSentence{
    NSLog(@"Did error %ld, %ld", SpeakSentence, SynthesizeSentence);
    [[BDSSpeechSynthesizer sharedInstance] cancel];
}


@end
