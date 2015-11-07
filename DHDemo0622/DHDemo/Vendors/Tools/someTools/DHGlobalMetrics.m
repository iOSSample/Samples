
#import "DHGlobalMetrics.h"
#import <objc/runtime.h>
#import "AFURLResponseSerialization.h"

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

BOOL IsKeyboardVisible() {
    
    UIWindow* window = [AppDelegate appDelegate].window;
    
    UIView* firstResponder = [window findFirstResponder];
    
    if (![firstResponder isKindOfClass: NSClassFromString(@"UIWebBrowserView")]) {
        return !!firstResponder;
    } else {
        return NO;
    }
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
    return ([[UIDevice currentDevice].systemVersion floatValue] >= version);
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
            CGFloat height = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width= height;
        }
        viewHeight = bounds.size.height;
    }
    return viewHeight;
}
//
// 参考: AFHTTPRequestIOperation.m
//
NSString* SNDescriptionForError(NSError* error) {
    DHLog(@"ERROR %@", error);
    
    // TODO: 优化错误的处理方式:
    // 1. 服务器错误
    // 2. 网络错误
    
    // 如果服务器返回了错误，那么就直接显示服务器返回的错误，如果服务器没有返回错误，就使用之前默认的错误文案
    if ([error.userInfo[@"error_msg"] isNonEmpty]) {
        return error.userInfo[@"error_msg"];
    }
    
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        // Note: If new error codes are added here, be sure to document them in the header.
        if (error.code == NSURLErrorTimedOut) {
            return @"服务器连接超时";
            
        } else if (error.code == NSURLErrorNotConnectedToInternet) {
            //            return @"无法连线上网";
            return @"网络连接失败了";
            
        } else {
            return @"网络连接失败了";
        }
    } else if ([error.domain isEqualToString: AFURLResponseSerializationErrorDomain]) {
        if (error.code == NSURLErrorBadURL) {
            return @"URL格式错误";
        } else if (error.code == NSURLErrorBadServerResponse) {
            int statusCode = [error.userInfo[@"status_code"] intValue];
            DHLog(@"服务器错误，错误代码: %d", statusCode);
            return @"";
            
        } else if (error.code == NSURLErrorCannotDecodeContentData) {
            return @"服务器返回数据格式错误";
        }
    }
    return @"网络请求失败";
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