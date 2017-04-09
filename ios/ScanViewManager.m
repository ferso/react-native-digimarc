//
//  ScanViewManager.m
//  demoDigimarc
//
//  Created by Phat Chiem on 4/7/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "ScanViewManager.h"
#import "ScanViewController.h"

@interface ScanViewManager () <DMSDetectorViewControllerDelegate>
@property (nonatomic) ScanViewController *scanViewController;
@end

@implementation ScanViewManager

RCT_EXPORT_MODULE()

- (UIView *)view {
  self.scanViewController = [ScanViewController new];
  return _scanViewController.view;
//  self.detectorViewController = [[DMSDetectorViewController alloc] initWithNibName:nil bundle:nil];
//  [_detectorViewController setSymbologies:DMSSymbologyImageDigimarc | DMSSymbologyAudioDigimarc | DMSSymbologyUPCA | DMSSymbologyUPCE | DMSSymbologyEAN13 | DMSSymbologyEAN8 | DMSSymbologyDataBar | DMSSymbologyQRCode | DMSSymbologyCode39 | DMSSymbologyCode128 | DMSSymbologySmartLabel options:@{}];
//  [_detectorViewController setDelegate:self];
//  [_detectorViewController setResolverURL:nil username:usernameCredential password:passwordCredential];
//  return self.detectorViewController.view;
}

@end
