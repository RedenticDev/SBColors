#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import "libcolorpicker.h"

// Switches
BOOL enabled = YES;

// Color definitions
NSString* timeColorValue = @"#147dfb";
NSString* carrierBreadcrumbLTEColorValue = @"#147dfb";
NSString* batteryBodyColorValue = @"#147dfb";
NSString* batteryFillColorValue = @"#147dfb";
NSString* LTESignalActiveColorValue = @"#147dfb";
NSString* LTESignalInactiveColorValue = @"#1417fb";
NSString* WiFiActiveColorValue = @"#147dfb";
NSString* WiFiInactiveColorValue = @"#1417fb";
NSString* activityIndicatorColorValue = @"#147dfb";
NSString* otherGlyphsColorValue = @"#147dfb";

// Interfaces
@interface _UIStatusBarStringView : UILabel
@property (assign, nonatomic) long long fontStyle;
@end

@interface _UIBatteryView : UIView
@property (nonatomic, copy) UIColor* bodyColor;
@property (nonatomic, copy) UIColor* fillColor;
@property (nonatomic, copy) UIColor* pinColor;
@end

@interface _UIStaticBatteryView : _UIBatteryView
@end

@interface _UIStatusBarSignalView : UIView
@property (nonatomic, copy) UIColor* inactiveColor;
@property (nonatomic, copy) UIColor* activeColor;
@end

@interface _UIStatusBarCellularSignalView : _UIStatusBarSignalView
@end

@interface _UIStatusBarWifiSignalView : _UIStatusBarSignalView
@end

@interface _UIStatusBarActivityIndicator : UIActivityIndicatorView
@end

@interface _UIStatusBarImageView : UIImageView
@property (nonatomic, retain) UIColor* tintColor;
@end


@interface UIImageView (SBColors)
-(id)_viewControllerForAncestor;
@end

@interface UILabel (SBColors)
-(id)_viewControllerForAncestor;
@end
