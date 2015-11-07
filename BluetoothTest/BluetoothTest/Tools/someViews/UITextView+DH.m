//
//  UITextView+DH.m
//  DHDemo
//
//  Created by 51Talk Mac Air on 15/3/20.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "UITextView+DH.h"
#import <objc/runtime.h>

static const void *placeHolderStringKey = (void *)@"placeHolderString";
static const void *placeHolderLabelKey = (void *)@"placeHolderLabelKey";

@implementation UITextView (DH)

- (void) setPlaceHolder:(NSString *)placeHolder {
    objc_setAssociatedObject(self, placeHolderStringKey, placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*) placeHolder {
    return objc_getAssociatedObject(self, placeHolderStringKey);
}


- (void) setShowPlaceHolder:(BOOL)showPlaceHolder {
    UILabel *placeHolderLabel = objc_getAssociatedObject(self, placeHolderLabelKey);
    if (!placeHolderLabel) {
        placeHolderLabel = [[UILabel alloc] initWithFrame: CGRectInset(self.bounds, 3, 3)];
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.contentMode = UIViewContentModeTop;
        placeHolderLabel.backgroundColor = [UIColor clearColor];
//        placeHolderLabel.font = self.font;
        placeHolderLabel.font = [UIFont systemFontOfSize:15];

        placeHolderLabel.textColor = RGBCOLOR_HEX(0xc5c5c5);
        placeHolderLabel.text = self.placeHolder;
        objc_setAssociatedObject(self, placeHolderLabelKey, placeHolderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self addSubview: placeHolderLabel];
    }
    
    placeHolderLabel.text = self.placeHolder;
    placeHolderLabel.width = self.width-6;
    [placeHolderLabel sizeToFit];
    placeHolderLabel.top = 7;
    placeHolderLabel.hidden = !showPlaceHolder;
}

- (BOOL) showPlaceHolder {
    return NO;
}
@end
