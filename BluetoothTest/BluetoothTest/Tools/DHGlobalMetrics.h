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

CGFloat KeyboardHeightForOrientation(UIInterfaceOrientation orientation);

//系统版本是否大于 version
BOOL DHOveriOS(CGFloat version);

// 屏幕的宽度
CGFloat viewWidth();
//屏幕的 高度
CGFloat viewHeight();

NSString *GET_STRING(id originData);

CGFloat ToolbarHeightForOrientation(UIInterfaceOrientation orientation);

BOOL IsPad(void);

typedef enum {
    SET_COMMAND = 0x61,
    GET_COMMAND = 0x62
}OPERATION_COMMAND_STATE;

typedef enum {
    VOLTAGE_COMMAND = 0x01,
    RECORE_COMMAND = 0x02,
    NDFI_COMMAND = 0x04,
    ADFI_COMMAND = 0x05,
    AC_COMMAND = 0x06,
    AD_COMMAND = 0x07,
    MONITOR_COMMAND = 0x08,
    ADVINTV_COMMAND = 0x09,
    AUTHO_COMMAD = 0x0b,
    PW_COMMAND = 0x0c,
    CLEINTV_COMMAND = 0x0d,
    CLENUM_COMMAND = 0x0e,
    NAME_COMMAND = 0x0F,
    DISCONNECT_COMMAND = 0x12,
    
    SN_COMMAND = 0x13,
    VERSION_COMMAND = 0x14,
    CLET_ID = 0x15,
    
    DATE_COMAND = 0x16,//new
    
    DATA_COMAND = 0x63,
    
}OBJECT_COMMAND_STATE;

typedef enum {
    MONITOR_START = 0x01,
    MONITOR_STOP = 0x03
}MONITOR_STATE;

