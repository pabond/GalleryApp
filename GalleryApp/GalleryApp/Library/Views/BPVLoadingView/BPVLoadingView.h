//
//  BPVLoadingView.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BPVCompletionBlock)(void);

@interface BPVLoadingView : UIView
@property (nonatomic, assign) BOOL                              visible;
@property (nonatomic, strong) IBOutlet UILabel                  *label;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView  *spinner;

+ (id)loadingViewInSuperview:(UIView *)superview;

- (void)setVisible:(BOOL)visible animated:(BOOL)animated;
- (void)setVisible:(BOOL)visible animated:(BOOL)animated completionBlock:(BPVCompletionBlock)completionBlock;

@end
