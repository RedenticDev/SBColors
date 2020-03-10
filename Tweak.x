#import <UIKit/UIKit.h>
#import "Tweak.h"

%group SBColors

%hook _UIStatusBarStringView

- (void)layoutSubviews { // À changer
    if (enabled) {
        %orig;
        self.textColor = [UIColor redColor];
    }
}

%end

%hook _UIStaticBatteryView

- (UIColor*)bodyColor {
    if (enabled) {
        return [UIColor redColor];
    }
    return %orig;
}

- (UIColor*)fillColor {
    if (enabled) {
        return [UIColor redColor];
    }
    return %orig;
}

%end

%hook _UIStatusBarSignalView

- (UIColor*)activeColor {
    if (enabled) {
        return [UIColor redColor];
    }
    return %orig;
}

- (UIColor*)inactiveColor {
    if (enabled) {
        return [UIColor greenColor];
    }
    return %orig;
}

%end

%hook _UIStatusBarWifiSignalView

- (UIColor*)activeColor {
    if (enabled) {
        return [UIColor redColor];
    }
    return %orig;
}

- (UIColor*)inactiveColor {
    if (enabled) {
        return [UIColor greenColor];
    }
    return %orig;
}

%end

%hook _UIStatusBarImageView

- (UIColor*)tintColor {
    if (enabled) {
        return [UIColor redColor];
    }
    return %orig;
}

%end

%end

%ctor {
    prefs = [[HBPreferences alloc] initWithIdentifier:@"com.redenticdev.sbcolors"];
    [prefs registerBool:&enabled default:YES forKey:@"Enabled"];
    if (enabled) {
        %init(SBColors);
    }
}