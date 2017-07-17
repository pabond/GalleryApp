//
//  BPVView.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPVLoadingView;

@interface BPVView : UIView
@property (nonatomic, strong) IBOutlet BPVLoadingView   *loadingView;
@property (nonatomic, assign) BOOL                      loading;

@end
