//
//  BPVView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVView.h"

#import "BPVLoadingView.h"
#import "BPVMacro.h"

@interface BPVView ()

- (BPVLoadingView *)defaultLoadingView;

@end

@implementation BPVView

@dynamic loading;

#pragma mark -
#pragma mark Initialastions and deallocations

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.loadingView = [self defaultLoadingView];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.loadingView) {
        self.loadingView = [BPVLoadingView loadingViewInSuperview:self];
    }
}

#pragma mark -
#pragma mark Accessors

- (void)setLoadingView:(BPVLoadingView *)loadingView {
    if (_loadingView != loadingView) {
        [_loadingView removeFromSuperview];
        
        _loadingView = loadingView;
        
        if (loadingView) {
            [self addSubview:loadingView];
        }
    }
}

- (void)setLoading:(BOOL)loading {
    BPVWeakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        BPVStrongifyAndReturnIfNil(self)
        [self.loadingView setVisible:loading animated:YES];
    });
}

- (BOOL)loading {
    return self.loadingView.visible;
}

#pragma mark -
#pragma mark Public implementations

- (BPVLoadingView *)defaultLoadingView {
    return [BPVLoadingView loadingViewInSuperview:self];
}

@end
