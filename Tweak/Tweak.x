#import "SBColors.h"

%group SBColors

    %hook _UIStatusBarStringView // Labels

        -(BOOL)_textColorFollowsTintColor {
            return YES;
        }

        -(id)tintColor {
            if (self.fontStyle == 1) { // Time label
                return LCPParseColorString(timeColorValue, @"#147dfb");
            } else { // Carrier, LTE, Breadcrumb
                return LCPParseColorString(carrierBreadcrumbLTEColorValue, @"#147dfb");
            }
        }

    %end

    %hook _UIStaticBatteryView // CC Battery - not available in iOS 11

        -(UIColor*)bodyColor {
            return LCPParseColorString(batteryBodyColorValue, @"#147dfb");
        }

        -(UIColor*)fillColor {
            return LCPParseColorString(batteryFillColorValue, @"#147dfb");
        }

        -(UIColor*)pinColor {
            return LCPParseColorString(batteryBodyColorValue, @"#147dfb");
        }

    %end

    %hook _UIBatteryView // Battery

        -(UIColor*)bodyColor {
            return LCPParseColorString(batteryBodyColorValue, @"#147dfb");
        }

        -(UIColor*)fillColor {
            return LCPParseColorString(batteryFillColorValue, @"#147dfb");
        }

        -(UIColor*)pinColor {
            return LCPParseColorString(batteryBodyColorValue, @"#147dfb");
        }

    %end

    %hook _UIStatusBarCellularSignalView // LTE bars

        -(UIColor*)activeColor {
            return LCPParseColorString(LTESignalActiveColorValue, @"#147dfb");
        }

        -(UIColor*)inactiveColor {
            return LCPParseColorString(LTESignalInactiveColorValue, @"#1417fb");
        }

    %end

    %hook _UIStatusBarWifiSignalView // Wifi icon

        -(UIColor*)activeColor {
            return LCPParseColorString(WiFiActiveColorValue, @"#147dfb");
        }

        -(UIColor*)inactiveColor {
            return LCPParseColorString(WiFiInactiveColorValue, @"#1417fb");
        }

    %end

    %hook _UIStatusBarActivityIndicator // Activity Indicator

        -(UIColor*)color {
            return LCPParseColorString(activityIndicatorColorValue, @"#147dfb");
        }

    %end

    %hook _UIStatusBarImageView // Small logos in status bar (Rotation, DND, Alarm...)

        -(UIColor*)tintColor {
            return LCPParseColorString(otherGlyphsColorValue, @"#147dfb");
        }

    %end

    // Other tweaks support
    %hook JCEBatteryView // Juice Beta support

        -(id)statusBarFillColour {
            return LCPParseColorString(batteryFillColorValue, @"#147dfb");
        }

        -(void)setStatusBarFillColour:(id)arg1 {
            %orig(LCPParseColorString(batteryFillColorValue, @"#147dfb"));
        }

    %end

    %hook UIImageView // Prysm support glyphs 

        -(UIColor*)tintColor {
            if ([[self _viewControllerForAncestor] isKindOfClass:%c(PrysmMainPageViewController)]) {
                return LCPParseColorString(otherGlyphsColorValue, @"#147dfb");
            }
            return %orig;
        }

    %end

    %hook UILabel // Prysm support battery label

        -(BOOL)_textColorFollowsTintColor {
            if ([[self _viewControllerForAncestor] isKindOfClass:%c(PrysmMainPageViewController)]) {
                return YES;
            }
            return %orig;
        }

        -(id)tintColor {
            if ([[self _viewControllerForAncestor] isKindOfClass:%c(PrysmMainPageViewController)]) {
                return LCPParseColorString(carrierBreadcrumbLTEColorValue, @"#147dfb");
            }
            return %orig;
        }

    %end

%end

static void initPrefs() {
    HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"com.redenticdev.sbcolors"];
    [prefs registerBool:&enabled default:YES forKey:@"isEnabled"];
    [prefs registerObject:&timeColorValue default:timeColorValue forKey:@"timeColor"];
    [prefs registerObject:&carrierBreadcrumbLTEColorValue default:carrierBreadcrumbLTEColorValue forKey:@"stringsColor"];
    [prefs registerObject:&batteryBodyColorValue default:batteryBodyColorValue forKey:@"batteryBodyColor"];
    [prefs registerObject:&batteryFillColorValue default:batteryFillColorValue forKey:@"batteryFillColor"];
    [prefs registerObject:&LTESignalActiveColorValue default:LTESignalActiveColorValue forKey:@"LTESignalOnColor"];
    [prefs registerObject:&LTESignalInactiveColorValue default:LTESignalInactiveColorValue forKey:@"LTESignalOffColor"];
    [prefs registerObject:&WiFiActiveColorValue default:WiFiActiveColorValue forKey:@"wifiOnColor"];
    [prefs registerObject:&WiFiInactiveColorValue default:WiFiInactiveColorValue forKey:@"wifiOffColor"];
    [prefs registerObject:&activityIndicatorColorValue default:activityIndicatorColorValue forKey:@"activityIndicatorColor"];
    [prefs registerObject:&otherGlyphsColorValue default:otherGlyphsColorValue forKey:@"otherGlyphsColor"];
}

static void reloadPrefs() {
    @autoreleasepool {
        NSDictionary *prefsDict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.redenticdev.sbcolors.plist"];
        if (prefsDict) {
            enabled = [[prefsDict objectForKey:@"isEnabled"] boolValue];
            timeColorValue = [prefsDict objectForKey:@"timeColor"];
            carrierBreadcrumbLTEColorValue = [prefsDict objectForKey:@"stringsColor"];
            batteryBodyColorValue = [prefsDict objectForKey:@"batteryBodyColor"];
            batteryFillColorValue = [prefsDict objectForKey:@"batteryFillColor"];
            LTESignalActiveColorValue = [prefsDict objectForKey:@"LTESignalOnColor"];
            LTESignalInactiveColorValue = [prefsDict objectForKey:@"LTESignalOffColor"];
            WiFiActiveColorValue = [prefsDict objectForKey:@"wifiOnColor"];
            WiFiInactiveColorValue = [prefsDict objectForKey:@"wifiOffColor"];
            activityIndicatorColorValue = [prefsDict objectForKey:@"activityIndicatorColor"];
            otherGlyphsColorValue = [prefsDict objectForKey:@"otherGlyphsColor"];
        }
    }
}

%ctor {
    @autoreleasepool {
        // This code avoid respring loops, only needed if you hook a system process like UIKit or Foundation system wide (in the plist file), also only if you use Cephei
        if (![NSProcessInfo processInfo]) return;
        NSString *processName = [NSProcessInfo processInfo].processName;
        BOOL isSpringboard = [@"SpringBoard" isEqualToString:processName];
        // Someone smarter than Nepeta invented this.
        // https://www.reddit.com/r/jailbreak/comments/4yz5v5/questionremote_messages_not_enabling/d6rlh88/
        BOOL shouldLoad = NO;
        NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
        NSUInteger count = args.count;
        if (count != 0) {
            NSString *executablePath = args[0];
            if (executablePath) {
                NSString *processName = [executablePath lastPathComponent];
                BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;
                BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;
                BOOL skip = [processName isEqualToString:@"AdSheet"]
                || [processName isEqualToString:@"CoreAuthUI"]
                || [processName isEqualToString:@"InCallService"]
                || [processName isEqualToString:@"MessagesNotificationViewService"]
                || [executablePath rangeOfString:@".appex/"].location != NSNotFound;
                if ((!isFileProvider && isApplication && !skip) || isSpringboard) {
                    shouldLoad = YES;
                }
            }
        }
        if (!shouldLoad) return;

        if (enabled) {
            CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR("com.redenticdev.sbcolors/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);

            initPrefs();
            %init(SBColors);
        }
    }
}
