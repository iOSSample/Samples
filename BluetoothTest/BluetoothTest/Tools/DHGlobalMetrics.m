
#import "DHGlobalMetrics.h"
#import <objc/runtime.h>


CGRect DHScreenBounds() {
    // 屏幕的大小（相对于当前的Orientation)
    CGRect bounds = [UIScreen mainScreen].bounds;
    UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;

    if (UIInterfaceOrientationIsLandscape(orient)) {
        CGFloat width = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = width;
    }
    return bounds;
}



CGFloat KeyboardHeightForOrientation(UIInterfaceOrientation orientation) {
    return UIInterfaceOrientationIsPortrait(orientation) ? 216: 160;
}

CGRect DHNavigationFrame() {
    // application所在Rect的高度
    //    CGRect frame = ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) ? [UIScreen mainScreen].bounds : [UIScreen mainScreen].applicationFrame;
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat toolbarHeight = ToolbarHeightForOrientation(orient);
    
    CGRect rect =  CGRectMake(0, 0, frame.size.width, frame.size.height - toolbarHeight);
    // DHLog(@"SNNavigationFrame Height: %.1f", rect.size.height);
    
    return rect;
}

CGFloat DHNavigationFrameHeight() {
    return DHNavigationFrame().size.height;
}



BOOL DHOveriOS(CGFloat version) {
    return ([[UIDevice currentDevice].systemVersion floatValue] > version);
}


CGFloat viewWidth() {
    static CGFloat viewWidth = 0;
    if (viewWidth == 0) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;

        if (UIInterfaceOrientationIsLandscape(orient)) {
            CGFloat width = bounds.size.width;
            bounds.size.width = bounds.size.height;
            bounds.size.height = width;
        }
        viewWidth = bounds.size.width;
    }
    return viewWidth;
}

CGFloat viewHeight() {
    static CGFloat viewHeight = 0;
    if (viewHeight == 0) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;
        
        if (UIInterfaceOrientationIsLandscape(orient)) {
            CGFloat width = bounds.size.width;
            bounds.size.width = bounds.size.height;
            bounds.size.height = width;
        }
        viewHeight = bounds.size.height;
    }
    return viewHeight;
}

NSString *GET_STRING(id originData) {
    if (!originData || [originData isKindOfClass: [NSNull class]]) {
        return @"";
    } else {
        return [NSString stringWithFormat: @"%@", originData];
    }
}

CGFloat ToolbarHeightForOrientation(UIInterfaceOrientation orientation) {
    return (IsPad()
            ? 44
            : (UIInterfaceOrientationIsPortrait(orientation)
               ? 44
               : 33));
}
BOOL IsPad(void) {
    static NSInteger isPad = -1;
    if (isPad < 0) {
        isPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 1 : 0;
    }
    return isPad > 0;
}