//
//  ViewController.m
//  YouTubeUploaderDemo
//
//  Created by tbago on 16/4/12.
//  Copyright © 2016年 tbago. All rights reserved.
//

#import "ViewController.h"
#import <YouTubeUploaderFramework/YouTubeUploader.h>

static NSString *const kClientID        = @"304715988357-8vuq0b89imqh0474ri4ceigpn7m145h6.apps.googleusercontent.com";
static NSString *const kClientSecret    = @"rCcqhEdkZsOkQ4bEEqfM6i47";

@interface ViewController ()

@property (strong ,nonatomic) YouTubeUploader *youtubeUploader;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![self.youtubeUploader isAuthorized]) {
        UIViewController *authViewController = [self.youtubeUploader createAuthViewController];
        [self.navigationController pushViewController:authViewController animated:YES];
    }
}

#pragma mark - action

- (IBAction)uploadButtonClick:(UIButton *)sender {
    ///< FixMe(tbago) before use the project
    ///< drag the video to the project or select video from camera
    NSString *videoFilePath = [[NSBundle mainBundle] pathForResource:@"FCA"
                                                              ofType:@"mp4"];   //Get the Video from Bundle
    NSURL *videoFileURL = [NSURL fileURLWithPath:videoFilePath];    //Convert the NSString To NSURL
    NSData *fileData = [NSData dataWithContentsOfURL:videoFileURL];
    [self.youtubeUploader uploadYoutubeVideo:fileData
                                       title:@"Test video"
                                 description:@"A video for youtube test"
                                     process:^(float percent) {
                                         NSLog(@"upload percent:%f", percent);
                                     }
                                    complate:^(BOOL success, NSString *message) {
                                        if (success) {
                                            NSLog(@"upload success:%@", message);
                                        }
                                        else {
                                            NSLog(@"%@", message);
                                        }
                                    }];
}

#pragma mark - get & set

- (YouTubeUploader *)youtubeUploader {
    if (_youtubeUploader == nil) {
        _youtubeUploader = [[YouTubeUploader alloc] initYoutubeUploaderWithClientID:kClientID
                                                                      clientSecret:kClientSecret];
    }
    return _youtubeUploader;
}

@end
