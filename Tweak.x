#import <UIKit/UIKit.h>
#import "Tweak.h"

%group SBColors

%hook _UIStatusBarStringView // Other strings

- (BOOL)_textColorFollowsTintColor {
    return enabled ? YES : %orig;
}

-(id)tintColor {
    return enabled ? [UIColor purpleColor] : %orig;
}

%end

%hook _UIStaticBatteryView // CC Battery

- (UIColor*)bodyColor {
    return enabled ? [UIColor brownColor] : %orig;
}

- (UIColor*)fillColor {
    return enabled ? [UIColor orangeColor] : %orig;
}

%end

%hook _UIBatteryView // Battery

- (UIColor*)bodyColor {
    return enabled ? [UIColor brownColor] : %orig;
}

- (UIColor*)fillColor {
    return enabled ? [UIColor orangeColor] : %orig;
}

%end

%hook _UIStatusBarSignalView // LTE bars

- (UIColor*)activeColor {
    return enabled ? [UIColor greenColor] : %orig;
}

- (UIColor*)inactiveColor {
    return enabled ? [UIColor redColor] : %orig;
}

%end

%hook _UIStatusBarWifiSignalView // Wifi icon

- (UIColor*)activeColor {
    return enabled ? [UIColor cyanColor] : %orig;
}

- (UIColor*)inactiveColor {
    return enabled ? [UIColor blueColor] : %orig;
}

%end

%hook JCESBShapeView // Juice Beta support

- (UIColor*)statusBarFillColour {
    return enabled ? [UIColor orangeColor] : %orig;
}

%end

%hook _UIStatusBarImageView // Small logos in status bar (Rotation, DND, Alarm...)

- (UIColor*)tintColor {
    return enabled ? [UIColor yellowColor] : %orig;
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