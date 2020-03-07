#import <UIKit/UIKit.h>

@interface _UIStatusBarPersistentAnimationView : UIView
@end

@interface _UIStatusBarSignalView : _UIStatusBarPersistentAnimationView
@property (nonatomic,copy) UIColor * inactiveColor;
@property (nonatomic,copy) UIColor * activeColor;
@end

@interface _UIStatusBarWifiSignalView : _UIStatusBarSignalView
@end

@interface _UIStatusBarStringView : UILabel
@end

@interface _UIBatteryView : UIView
@end

@interface _UIStaticBatteryView : _UIBatteryView
@property (nonatomic, copy, readwrite) UIColor *bodyColor;
@property (nonatomic, copy, readwrite) UIColor *fillColor;
@end


%hook _UIStatusBarStringView

- (void)layoutSubviews {
    %orig;
    self.textColor = [UIColor redColor];
}

%end

%hook _UIStaticBatteryView

- (void)layoutSubviews {
    %orig;
    self.bodyColor = [UIColor redColor];
    self.fillColor = [UIColor redColor];
}

%end

%hook _UIStatusBarWifiSignalView

- (void)layoutSubviews {
    %orig;
    self.activeColor = [UIColor greenColor];
    self.inactiveColor = [UIColor cyanColor];
}

%end