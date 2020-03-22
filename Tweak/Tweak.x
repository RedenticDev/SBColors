#import <UIKit/UIKit.h>
#import "SBColors.h"

%group SBColors

    %hook _UIStatusBarStringView // Other strings

    - (BOOL)_textColorFollowsTintColor {
        return enabled ? YES : %orig;
    }

    - (id)tintColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"stringsColor"], @"#147dfb") : %orig;
    }

    %end

    %hook _UIStaticBatteryView // CC Battery

    - (UIColor*)bodyColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"batteryBodyColor"], @"#147dfb") : %orig;
    }

    - (UIColor*)fillColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"batteryFillColor"], @"#147dfb") : %orig;
    }

    %end

    %hook _UIBatteryView // Battery

    - (UIColor*)bodyColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"batteryBodyColor"], @"#147dfb") : %orig;
    }

    - (UIColor*)fillColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"batteryFillColor"], @"#147dfb") : %orig;
    }

    %end

    %hook _UIStatusBarSignalView // LTE bars

    - (UIColor*)activeColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"LTESignalOnColor"], @"#147dfb") : %orig;
    }

    - (UIColor*)inactiveColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"LTESignalOffColor"], @"#1417fb") : %orig;
    }

    %end

    %hook _UIStatusBarWifiSignalView // Wifi icon

    - (UIColor*)activeColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"wifiOnColor"], @"#147dfb") : %orig;
    }

    - (UIColor*)inactiveColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"wifiOffColor"], @"#1417fb") : %orig;
    }

    %end

    %hook JCESBShapeView // Juice Beta support

    - (UIColor*)statusBarFillColour {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"batteryFillColor"], @"#147dfb") : %orig;
    }

    %end

    %hook _UIStatusBarImageView // Small logos in status bar (Rotation, DND, Alarm...)

    - (UIColor*)tintColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"otherGlyphsColor"], @"#147dfb") : %orig;
    }

    %end

%end

%group PrysmSupport

    %hook UIImageView // Prysm support glyphs

    - (UIColor*)tintColor {
        if ([[self _viewControllerForAncestor] isKindOfClass:%c(PrysmMainPageViewController)]) {
            return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"otherGlyphsColor"], @"#147dfb") : %orig;
        }
        return %orig;
    }

    %end

    %hook UILabel // Prysm support battery label

    - (BOOL)_textColorFollowsTintColor {
        if ([[self _viewControllerForAncestor] isKindOfClass:%c(PrysmMainPageViewController)]) {
            return enabled ? YES : %orig;
        }
        return %orig;
    }

    - (id)tintColor {
        if ([[self _viewControllerForAncestor] isKindOfClass:%c(PrysmMainPageViewController)]) {
            return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"stringsColor"], @"#147dfb") : %orig;
        }
        return %orig;
    }

    %end

%end

%ctor {
    prefs = [[HBPreferences alloc] initWithIdentifier:@"com.redenticdev.sbcolors"];
    [prefs registerBool:&enabled default:YES forKey:@"Enabled"];
    [prefs registerObject:&timeNetworkLTEColorValue default:timeNetworkLTEColorValue forKey:@"stringsColor"];
    [prefs registerObject:&batteryBodyColorValue default:batteryBodyColorValue forKey:@"batteryBodyColor"];
    [prefs registerObject:&batteryFillColorValue default:batteryFillColorValue forKey:@"batteryFillColor"];
    [prefs registerObject:&LTESignalActiveColorValue default:LTESignalActiveColorValue forKey:@"LTESignalOnColor"];
    [prefs registerObject:&LTESignalInactiveColorValue default:LTESignalInactiveColorValue forKey:@"LTESignalOffColor"];
    [prefs registerObject:&WiFiActiveColorValue default:WiFiActiveColorValue forKey:@"wifiOnColor"];
    [prefs registerObject:&WiFiInactiveColorValue default:WiFiInactiveColorValue forKey:@"wifiOffColor"];
    [prefs registerObject:&otherGlyphsColorValue default:otherGlyphsColorValue forKey:@"otherGlyphsColor"];
    if (enabled) {
        %init(SBColors);
        %init(PrysmSupport);
    }
}
