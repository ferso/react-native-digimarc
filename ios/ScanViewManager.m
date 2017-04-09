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
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)

- (UIView *)view {
  self.scanViewController = [ScanViewController new];
  return _scanViewController.view;
}

@end
