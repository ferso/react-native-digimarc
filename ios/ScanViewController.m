//
//  SVScanViewController.m
// JML
//

#import "ScanViewController.h"
//#import "SVProductListingViewController.h"
//#import "NSString+Validation.h"
//#import "SVClipboardUtil.h"
//#import "SVSMSUtil.h"
//#import "SVEventUtil.h"
//#import "SVContactUtil.h"
//#import "SVDateTimeUtil.h"
#import <AddressBookUI/AddressBookUI.h>
//#import "SVProductViewController.h"
//#import "SIAlertView+Style.h"
#import <DMSDK/DMSDK.h>
//#import "SVWebViewOthersViewController.h"
#import <MessageUI/MessageUI.h>

#define kSegueOldScanId @"FromScanToOldScan"
#define kSegueProductDetailId @"FromScanToProduct"
#define kSegueProductListingId @"FromScanToProductListing"

#define DMRESOLVER_USERNAME @"ksfen"
#define DMRESOLVER_PASSWORD @"5slfCl2nM5Bq3X7ZzRAJdm4BIp1PhOhb"

@interface ScanViewController () <UIAlertViewDelegate, MFMessageComposeViewControllerDelegate, ABNewPersonViewControllerDelegate, DMSDetectorViewControllerDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) NSString *scannedString;
@property (nonatomic, weak) UIBarButtonItem *flashButton;

@end

@implementation ScanViewController

#pragma mark - View Controller Lifecycle
- (instancetype)init {
  self = [super init];
  if (self) {
    self.delegate = self;
    [self setResolverURL:nil username:DMRESOLVER_USERNAME password:DMRESOLVER_PASSWORD];
  }
  return self;
}

- (void)setUpDetectionViewController {
  self.crosshairsView.hidden = YES;
  self.userGuidanceView.hidden = YES;
  self.audioVisualizerView.hidden = YES;
  for (UIView *view in self.view.subviews) {
    if ([view isKindOfClass:[UINavigationBar class]]) {
      [view removeFromSuperview];
      break;
    }
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self setUpDetectionViewController];
  if (!_isFromSignInViewController) {
//    [self showTabBar];
    self.tabBarController.tabBar.translucent = YES;
  }
//  [self setLogoForTitle:NO];
  self.detectionEnabled = YES;
  [self addButtonsToNavigationBar];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  if (![keyPath isEqualToString:@"torchMode"]) {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

- (void)addBackButton {
  if (_flashButton == nil) {
    _flashButton = self.navigationItem.leftBarButtonItem;
  }
  self.navigationItem.rightBarButtonItem = _flashButton;
  UIImage *image = [UIImage imageNamed:@"back_nav"];
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(0, 0, 20, 44);
  [button setImage:image forState:UIControlStateNormal];
  UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
  self.navigationItem.leftBarButtonItem = backButton;
  self.navigationItem.hidesBackButton = YES;
  [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)addButtonsToNavigationBar {
  if (_isFromSignInViewController) {
    [self addBackButton];
  } else {
    // History Button
    UIButton *buttonHistory = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonHistory.frame = CGRectMake(0, 0, 60, 44);
    buttonHistory.titleLabel.textColor = [UIColor whiteColor];
//    buttonHistory.titleLabel.font = kFontBold(14);
    [buttonHistory setTitle:@"History" forState:UIControlStateNormal];
    [buttonHistory addTarget:self
                      action:@selector(historyButtonDidTouch)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemHistory = [[UIBarButtonItem alloc] initWithCustomView:buttonHistory];
    self.navigationItem.rightBarButtonItem = itemHistory;
  }
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  self.detectionEnabled = NO;
}

#pragma mark - SDK delegate methods
-(void)detectorViewController:(DMSDetectorViewController *)viewController resolvedContent:(DMSResolvedContent *)resolvedContent forPayload:(DMSPayload *)payload {
  DMSResolvedContentItem *resolvedContentItem = [resolvedContent.resolvedContentItems firstObject];
  if (resolvedContent.rawResolvedContent) {
    NSDictionary *payoff = [resolvedContent.rawResolvedContent[@"Payoffs"] firstObject];
    _scannedString = payoff[@"Content"];
  } else {
    _scannedString = resolvedContentItem.title;
  }
  [self processScannedString];
}

#pragma mark - Process Scanned String
- (void)processScannedString {
  // Play sound and vibrate device
  [self playSuccessfulSound];
  // TODO: call onChange scannedString
  
  // Init Old Scan object
//  SVOldScan *oldScan = [[SVOldScan alloc] init];
//  oldScan.createdAt = [[NSDate date] timeIntervalSince1970];
//  oldScan.oldScanId = oldScan.createdAt;
//  oldScan.scanContent = _scannedString;
//  
//  // Get User Id
//  SVUser *user = [[UserManager shareInstance] loadUser];
//  if (user) {
//    oldScan.userId = user.internalBaseClassIdentifier;
//  }
//  
//  oldScan.contentType = [_scannedString getQRType];
  
  // Get old scans from local storage
//  NSArray *oldScans = [[OldScanManager sharedInstance] loadScanData];
//  NSMutableArray *saveScans;
//  if (oldScans) {
//    if (oldScans.count == 30) {
//      oldScans = [oldScans sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        NSNumber *createdAt1 = [NSNumber numberWithInteger:((SVOldScan *)obj1).createdAt];
//        NSNumber *createdAt2 = [NSNumber numberWithInteger:((SVOldScan *)obj2).createdAt];
//        return [createdAt2 compare:createdAt1];
//      }];
//      saveScans = [NSMutableArray arrayWithArray:[oldScans subarrayWithRange:NSMakeRange(0, 29)]];
//    } else {
//      saveScans = [NSMutableArray arrayWithArray:oldScans];
//    }
//  } else {
//    saveScans = [NSMutableArray array];
//  }
//  
//  [saveScans addObject:oldScan];
//  
//  // Save new scan data to local storage
//  [[OldScanManager sharedInstance] saveScanData:saveScans];
//  
//  // Post scan data to server
//  [SVNetworkEngine postScan:oldScan
//                  onSuccess:^(NSDictionary *data) {
//                    NSLog(@"Post scan data to server successfully.");
//                  } onError:^(NSError *error, NSDictionary *data) {
//                    NSLog(@"Error posting scan data to server : %@", error);
//                  }];
//  
//  // Categorize scan result
//  switch (oldScan.contentType) {
//      // Calendar Event
//    case QRTypeCalendarEvent: {
//      NSLog(@"Event: %@", _scannedString);
//      NSDictionary *dic = [_scannedString getEvent];
//      NSString *name = [dic objectForKey:@"name"];
//      NSString *startDate = [dic objectForKey:@"startDate"];
//      NSString *endDate = [dic objectForKey:@"endDate"];
//      NSString *dispStartDate = [SVDateTimeUtil getShortDisplayDateStringFromDate:[SVDateTimeUtil
//                                                                                   getDateFromReverseString:startDate]];
//      NSString *dispEndDate = [SVDateTimeUtil
//                               getShortDisplayDateStringFromDate:
//                               [SVDateTimeUtil getDateFromReverseString:endDate]];
//      [self displayDialogWithImage:[UIImage imageNamed:@"calendar_event"]
//                andBackgroundColor:kYellowCalendarEvent
//                        andMessage:[NSString stringWithFormat:@"Do you want to add this event \"%@\" from %@ to %@ to your calendar?", name, dispStartDate, dispEndDate]
//                              OnOk:^{
//                                [SVEventUtil
//                                 addEventWithName:name
//                                 withStartDate:[SVDateTimeUtil getDateFromReverseString:startDate]
//                                 andEndDate:[SVDateTimeUtil getDateFromReverseString:endDate]];
//                              }
//                          OnCancel:^{
//                          }];
//    } break;
//      
//      // Send Email
//    case QRTypeEmailAddress: {
//      NSString *emailAddress = [_scannedString substringFromIndex:[@"mailto:" length]];
//      [self displayDialogWithImage:[UIImage imageNamed:@"email"]
//                andBackgroundColor:kGreenEmail
//                        andMessage:[NSString stringWithFormat:@"Do you want to send email to this address: %@?", emailAddress]
//                              OnOk:^{
//                                NSURL *url = [NSURL URLWithString:_scannedString];
//                                [[UIApplication sharedApplication] openURL:url];
//                              }
//                          OnCancel:^{
//                          }];
//    } break;
//      
//      // Add contact information
//    case QRTypeContactInformation: {
//      NSDictionary *dic = [_scannedString getContactInfo];
//      NSString *name = [dic objectForKey:@"name"];
//      NSString *email = [dic objectForKey:@"email"];
//      [self displayDialogWithImage:[UIImage imageNamed:@"contact"]
//                andBackgroundColor:kOrangeContact
//                        andMessage:[NSString stringWithFormat:@"Do you want to add this contact: Name: %@ - Email: %@?", name, email]
//                              OnOk:^{
//                                ABNewPersonViewController *vc =
//                                [[ABNewPersonViewController alloc] init];
//                                vc.newPersonViewDelegate = self;
//                                vc.displayedPerson =
//                                [SVContactUtil getPersonWithName:name andEmail:email];
//                                UINavigationController *newNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
//                                [self presentViewController:newNavigationController
//                                                   animated:YES
//                                                 completion:nil];
//                              }
//                          OnCancel:^{
//                          }];
//    } break;
//      
//      // Open map to view a location
//    case QRTypeGeoLocation: {
//      NSString *latLon = [_scannedString substringFromIndex:[@"geo:" length]];
//      if ([latLon rangeOfString:@"?"].location != NSNotFound) {
//        latLon =
//        [latLon substringToIndex:[latLon rangeOfString:@"?"].location];
//      }
//      [self displayDialogWithImage:[UIImage imageNamed:@"url"]
//                andBackgroundColor:kBlueText
//                        andMessage:[NSString stringWithFormat:@"Do you want to search this location on map: [ %@ ]?", latLon]
//                              OnOk:^{
//                                NSURL *url = [NSURL
//                                              URLWithString:[NSString stringWithFormat:
//                                                             @"http://maps.apple.com/?ll=%@",
//                                                             latLon]];
//                                [[UIApplication sharedApplication] openURL:url];
//                              }
//                          OnCancel:^{
//                          }];
//    } break;
//      
//      // Call a phone number
//    case QRTypePhoneNumber: {
//      NSString *phoneNumber =
//      [_scannedString substringFromIndex:[@"tel:" length]];
//      ;
//      [self displayDialogWithImage:[UIImage imageNamed:@"phone"]
//                andBackgroundColor:kGreenPhone
//                        andMessage:[NSString stringWithFormat:
//                                    @"Do you want to call this number: %@?",
//                                    phoneNumber]
//                              OnOk:^{
//                                NSURL *url = [NSURL URLWithString:_scannedString];
//                                [[UIApplication sharedApplication] openURL:url];
//                              }
//                          OnCancel:^{
//                          }];
//    } break;
//      
//      // Load a savvee product
//    case BarcodeSavvee:
//    case QRTypeSavveeProductURL: {
//      [self displayDialogWithImage:[UIImage imageNamed:@"jml_content_small"]
//                andBackgroundColor:[UIColor whiteColor]
//                        andMessage:@"Be Spontaneous. Be JML. Do you want to see the details of this JML product?"
//                              OnOk:^{
//                                NSInteger productId = 0;
//                                if ([_scannedString isBarcodeSavvee]) {
//                                  productId = [_scannedString getProductIdFromBarcode];
//                                } else {
//                                  productId = [_scannedString getProductId];
//                                }
//                                NSLog(@"PRODUCT ID: %ld", (long)productId);
//                                [SVAppProgressing showProgress];
//                                // Load product from server with id retrieved from text
//                                [SVNetworkEngine getProduct:[NSString stringWithFormat:@"%ld", (long)productId]
//                                                  onSuccess:^(NSDictionary *data) {
//                                                    [SVAppProgressing dismissProgress];
//                                                    SVProduct *product = [[SVProduct alloc] initWithDictionary:data];
//                                                    // Go to Product view
//                                                    [self performSegueWithIdentifier:kSegueProductDetailId
//                                                                              sender:product];
//                                                  }
//                                                    onError:^(NSError *error, NSDictionary *data) {
//                                                      [SVAppProgressing dismissProgress];
//                                                      NSString *errorMessage = [data objectForKey:@"error_message"];
//                                                      if (errorMessage && errorMessage.length > 0) {
//                                                        SIAlertView *alertView =
//                                                        [[SIAlertView alloc] initWithTitle:@"JML"
//                                                                                andMessage:errorMessage];
//                                                        [alertView applyStyle];
//                                                        alertView.transitionStyle =
//                                                        SIAlertViewTransitionStyleBounce;
//                                                        [alertView addButtonWithTitle:@"OK"
//                                                                                 type:SIAlertViewButtonTypeDefault
//                                                                              handler:nil];
//                                                        [alertView show];
//                                                      }
//                                                    }];
//                                
//                              }
//                          OnCancel:nil];
//    } break;
//      
//    case QRTypeJMLRegisterWarrantyURL: {
//      [self displayDialogWithImage:[UIImage imageNamed:@"jml_content_small"]
//                andBackgroundColor:[UIColor whiteColor]
//                        andMessage:@"Be Spontaneous. Be JML. Do you want to register warranty of this JML product?"
//                              OnOk:^{
//                                SVWebViewOthersViewController *viewController = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(SVWebViewOthersViewController.class)];
//                                self.scannedString = [_scannedString stringByAppendingString:@"&platform=mobile"];
//                                viewController.urlString = _scannedString;
//                                viewController.titleString = @"Warranty Registration";
//                                [self.navigationController pushViewController:viewController animated:YES];
//                              }
//                          OnCancel:nil];
//      break;
//    }
//      
//      // Send SMS to a number
//    case QRTypeSMS: {
//      NSDictionary *dic = [_scannedString getSMSData];
//      NSString *number = [dic objectForKey:@"number"];
//      NSString *message = [dic objectForKey:@"message"];
//      
//      [self displayDialogWithImage:[UIImage imageNamed:@"phone"]
//                andBackgroundColor:kGreenEmail
//                        andMessage:[NSString
//                                    stringWithFormat:
//                                    @"Do you want to send SMS to this number: %@?",
//                                    number]
//                              OnOk:^{
//                                MFMessageComposeViewController *vc =
//                                [SVSMSUtil getSMSVCWithRecipient:number andMessage:message];
//                                vc.messageComposeDelegate = self;
//                                [self presentViewController:vc animated:YES completion:nil];
//                              }
//                          OnCancel:^{
//                          }];
//    } break;
//      
//      // Open browser and navigate to a URL
//    case QRTypeURL: {
//      [self displayDialogWithImage:[UIImage imageNamed:@"url"]
//                andBackgroundColor:kGreenURL
//                        andMessage:[NSString stringWithFormat:@"Do you want to visit: %@",
//                                    _scannedString]
//                              OnOk:^{
//                                NSURL *url = [NSURL URLWithString:_scannedString];
//                                [[UIApplication sharedApplication] openURL:url];
//                              }
//                          OnCancel:^{
//                          }];
//    } break;
//      
//      // Show a text
//    case QRTypeText: {
//      NSLog(@"Calendar event: %@", _scannedString);
//      [self displayDialogWithImage:[UIImage imageNamed:@"text"]
//                andBackgroundColor:kBlueText
//                        andMessage:[NSString stringWithFormat:@"Do you want to copy this text to clipboard: %@?",
//                                    _scannedString]
//                              OnOk:^{
//                                [SVClipboardUtil copyToClipboard:_scannedString];
//                              }
//                          OnCancel:^{
//                          }];
//    } break;
//  }
}

#pragma mark - Play successful sound
- (void)playSuccessfulSound {
  NSError *error;
  
  // Get audio file path
  NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"scan" ofType:@"wav"];
  
  NSURL *url = [NSURL fileURLWithPath:resourcePath];
  
  AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
  
  if (error) {
    NSLog(@"Cannot init player %@", error);
    return;
  }
  
  // Play the sound
  [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                         error:nil];
  [player prepareToPlay];
  [player setVolume:0.8f];
  player.delegate = self;
  
  // Set number of loop to zero to prevent looping
  player.numberOfLoops = 0;
  [player play];
  AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

#pragma mark - Audio Player Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag {
  [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                         error:nil];
}

#pragma mark - Handle navigation bar buttons click
- (IBAction)historyButtonDidTouch {
  [self performSegueWithIdentifier:kSegueOldScanId sender:nil];
}

- (IBAction)flashButtonDidTouch {
  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  if ([device isTorchAvailable] &&
      [device isTorchModeSupported:AVCaptureTorchModeOn]) {
    BOOL success = [device lockForConfiguration:nil];
    if (success) {
      if (device.torchMode == AVCaptureTorchModeOn) {
        [device setTorchMode:AVCaptureTorchModeOff];
      } else {
        [device setTorchMode:AVCaptureTorchModeOn];
      }
      [device unlockForConfiguration];
      
      [self addButtonsToNavigationBar];
    }
  }
}

#pragma mark - Prepare for segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//  if ([segue.identifier isEqualToString:kSegueProductDetailId]) {
//    ((SVProductViewController *)[segue destinationViewController]).product =
//    sender;
//  } else if ([segue.identifier isEqualToString:kSegueProductListingId]) {
//    ((SVProductListingViewController *)[segue destinationViewController])
//    .category = sender;
//    ((SVProductListingViewController *)[segue destinationViewController])
//    .showSplash = YES;
//  }
}

#pragma mark - Show dialog after QR code is recognized
- (void)displayDialogWithImage:(UIImage *)image
            andBackgroundColor:(UIColor *)color
                    andMessage:(NSString *)message
                          OnOk:(void (^)(void))okBlock
                      OnCancel:(void (^)(void))cancelBlock {
//  SIAlertView *alert = [[SIAlertView alloc] initWithImage:image
//                                       andBackgroundColor:color
//                                               andMessage:message];
//  [alert applyStyle];
//  [alert addButtonWithTitle:@"Cancel"
//                       type:SIAlertViewButtonTypeCancel
//                    handler:^(SIAlertView *alertView) {
//                      if (cancelBlock) {
//                        cancelBlock();
//                      }
//                    }];
//  
//  [alert addButtonWithTitle:@"OK"
//                       type:SIAlertViewButtonTypeDefault
//                    handler:^(SIAlertView *alertView) {
//                      okBlock();
//                    }];
//  [alert show];
}

#pragma mark - SMS View Controller Delegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
  [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - New Contact delegate
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView
       didCompleteWithNewPerson:(ABRecordRef)person {
  [newPersonView.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
