#import <UIKit/UIKit.h>
#import "Tweak.h"

%group SBColors

%hook _UIStatusBarStringView // Other strings

- (void)layoutSubviews { // À changer
    if (enabled) {
        %orig;
        self.textColor = [UIColor purpleColor];
    }
}

%end

%hook _UIStaticBatteryView // CC Battery

- (UIColor*)bodyColor {
    if (enabled) {
        return [UIColor brownColor];
    }
    return %orig;
}

- (UIColor*)fillColor {
    if (enabled) {
        return [UIColor orangeColor];
    }
    return %orig;
}

%end

%hook _UIBatteryView // Battery

- (UIColor*)bodyColor {
    if (enabled) {
        return [UIColor brownColor];
    }
    return %orig;
}

- (UIColor*)fillColor {
    if (enabled) {
        return [UIColor orangeColor];
    }
    return %orig;
}

%end

%hook _UIStatusBarSignalView // LTE bars

- (UIColor*)activeColor {
    if (enabled) {
        return [UIColor greenColor];
    }
    return %orig;
}

- (UIColor*)inactiveColor {
    if (enabled) {
        return [UIColor redColor];
    }
    return %orig;
}

%end

%hook _UIStatusBarWifiSignalView // Wifi icon

- (UIColor*)activeColor {
    if (enabled) {
        return [UIColor cyanColor];
    }
    return %orig;
}

- (UIColor*)inactiveColor {
    if (enabled) {
        return [UIColor blueColor];
    }
    return %orig;
}

%end

%hook _UIStatusBarImageView // Small logos on status bar (Rotation, DND, Alarm...)

- (UIColor*)tintColor {
    if (enabled) {
        return [UIColor yellowColor];
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