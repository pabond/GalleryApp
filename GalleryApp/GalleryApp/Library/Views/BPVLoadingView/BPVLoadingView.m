//
//  BPVLoadingView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoadingView.h"
#import "NSBundle+BPVExtensions.h"

#import "BPVMacro.h"

BPVConstant(CGFloat, kBPVAnimationDuration, 0.8f);
BPVConstant(CGFloat, kBPVUpperAlfa, 1.f);
BPVConstant(CGFloat, kBPVLowerAlfa, 0.f);

@implementation BPVLoadingView

#pragma mark -
#pragma mark Class Methods

+ (id)loadingViewInSuperview:(UIView *)superview {
    BPVLoadingView *loadingView = [NSBundle objectWithClass:[self class]];
    loadingView.frame = superview.bounds;
    loadingView.autoresizingMask =  UIViewAutoresizingFlexibleWidth
                                    | UIViewAutoresizingFlexibleHeight;
    
    return loadingView;
}

#pragma mark -
#pragma mark Initializations / deallocations

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [super setAlpha:kBPVLowerAlfa];
}

#pragma mark -
#pragma mark Accessors

- (void)setVisible:(BOOL)visible {
    [self setVisible:visible animated:NO];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated {
    [self setVisible:visible animated:animated completionBlock:nil];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated completionBlock:(BPVCompletionBlock)completionBlock {
    if (_visible != visible) {
        if (visible) {
            _visible = visible;
        }
        
        [UIView animateWithDuration:animated ? kBPVAnimationDuration : 0
                         animations:^{
                             self.alpha = visible ? kBPVUpperAlfa : kBPVLowerAlfa;
                         }
         
                         completion:^(BOOL finished) {
                             _visible = visible;
                             
                             if (completionBlock) {
                                 completionBlock();
                             }
                         }];
    }
}

@end
