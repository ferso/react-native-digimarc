//
//  ReactView.h
//  demoDigimarc
//
//  Created by Phat Chiem on 4/10/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface ReactView : UIView
@property (nonatomic, copy) RCTBubblingEventBlock onChange;
@end
