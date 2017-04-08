//
//  ScanViewManager.m
//  demoDigimarc
//
//  Created by Phat Chiem on 4/7/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "ScanViewManager.h"
#import <DMSDK/DMSDK.h>

#define DMRESOLVER_USERNAME @"ksfen"
#define DMRESOLVER_PASSWORD @"5slfCl2nM5Bq3X7ZzRAJdm4BIp1PhOhb"

@interface ScanViewManager () <DMSDetectorViewControllerDelegate>

@end

@implementation ScanViewManager

RCT_EXPORT_MODULE()

- (UIView *)view {
  DMSDetectorViewController *viewController = [[DMSDetectorViewController alloc] initWithNibName:nil bundle:nil];
  [viewController setSymbologies:DMSSymbologyImageDigimarc | DMSSymbologyAudioDigimarc | DMSSymbologyUPCA | DMSSymbologyUPCE | DMSSymbologyEAN13 | DMSSymbologyEAN8 | DMSSymbologyDataBar | DMSSymbologyQRCode | DMSSymbologyCode39 | DMSSymbologyCode128 | DMSSymbologySmartLabel options:@{}];
  [viewController setDelegate:self];
  [viewController setResolverURL:nil username:DMRESOLVER_USERNAME password:DMRESOLVER_PASSWORD];
  return viewController.view;
}


-(void)detectorViewController:(DMSDetectorViewController *)viewController resolvedContent:(DMSResolvedContent *)resolvedContent forPayload:(DMSPayload *)payload {
  DMSResolvedContentItem *resolvedContentItem = [resolvedContent.resolvedContentItems firstObject];
  NSString *scannedString = @"";
  if (resolvedContent.rawResolvedContent) {
    NSDictionary *payoff = [resolvedContent.rawResolvedContent[@"Payoffs"] firstObject];
    scannedString = payoff[@"Content"];
  } else {
    scannedString = resolvedContentItem.title;
  }
  self.onChange(@{@"scannedString": scannedString});
}

@end
