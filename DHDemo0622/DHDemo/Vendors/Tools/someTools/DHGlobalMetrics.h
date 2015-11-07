#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//
//  [UIScreen mainScreen].bounds                        屏幕的宽度(320 * 480， 或者320 * 568）
//  [UIScreen mainScreen].applicationFrame              除去20相似的Status Bar, 如果没有status bar呢???
//  SNNavigationFrame                                   ApplicationFrame中除去 NavigationBar的部分
//  SNToolbarNavigationFrame                            ApplicationFrame中除去上面NavigationBar, 和下面 toolbar之后的部分
//
//  SNUserVisibleViewHeight()                           除去导航栏，以及键盘之外的其他部分
CGRect DHNavigationFrame();
CGFloat DHNavigationFrameHeight();


CGRect DHScreenBounds();

BOOL IsKeyboardVisible();

CGFloat KeyboardHeightForOrientation(UIInterfaceOrientation orientation);

//系统版本是否大于 version
BOOL DHOveriOS(CGFloat version);

// 屏幕的宽度
CGFloat viewWidth();
CGFloat viewHeight();
NSString* SNDescriptionForError(NSError* error);

NSString *GET_STRING(id originData);

CGFloat ToolbarHeightForOrientation(UIInterfaceOrientation orientation);

BOOL IsPad(void);





