#import <UIKit/UIKit.h>
#import "SBColors.h"

%group SBColors

    %hook _UIStatusBarStringView // Other strings

    - (BOOL)_textColorFollowsTintColor {
        return enabled ? YES : %orig;
    }

    - (id)tintColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"stringsColor"], @"#147efb") : %orig;
    }

    %end

    %hook _UIStaticBatteryView // CC Battery

    - (UIColor*)bodyColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"batteryBodyColor"], @"#147efb") : %orig;
    }

    - (UIColor*)fillColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"batteryFillColor"], @"#147efb") : %orig;
    }

    %end

    %hook _UIBatteryView // Battery

    - (UIColor*)bodyColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"batteryBodyColor"], @"#147efb") : %orig;
    }

    - (UIColor*)fillColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"batteryFillColor"], @"#147efb") : %orig;
    }

    %end

    %hook _UIStatusBarSignalView // LTE bars

    - (UIColor*)activeColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"LTESignalOnColor"], @"#147efb") : %orig;
    }

    - (UIColor*)inactiveColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"LTESignalOffColor"], @"#1417fb") : %orig;
    }

    %end

    %hook _UIStatusBarWifiSignalView // Wifi icon

    - (UIColor*)activeColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"wifiOnColor"], @"#147efb") : %orig;
    }

    - (UIColor*)inactiveColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"wifiOffColor"], @"#1417fb") : %orig;
    }

    %end

    %hook JCESBShapeView // Juice Beta support

    - (UIColor*)statusBarFillColour {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"batteryFillColor"], @"#147efb") : %orig;
    }

    %end

    %hook _UIStatusBarImageView // Small logos in status bar (Rotation, DND, Alarm...)

    - (UIColor*)tintColor {
        return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"otherGlyphsColor"], @"#147efb") : %orig;
    }

    %end

%end

%group PrysmSupport

    %hook UIImageView // Prysm support glyphs

    - (UIColor*)tintColor {
        if ([[self _viewControllerForAncestor] isKindOfClass:%c(PrysmMainPageViewController)]) {
            return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"otherGlyphsColor"], @"#147efb") : %orig;
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
            return enabled ? LCPParseColorString([[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"] objectForKey:@"stringsColor"], @"#147efb") : %orig;
        }
        return %orig;
    }

    %end

%end

%ctor {
    // Avoids respring loops
    if (![NSProcessInfo processInfo]) return;
    NSString *processName = [NSProcessInfo processInfo].processName;
    bool isSpringboard = [@"SpringBoard" isEqualToString:processName];
    // Someone smarter than Nepeta invented this.
    // https://www.reddit.com/r/jailbreak/comments/4yz5v5/questionremote_messages_not_enabling/d6rlh88/
    bool shouldLoad = NO;
    NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
    NSUInteger count = args.count;
    if (count != 0) {
        NSString *executablePath = args[0];
        if (executablePath) {
            NSString *processName = [executablePath lastPathComponent];
            BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;
            BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;
            BOOL skip = [processName isEqualToString:@"AdSheet"] || [processName isEqualToString:@"CoreAuthUI"] || [processName isEqualToString:@"InCallService"] || [processName isEqualToString:@"MessagesNotificationViewService"] || [executablePath rangeOfString:@".appex/"].location != NSNotFound;
            if ((!isFileProvider && isApplication && !skip) || isSpringboard) {
                shouldLoad = YES;
            }
        }
    }
    if (!shouldLoad) return;
    

    prefs = [[HBPreferences alloc] initWithIdentifier:@"com.redenticdev.sbcolors"];
    [prefs registerBool:&enabled default:YES forKey:@"Enabled"];
    [prefs registerObject:&timeNetworkLTEColorValue default:@"147efb" forKey:@"stringsColor"];
    [prefs registerObject:&batteryBodyColorValue default:@"147efb" forKey:@"batteryBodyColor"];
    [prefs registerObject:&batteryFillColorValue default:@"147efb" forKey:@"batteryFillColor"];
    [prefs registerObject:&LTESignalActiveColorValue default:@"147efb" forKey:@"LTESignalOnColor"];
    [prefs registerObject:&LTESignalInactiveColorValue default:@"1417fb" forKey:@"LTESignalOffColor"];
    [prefs registerObject:&WiFiActiveColorValue default:@"147efb" forKey:@"wifiOnColor"];
    [prefs registerObject:&WiFiInactiveColorValue default:@"1417fb" forKey:@"wifiOffColor"];
    [prefs registerObject:&otherGlyphsColorValue default:@"147efb" forKey:@"otherGlyphsColor"];
    if (enabled) {
        %init(SBColors);
        %init(PrysmSupport);
    }
}