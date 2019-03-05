//
//  ViewController.m
//  KouSuan
//
//  Created by Fedora on 2019/2/27.
//  Copyright © 2019 Fedora. All rights reserved.
//

#import "ViewController.h"
#import "TTSService.h"

#import "BDSEventManager.h"
#import "BDSASRDefines.h"
#import "BDSASRParameters.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lb_result;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TTSService sharedInstance] speakSentence:@"1+1=几"];
}

- (IBAction)clickedStart:(id)sender {
    
}


@end
